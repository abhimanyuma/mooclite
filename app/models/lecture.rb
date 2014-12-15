class Lecture

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Paperclip

  field :_id, type: BigDecimal, default: -> {id.to_i.parameterize}

  include LecturesHelper

  field :id, type: BigDecimal
  field :title, type: String
  field :instructor_id, type: BigDecimal
  field :content, type: String
  field :date, type: String
  field :overview, type: String
  field :lecture_no, type: BigDecimal
  field :video_file_name, type: String
  field :video_content_type, type: String
  field :video_file_size, type: String
  field :video_updated_at, type: String
  field :slide_file_name, type: String
  field :slide_content_type, type: String
  field :slide_file_size, type: String
  field :slide_updated_at, type: String
  field :video_fingerprint, type: String
  field :slide_fingerprint, type: String
  field :processed_video_fingerprint, type: String
  field :process_status, type: String

  embedded_in :course

  has_mongoid_attached_file :video
  validates_attachment_content_type :video, :content_type => ['video/mp4']
  has_mongoid_attached_file :slide
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

  def as_json(options={})
    reply = super(options.merge(
        methods: [:id_string],
        only: [:key, :secret]
      ))
    reply["id"] = reply["id_string"]
    reply.delete("id_string")
    reply
  end

  def id_string
    return id.to_s
  end

end
