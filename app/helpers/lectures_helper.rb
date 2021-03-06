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
      :video_codec        => 'libx264',
      :x264_vprofile      => 'high',
      :audio_codec        => 'aac',
      :audio_bitrate      => 32,
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
      :custom             => '-strict experimental'
    }


    DEFAULT_VIDEO_ONLY_OPTIONS = '-vcodec copy -an'

  end

  module FULL_AUDIO
    AAC_OPTIONS = {
      :audio_codec        => 'aac',
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
      :custom             => '-strict experimental -vn'
    }

    OPUS_OPTIONS = {
      :audio_codec        => 'libopus',
      :threads            => 4,
      :custom             => '-vn'
    }

    MP3_OPTIONS = {
      :audio_codec        => 'libmp3lame',
      :audio_sample_rate  => 22050,
      :audio_channels     => 1,
      :threads            => 4,
      :custom             => '-strict experimental -vn'
    }

    VORBIS_OPTIONS = {
      :audio_codec        => 'vorbis',
      :audio_sample_rate  => 22050,
      :audio_channels     => 2,
      :threads            => 4,
      :custom             => '-strict experimental -vn'
    }

    WAV_OPTIONS = {
      :audio_codec        => 'pcm_s16le',
      :audio_sample_rate  => 16000,
      :audio_channels     => 1,
      :custom             => '-vn'
    }
    MAPPING = {
      :aac => {
        bitrates:[32,24,16,12,8],
        score:0.9,
        extension: 'm4a',
        mime_type: 'audio/mp4; codec=aac'
      },
      :libopus => {
        bitrates: [32,24,16,12,8,6],
        score: 1.0,
        extension: 'opus',
        mime_type: 'audio/ogg; codec=opus'
      },
      :libmp3lame => {
        bitrates: [32,24,16],
        score: 0.7,
        extension: 'mp3',
        mime_type: 'audio/mpeg; codec=mp3lame'
      },
      :vorbis => {
        bitrates: [32,24,16],
        score: 0.8,
        extension: 'ogg',
        mime_type: 'audio/ogg; codec=vorbis'
      }
    }
  end

  module EXTRACT_FRAMES
    OPTIONS = "-vf 'select=eq(pict_type\\,I),showinfo' -vsync 0"
  end

  module MATCHER
    EXECUTABLE= '/home/manyu/college/matcher/matcher.py'
    TRESHOLD = 15
  end

  module SPHINX
    EXECUTABLE = 'java -Xmx4g -jar /home/manyu/college/subtitler/bin/Transcriber.jar'
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

  def get_proper_path(absolute_path)
    file_path = Pathname.new(absolute_path)
    public_root = Pathname.new(File.join(Rails.root.to_s,'public'))
    relative_path = file_path.relative_path_from(public_root)
    relative_path.to_s
  end

  def full_video_individual (lecture_video,resolution,dir)

    height   = lecture_video.height.to_i
    width    = lecture_video.width.to_i
    key      = "full_video_#{resolution}"

    if File.directory?(dir) && File.writable?(dir)

      if height<resolution
        puts 'VIDEO RESOLUTION NOT ENOUGH EXITING'
      elsif !(self.strategies)
        self.strategies = {}
        self.save
      elsif self.strategies[key] && self.strategies[key][:status] == STATUS::COMPLETED
        puts 'ALREADY DONE MOVING ON'
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


        lecture_video.transcode(file_path,video_options)

        transcoded_video =  FFMPEG::Movie.new(file_path)


        self.strategies[key][:browser] = 'video/mp4'
        self.strategies[key][:score] = resolution/10
        self.strategies[key][:bandwidth] = transcoded_video.size/transcoded_video.duration
        self.strategies[key][:video_url] = {file: get_proper_path(file_path), size: transcoded_video.size}
        self.strategies[key][:status] = STATUS::COMPLETED
        self.save

      end
    else

      puts 'Directory not writable'

    end

  end

  def full_audio_individual (lecture_video,method,bitrate,dir)

    file_type = FULL_AUDIO::MAPPING[method[:audio_codec].to_sym][:extension]
    key      = "full_audio_#{file_type}_#{bitrate}"

    if File.directory?(dir) && File.writable?(dir)

      if self.strategies[key] && self.strategies[key][:status] == STATUS::COMPLETED
        puts 'ALREADY DONE MOVING ON'
      else

        audio_options = method.dup
        audio_options[:audio_bitrate] = bitrate


        file_name = "lecture_#{bitrate}.#{file_type}"
        print "Conversion of video to audio of type #{file_type}_#{bitrate} progressing"





        self.save

        file_path = File.join(dir,file_name)


        lecture_video.transcode(file_path,audio_options)

        transcoded_audio =  FFMPEG::Movie.new(file_path)

        self.strategies[key] = {}
        self.strategies[key][:text] = "Only audio of #{file_type}_#{bitrate} format "
        self.strategies[key][:status] = STATUS::STARTED
        self.strategies[key][:browser] = FULL_AUDIO::MAPPING[method[:audio_codec].to_sym][:mime_type]
        self.strategies[key][:score] = (bitrate/2)*FULL_AUDIO::MAPPING[method[:audio_codec].to_sym][:score]
        self.strategies[key][:bandwidth] = transcoded_audio.size/transcoded_audio.duration
        self.strategies[key][:audio_url] = { file: get_proper_path(file_path), size: transcoded_audio.size }
        self.strategies[key][:status] = STATUS::COMPLETED

        key = "#{key}_with_slide"
        self.strategies[key] = {}
        self.strategies[key][:text] = "Audio and Slide of #{file_type}_#{bitrate} format "
        self.strategies[key][:browser] = FULL_AUDIO::MAPPING[method[:audio_codec].to_sym][:mime_type]
        self.strategies[key][:score] = 10+(bitrate/2)*FULL_AUDIO::MAPPING[method[:audio_codec].to_sym][:score]
        self.strategies[key][:audio_url] = { file: get_proper_path(file_path), size: transcoded_audio.size }
        self.strategies[key][:slide_url] = self.strategies["default"][:slide_url]
        self.strategies[key][:bandwidth] = (transcoded_audio.size+self.strategies["default"][:slide_url][:size])/transcoded_audio.duration
        self.strategies[key][:status] = STATUS::COMPLETED
        self.save

      end
    else

      puts 'Directory not writable'

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

    base_dir = File.join(lecture_video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')


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

    base_dir = File.join(lecture_video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')


    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    methods = [FULL_AUDIO::AAC_OPTIONS,FULL_AUDIO::OPUS_OPTIONS,
               FULL_AUDIO::MP3_OPTIONS,FULL_AUDIO::VORBIS_OPTIONS]

    methods.each do |method|
      bitrates = FULL_AUDIO::MAPPING[method[:audio_codec].to_sym][:bitrates]
      bitrates.each do |bitrate|
        full_audio_individual(lecture_video,method,bitrate,curr_dir)
      end
    end

    self[:full_audio_fingerprint] = self.video_fingerprint
    self.save

  end

  def extract_video_frames

    lecture_video = FFMPEG::Movie.new(self.video.path)
    #Return if the video is invalid
    return nil unless lecture_video.valid?

    base_dir = File.join(lecture_video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')

    if (self.video_fingerprint == self[:extract_frame_fingerprint]) &&
       (self.process_status != STATUS::FORCE)
       return nil
    end

    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end


    if File.directory?(curr_dir) && File.writable?(curr_dir)

        video_options = EXTRACT_FRAMES::OPTIONS
        frames_dir = File.join(curr_dir,'frames')
        begin
          Dir.mkdir(frames_dir) unless File.directory?(frames_dir)
        rescue
          nil
        end
        file_name = 'frames/frame-%04d.png'
        print 'Extracting I frame from video'
        file_path = File.join(curr_dir,file_name)

        transcoder_options = { validate: false }
        transcoder = FFMPEG::Transcoder.new(lecture_video,file_path,video_options, transcoder_options)
        transcoder.run
        output =  transcoder.instance_variable_get(:@output)
        frame_timings = output.scan(/n:(?<frame>\d+)\spts:\d+\spts_time:(?<time>\d+\.\d+)/)
        self[:Iframe_timings] = {}
        frame_timings.each do |entry|
          self[:Iframe_timings][entry[0].to_i] = entry[1]
        end
        self[:extract_frame_fingerprint] = self.video_fingerprint
        self.save


    end

  end

  def extract_slide_frames

    return nil unless self[:compressed_file_path]

    if (self.slide_fingerprint == self[:extract_slide_fingerprint]) &&
       (self.process_status != STATUS::FORCE)
       return nil
    end

    require 'RMagick'
    slide_path = File.join( Rails.root.to_s,'public',self[:compressed_file_path])
    slides = Magick::Image.read(slide_path)

    base_dir = File.join(self.video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')

    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    if File.directory?(curr_dir) && File.writable?(curr_dir)
      slides_dir = File.join(curr_dir,'slides')

      begin
        Dir.mkdir(slides_dir) unless File.directory?(slides_dir)
      rescue
        nil
      end

      slides.each_with_index do |slide,index|
        file_name ="slide-#{index.to_s.rjust(4,'0')}.jpg"
        final_path = File.join(slides_dir, file_name)
        slide.write(final_path)
      end

      self[:extract_slide_fingerprint] = self.slide_fingerprint
      self.save
    end

  end

  def optimize_pdf
    base_dir = File.join(self.video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')

    if (self.slide_fingerprint == self[:optimize_pdf_fingerprint]) &&
       (self.process_status != STATUS::FORCE)
       return nil
    end


    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    #copy the slide
    unprocessed_file_name = 'uncompressed.pdf'
    unprocessed_file_path = File.join(curr_dir,unprocessed_file_name)
    begin
      FileUtils.cp(self.slide.path,unprocessed_file_path)
    rescue
      return nil
    end
    self[:unprocessed_file_path] = get_proper_path unprocessed_file_path
    #Print for screen not print
    screen_pdf_file_name = 'screen.pdf'
    screen_pdf_file_path = File.join(curr_dir,screen_pdf_file_name)
    self[:screen_pdf_file_path] = get_proper_path screen_pdf_file_path
    begin
      system("gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -sOutputFile=#{screen_pdf_file_path} #{unprocessed_file_path}")
    rescue
      return nil
    end
    #Compress the PDF file
    compressed_file_name = 'compressed.pdf'
    compressed_file_path = File.join(curr_dir,compressed_file_name)
    begin
      system("pdftk #{screen_pdf_file_path} output #{compressed_file_path} compress")
    rescue
      return nil
    end
    self[:compressed_file_path] = get_proper_path compressed_file_path
    file_size = File.size compressed_file_path
    new_strategy = {slide_url: {file: get_proper_path(compressed_file_path),size: file_size},
                    text: 'Optimized PDF',browser:'',
                    status:1,
                    score:1,
                    bandwidth:500,
                    }
    self.strategies["default"] = new_strategy
    self[:optimize_pdf_fingerprint] = self.slide_fingerprint
    self.save
  end

  def match_frames

    base_dir = File.join(self.video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')

    if File.directory?(curr_dir) && File.writable?(curr_dir)
      slides_dir = File.join(curr_dir,'slides')
      frames_dir = File.join(curr_dir,'frames')

      #Run Major Pass Algorithm
      match_list = `#{MATCHER::EXECUTABLE} #{slides_dir} #{frames_dir}`
      lines = match_list.split("\n")
      self[:slide_time] = []
      lines.each do |line|
        (frame,slide_no,good) = line.split(':')
        time_entry = {time: self[:Iframe_timings][frame.to_i] , slide: slide_no.to_i}
        time_entry[:has_slide] = TRUE if good
        self[:slide_time] << time_entry
      end
      self.save
      #Get Missing Slide Timings



      #Run Fine Tuning Algorithm
    end
  end

  def slide_timings
    optimize_pdf
    extract_slide_frames
    extract_video_frames
    match_frames
  end

  def get_wav_file

    lecture_video = FFMPEG::Movie.new(self.video.path)
    file_type = 'wav'

    return nil unless lecture_video.valid?

    base_dir = File.join(lecture_video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')


    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    if File.directory?(curr_dir) && File.writable?(curr_dir)

      file_name = "lecture.#{file_type}"
      print "Conversion of video to audio of type #{file_type} progressing"

      file_path = File.join(curr_dir,file_name)
      audio_options = FULL_AUDIO::WAV_OPTIONS
      transcoder_options = { validate: false }
      lecture_video.transcode(file_path,audio_options,transcoder_options)

    else

      puts 'Directory not writable'

    end
  end

  def get_subtitles


    base_dir = File.join(self.video.path.split('/')[0..-3])
    curr_dir = File.join(base_dir,'current')


    begin
      Dir.mkdir(curr_dir) unless File.directory?(curr_dir)
    rescue
      return nil
    end

    if File.directory?(curr_dir) && File.writable?(curr_dir)

      file_name = 'lecture.wav'
      file_path = File.join(curr_dir,file_name)
      subtitle_output = `#{SPHINX::EXECUTABLE} #{file_path}`
      subtitle_timings = subtitle_output.scan(/^(\d+)\:<s>(.+)<\/s>$/)
      self[:subtitles] = []
      subtitle_timings.each do |timing|
        entry = {time: (timing[0].to_f)/1000,text: timing[1].to_s}
        self[:subtitles] << entry
      end
      self.save
    end

  end

  def extract_text
    get_wav_file
    get_subtitles
  end

  def formatize
    full_video
    slide_timings
    full_audio
    extract_text
  end

end