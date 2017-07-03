module Telegram::Bot::Aoe
  class Taunt
    @call_name : String
    @path : String
    @title : String

    getter :call_name
    getter :path
    getter :title

    def initialize(@path)
      basename = File.basename(@path, ".mp3").split
      @call_name = basename.shift.to_i.to_s
      @title = basename.join(' ').capitalize
    end
  end
end
