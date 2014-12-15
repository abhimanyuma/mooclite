object @lecture

attributes :lecture_no, :title, :content, :date, :overview, :course_id, :video_file_name, :slide_file_name

node do |lecture|
 {
  id: lecture.id.to_s
 }
end

node (:video_url) do |lecture|
    if lecture.video?
      lecture.video.url
    else
      ""
    end
end

node (:slide_url) do |lecture|
    if lecture.slide?
      lecture.slide.url
    else
      ""
    end
end