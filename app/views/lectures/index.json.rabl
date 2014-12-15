collection @lectures

attributes :lecture_no, :title, :overview , :short_code, :date

node do |lecture|
  {
    id: lecture.id.to_s
  }
end