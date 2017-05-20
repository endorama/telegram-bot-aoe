require "telegram_bot"

require "./telegram-bot-aoe/*"

module Telegram::Bot::Aoe
  def self.run
    my_bot = Telegram::Bot::Aoe::MyBot.new
    my_bot.polling
  end
end

Telegram::Bot::Aoe.run