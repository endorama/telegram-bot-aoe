module Telegram::Bot::Aoe
  class MyBot < TelegramBot::Bot
    include TelegramBot::CmdHandler

    def initialize
      super("MyBot", "353376342:AAEVgemJTyCcZvNG-MqzXtJM9eUwaOJiZK0")

      cmd "hello" do |msg|
        send msg, "world!"
      end

      # /add 5 7 => 12
      cmd "add" do |msg, params|
        reply msg, "#{params[0].to_i + params[1].to_i}"
      end
    end
    
    # def handle(message : TelegramBot::Message)
    #   if text = message.text
    #     reply message, text
    #   end
    # end
  end
end