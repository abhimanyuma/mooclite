class Lecture < ActiveRecord::Base

  belongs_to :course

  has_attached_file :video

  has_attached_file :slide

end
