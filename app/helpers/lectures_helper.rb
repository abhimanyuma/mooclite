module LecturesHelper

  module STATUS
    FORCE = -10
    UNPROCESSED = 0
    RESOLUTIONS_PROCESSED = 10
    SILENT_RESOLUTIONS_PROCESSED = 20
    FRAMES_EXTRACTED = 30
    STARTED = 0
    COMPLETED = 1
  end

  module RANDOM_LIMITS
    BASE62 = 56800235584
  end

  module RESOLUTIONS
    VERTICAL = [1080,768,720,600,540,480,360]
    SILENT_VERTICAL = [480,360]
  end

  module FULL_VIDEO
    DEFAULT_VIDEO_OPTIONS = {
      :video_codec        => "libx264",
      :video_bitrate      => 144,
      :x264_vprofile      => "high",
      :audio_codec        => "aac",
      :audio_bitrate      => 32,
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
      :custom             => "-strict experimental",
    }


    DEFAULT_VIDEO_ONLY_OPTIONS = "-vcodec copy -an"

    EXTRACT_FRAMES_OPTIONS = "-vf 'select=eq(pict_type\,I),showinfo' -vsync 0"
  end

  module FULL_AUDIO
    AAC_OPTIONS = {
      :audio_codec        => "aac",
      :audio_bitrate      => 32,
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
      :custom             => "-strict experimental -vn",
    }

    OPUS_OPTIONS = {
      :audio_codec        => "libopus",
      :custom             => "-vn",
    }

    MP3_OPTIONS = {
      :audio_codec        => "libmp3lame",
      :audio_bitrate      => 32,
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
      :custom             => "-strict experimental -vn",
    }

    MAPPING = {
      "aac" => "aac",
      "libopus" => "opus",
      "libmp3lame" => "mp3"
    }
  end

  def add_short_code

    begin
      random_number = SecureRandom.random_number(RANDOM_LIMITS::BASE62)
      random_string = random_number.base62_encode
    end until Lecture.where(short_code: random_string).count == 0
    self.short_code = random_string

  end

  def set_lecture_number
    lecture_num_max = Lecture.where(:course_id => self.course_id).pluck(:lecture_no).max
    if lecture_num_max == nil
      self.lecture_no = 1
    else
      self.lecture_no = lecture_num_max + 1
    end
  end


  def full_video_individual (lecture_video,resolution,dir)

    height   = lecture_video.height.to_i
    width    = lecture_video.width.to_i
    key      = "full_video_#{resolution}"

    if File.directory?(dir) && File.writable?(dir)

      if height<resolution
        puts "VIDEO RESOLUTION NOT ENOUGH EXITING"
      elsif self.strategies[key] && self.strategies[key][:status] == STATUS::COMPLETED
        puts "ALREADY DONE MOVING ON"
      else

        video_options = FULL_VIDEO::DEFAULT_VIDEO_OPTIONS.dup

        res_height = resolution
        res_width = ((width*res_height)/(2*height))*2
        resolution_string = "#{res_width}x#{res_height}"
        video_options = video_options.merge({:resolution => resolution_string})

        file_name = "#{resolution}.mp4"
        print "Conversion of #{height}p video to #{res_height}p video progressing"



        self.strategies[key] = {}
        self.strategies[key][:text] = "Full video at #{resolution}p with audio"
        self.strategies[key][:status] = STATUS::STARTED

        self.save

        file_path = File.join(dir,file_name)


        lecture_video.transcode(file_path,video_options) do |progress|
          print "."
        end

        transcoded_video =  FFMPEG::Movie.new(file_path)


        self.strategies[key][:browser] = [9,4,4,4]
        self.strategies[key][:score] = resolution/10
        self.strategies[key][:bandwidth] = transcoded_video.size/transcoded_video.duration
        self.strategies[key][:video_url] = file_path
        self.strategies[key][:slide_url] = self.slide.path
        self.strategies[key][:status] = STATUS::COMPLETED
        self.save

      end
    else

      puts "Directory not writable"

    end

  end


  def full_audio_individual (lecture_video,method,dir)

    file_type = FULL_AUDIO::MAPPING[method[:audio_codec]]
    key      = "full_audio_#{file_type}"

    if File.directory?(dir) && File.writable?(dir)

      if self.strategies[key] && self.strategies[key][:status] == STATUS::COMPLETED
        puts "ALREADY DONE MOVING ON"
      else

        audio_options = method

        file_name = "lecture.#{file_type}"
        print "Conversion of video to audio of type #{file_type} progressing"



        self.strategies[key] = {}
        self.strategies[key][:text] = "Only audio of #{file_type} format "
        self.strategies[key][:status] = STATUS::STARTED

        self.save

        file_path = File.join(dir,file_name)


        lecture_video.transcode(file_path,audio_options) do |progress|
          print "."
        end

        transcoded_audio =  FFMPEG::Movie.new(file_path)


        self.strategies[key][:browser] = [9,4,4,4]
        self.strategies[key][:score] = 10
        self.strategies[key][:bandwidth] = transcoded_audio.size/transcoded_audio.duration
        self.strategies[key][:audio_url] = file_path
        self.strategies[key][:status] = STATUS::COMPLETED
        self.save

      end
    else

      puts "Directory not writable"

    end

  end

  def full_video

    #If the video has the same fingerprint as the processed video then
    #don't process unless the processing forcing is set
    if (self.video_fingerprint == self[:full_video_fingerprint]) &&
       (self.process_status != STATUS::FORCE)
       return nil
    end

    lecture_video = FFMPEG::Movie.new(self.video.path)
    #Return if the video is invalid
    return nil unless lecture_video.valid?

    base_dir = File.join(lecture_video.path.split("/")[0..-3])
    curr_dir = File.join(base_dir,"current")


    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    sizes = RESOLUTIONS::VERTICAL.dup
    sizes.push lecture_video.height
    sizes = sizes.uniq

    sizes.each do |size|
      full_video_individual(lecture_video,size,curr_dir)
    end

    self[:full_video_fingerprint] = self.video_fingerprint
    self.save

  end

  def full_audio

    #If the video has the same fingerprint as the processed video then
    #don't process unless the processing forcing is set
    if (self.video_fingerprint == self[:full_audio_fingerprint]) &&
       (self.process_status != STATUS::FORCE)
       return nil
    end

    lecture_video = FFMPEG::Movie.new(self.video.path)
    #Return if the video is invalid
    return nil unless lecture_video.valid?

    base_dir = File.join(lecture_video.path.split("/")[0..-3])
    curr_dir = File.join(base_dir,"current")


    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    methods = [FULL_AUDIO::AAC_OPTIONS,FULL_AUDIO::OPUS_OPTIONS,FULL_AUDIO::MP3_OPTIONS]

    methods.each do |method|
      full_audio_individual(lecture_video,method,curr_dir)
    end

    self[:full_audio_fingerprint] = self.video_fingerprint
    self.save

  end


  def formatize
    full_video
    full_audio
  end

end