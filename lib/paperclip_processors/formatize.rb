module Paperclip
  class Formatize < Processor

    attr_accessor :file, :options, :attachment

    def initialize(file, options = {},attachment)
      super
      @file = file
      @options = options[:formatize]
      @attachment = attachment
    end

    def make
      lecture_video = FFMPEG::Movie.new(@file.path)

      puts lecture_video.duration # 7.5 (duration of the puts lecture_video in seconds)
      puts lecture_video.bitrate # 481 (bitrate in kb/s)
      puts lecture_video.size # 455546 (filesize in bytes)
      puts lecture_video.video_stream # "h264, yuv420p, 640x480 [PAR 1:1 DAR 4:3], 371 kb/s, 16.75 fps, 15 tbr, 600 tbn, 1200 tbc" (raw video stream info)
      puts lecture_video.video_codec # "h264"
      puts lecture_video.colorspace # "yuv420p"
      puts lecture_video.resolution # "640x480"
      puts lecture_video.width # 640 (width of the puts lecture_video in pixels)
      puts lecture_video.height # 480 (height of the puts lecture_video in pixels)
      puts lecture_video.frame_rate # 16.72 (frames per second)
      puts lecture_video.audio_stream # "aac, 44100 Hz, stereo, s16, 75 kb/s" (raw audio stream info)
      puts lecture_video.audio_codec # "aac"
      puts lecture_video.audio_sample_rate # 44100
      puts lecture_video.audio_channels # 2
      puts lecture_video.valid? # true (would be false if ffmpeg fails to read the movie)

    end

  end
end