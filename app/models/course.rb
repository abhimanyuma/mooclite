class Course < ActiveRecord::Base

  validates_presence_of :name, :presence => true
  validates_presence_of :offered_by, :bio , :unless => proc {new_record?}
end
