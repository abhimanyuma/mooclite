object @course

extends "courses/_base_course"

attributes :description

node do |course|
  {
  lectures: course.list_lectures
  }
end