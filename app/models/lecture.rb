class Lecture < ActiveRecord::Base

  belongs_to :course

  has_attached_file :video
  validates_attachment_content_type :video, :content_type => ['video/mp4']
  has_attached_file :slide
  validates_attachment_content_type :slide, :content_type => ['application/pdf']

  after_save :set_attach_hash

  ## Set the Lecture number after creation, this is important since lectures are even indexed by
  before_create :set_lecture_number

  after_commit :add_to_queue

  def set_lecture_number
    lecture_num_max = Lecture.where(:course_id => self.course_id).pluck(:lecture_no).max
    if lecture_num_max == nil
      self.lecture_no = 1
    else
      self.lecture_no = lecture_num_max + 1
    end
  end

  def set_attach_hash
    self.video_fingerprint = self.video.fingerprint
    self.slide_fingerprint = self.slide.fingerprint
  end

  def add_to_queue
    new_submission = {}
    new_submission[:id] = self.id
    new_submission[:status] = $process_statuses[:UNPROCESSED]
    $redis.rpush('process_queue',new_submission.to_json)
  end

end
