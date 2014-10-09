module LecturesHelper
  module STATUS
    FORCE = -10
    UNPROCESSED = 0
    RESOLUTIONS_PROCESSED = 10
    SILENT_RESOLUTIONS_PROCESSED = 20
    FRAMES_EXTRACTED = 30
  end

  module RESOLUTIONS
    VERTICAL = [1080,768,720,600,540,480,360]
    SILENT_VERTICAL = [480,360]
  end

  module TRANSCODER
    DEFAULT_VIDEO_OPTIONS = {
      :video_codec        => "libx264",
      :video_bitrate      => 144,
      :x264_vprofile      => "high",
      :audio_codec        => "libvo_aacenc",
      :audio_bitrate      => 32,
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
    }

    DEFAULT_VIDEO_ONLY_OPTIONS = "-vcodec copy -an"

    EXTRACT_FRAMES_OPTIONS = "-vf 'select=eq(pict_type\,I),showinfo' -vsync 0"
  end

  def resolution_formatize (lecture_video,resolution,dir)

    height   = lecture_video.height.to_i
    width    = lecture_video.width.to_i


    if File.directory?(dir) && File.writable?(dir)

      if height<resolution
        puts "VIDEO RESOLUTION NOT ENOUGH EXITING"
      else

        video_options = TRANSCODER::DEFAULT_VIDEO_OPTIONS.dup

        res_height = resolution
        res_width = ((width*res_height)/(2*height))*2
        resolution_string = "#{res_width}x#{res_height}"
        video_options = video_options.merge({:resolution => resolution_string})

        file_name = "#{resolution}.mp4"
        print "Conversion of #{height}p video to #{res_height}p video progressing"

        lecture_video.transcode(File.join(dir,file_name),video_options) do |progress|
          print "."
        end

        print "\n"

      end
    else

      puts "Directory not writable"

    end

  end

  def silent_resolution_formatize (resolution,dir)

    input_file  = File.join(dir,"#{resolution}.mp4")
    output_file = File.join(dir,"#{resolution}_v.mp4")

    if File.writable?(dir) && File.exists?(input_file)

      lecture_video = FFMPEG::Movie.new(input_file)
      video_options = TRANSCODER::DEFAULT_VIDEO_ONLY_OPTIONS.dup

      return nil unless lecture_video.valid?

      print "Creating a copy of #{resolution}p video without sound"

      lecture_video.transcode(output_file,video_options) do |progress|
          print "."
      end

      print "\n"

    end

  end

  def all_resolution_formatize

    #If the video has been processed then return
    return nil if self.process_status > STATUS::UNPROCESSED

    #If the video has the same fingerprint as the processed video then
    #don't process unless the processing forcing is set
    if (self.video_fingerprint == self.processed_video_fingerprint) &&
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
      resolution_formatize(lecture_video,size,curr_dir)
    end

    self.process_status = STATUS::RESOLUTIONS_PROCESSED
    self.save
  end

  def all_silent_formatize
    return nil if self.process_status > STATUS::RESOLUTIONS_PROCESSED

    if (self.video_fingerprint == self.processed_video_fingerprint) &&
       (self.process_status != STATUS::FORCE)
       return nil
    end

    lecture_video = FFMPEG::Movie.new(self.video.path)
    #Return if the video is invalid
    return nil unless lecture_video.valid?

    base_dir = File.join(lecture_video.path.split("/")[0..-3])
    curr_dir = File.join(base_dir,"current")

    sizes = RESOLUTIONS::SILENT_VERTICAL.dup
    sizes.push lecture_video.height
    sizes = sizes.uniq

    puts sizes

    sizes.each do |size|
      silent_resolution_formatize(size,curr_dir)
    end

    self.process_status = STATUS::SILENT_RESOLUTIONS_PROCESSED
    self.save

  end

  def extract_iframes

  end

  def formatize

    all_resolution_formatize
    all_silent_formatize
    extract_iframes
  end

end