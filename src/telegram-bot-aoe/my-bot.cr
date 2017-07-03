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
        send_markdown_message msg.chat.id, Telegram::Bot::Aoe::HELP_TEXT
      end

      cmd "help" do |msg|
        send_markdown_message msg.chat.id, Telegram::Bot::Aoe::HELP_TEXT
      end

      cmd "list" do |msg|
        send_markdown_message msg.chat.id, @taunts.list
      end
    end


    def handle(message : TelegramBot::Message)
      # puts message.inspect
      # puts message.text
      if text = message.text
        if @taunts.includes? text
          send_taunt message.chat.id, text
        else
          super message
        end
      end
    end

    private def send_taunt(chat_id, text)
      taunt = @taunts.get(text)
      send_audio(chat_id, File.new(taunt.path), nil, nil, taunt.title ) if taunt
    end

    private def send_markdown_message(chat_id, text)
      send_message chat_id, text, "Markdown"
    end
  end
end
