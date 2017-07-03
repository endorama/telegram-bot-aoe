require "telegram_bot"

require "./telegram-bot-aoe/*"

module Telegram::Bot::Aoe
  def self.run
    # puts Config.assets_path

    my_bot = Telegram::Bot::Aoe::MyBot.new

    tc = TauntCollection.new
    tc.load_for_locale(:en)
    # puts tc.items.inspect

    my_bot.polling
  end
end

Telegram::Bot::Aoe.run
