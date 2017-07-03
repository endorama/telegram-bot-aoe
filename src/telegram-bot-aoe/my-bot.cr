module Telegram::Bot::Aoe
  class MyBot < TelegramBot::Bot
    include TelegramBot::CmdHandler

    @taunts : TauntCollection
    setter :taunts

    def initialize
      super(ENV["BOT_NAME"], ENV["BOT_TOKEN"])
      @taunts = TauntCollection.new
      @taunts.load_for_locale :en

      cmd "start" do |msg|
        send msg, HELP_TEXT
      end

      cmd "help" do |msg|
        send msg, HELP_TEXT
      end

      cmd "list" do |msg|
        send msg, @taunts.list
      end
    end


    def handle(message : TelegramBot::Message)
      # puts message.inspect
      # puts message.text
      if text = message.text
        if @taunts.includes? text
          send_taunt message, text
        else
          super message
        end
      end
    end

    private def send_taunt(message, text)
      taunt = @taunts.get(text)
      send_audio(message.chat.id, File.new(taunt.path), nil, nil, taunt.title ) if taunt
    end
  end
end
