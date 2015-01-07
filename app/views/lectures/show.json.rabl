object @lecture

attributes :lecture_no, :title, :content, :date, :overview, :course_id, :video_file_name, :slide_file_name, :strategies

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

node(:subtitles) do |lecture|
  if lecture[:subtitles]
    lecture[:subtitles]
  else
    [{}]
  end
end

node (:slide_time) do |lecture|
  if lecture[:slide_time]
    lecture[:slide_time]
  else
    [{}]
  end
end

node (:total_duration) do |lecture|
  if lecture[:total_duration]
    lecture[:total_duration]
  else
    1800
  end
end