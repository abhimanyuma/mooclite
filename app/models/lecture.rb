class Lecture

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Paperclip

  include LecturesHelper

  field :id
  field :title, type: String
  field :content, type: String
  field :date, type: String
  field :overview, type: String
  field :short_code, type: String
  field :lecture_no, type: Integer
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
  field :strategies, type: Hash

  belongs_to :course

  has_mongoid_attached_file :video
  validates_attachment_content_type :video, :content_type => ['video/mp4']
  has_mongoid_attached_file :slide
  validates_attachment_content_type :slide, :content_type => ['application/pdf']

  before_create :add_short_code
  before_create :set_lecture_number

  def major_attributes
    reply = {}
    reply[:title] = self.title
    reply[:overview] = self.overview
    reply[:date] = self.date
    reply[:lecture_no] = self.lecture_no
    reply[:short_code] = self.short_code
    reply[:id] = self.id.to_s
    reply
  end

  def subtiltes
    if self[:subtitles]
      self[:subtiltes]
    else
      [{}]
    end
  end

  def slide_time
    if self[:slide_time]
      self[:slide_time]
    else
      [{}]
    end
  end

end
