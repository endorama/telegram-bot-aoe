module Telegram::Bot::Aoe
  class TauntCollection
    def initialize
      @items = [] of Taunt
    end

    def includes?(call_name)
      elements = find call_name
      return false if elements.empty?
      true
    end

    def get(call_name)
      elements = find call_name
      return nil if elements.empty?
      elements.first
    end

    def list
      @items.sort_by { |e| e.call_name.to_i }.map { |e| "#{e.call_name} - #{e.title}" }.join("\n")
    end

    def load_for_locale(locale : String | Symbol)
      locale.to_s if locale.is_a? Symbol
      load_from_folder("#{Config.assets_path}/#{locale}")
      # puts @items.inspect
    end

    protected def find(call_name)
      @items.select { |e| e.call_name == call_name }
    end

    protected def load_from_folder(path)
      raise "Folder #{path} does not exists" unless Dir.exists? path
      files = Dir.glob("#{path}/*")
        .select { |e| File.extname(e) == ".mp3" }
        .map { |e| Taunt.new e }
      @items = files
    end
  end
end
