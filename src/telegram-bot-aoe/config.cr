module Telegram::Bot::Aoe
  module Config
    def self.root_path
      File.dirname(File.dirname(__FILE__))
    end
    
    def self.assets_path
      "#{root_path}/assets"
    end
  end
end