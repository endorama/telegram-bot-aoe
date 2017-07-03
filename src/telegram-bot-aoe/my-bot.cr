module Telegram::Bot::Aoe
  class MyBot < TelegramBot::Bot
    HELP_TEXT = <<-EOS
"Now we know his name: Sir William Wallace, the Hammer of the English."

Welcome to this AoE2 inspired bot. Send him chat taunts, and receive audio
back. Simple as that.

Commands:

- /list: get a list of available taunts
- /help to show this text.

To stop receiving messages from this bot, remove it from the group.

**Privacy Note:** This bot reads **all** messages send in the group chat where is
present. :)
Not that it saves the messages, but they could be logged for debug purposes.

Enjoy!

Disclaimer:
Age of Empires 2 HD © Microsoft Corporation.
WilliamWallaceBot was created under Microsoft's "Game Content Usage Rules" using assets from Age of Empires 2 HD, and it is not endorsed by or affiliated with Microsoft.
EOS

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
