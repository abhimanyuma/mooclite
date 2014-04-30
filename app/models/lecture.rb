class Lecture < ActiveRecord::Base

  belongs_to :course

  has_attached_file :video
  validates_attachment_content_type :video, :content_type => ['video/mp4']

  has_attached_file :slide
  validates_attachment_content_type :slide, :content_type => ['application/pdf']

end
