collection @courses

extends "courses/_base_course"

node (:short_description) do |course| 
    if course.description
      course.description[0,100]
    else
      nil
    end
end
