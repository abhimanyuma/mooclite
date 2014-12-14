attributes :name, :offered_by, :bio

node do |course|
  {
    id: course.id_string
  }
end