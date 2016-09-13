
require 'bundler/setup'
require 'pry'

require 'dotenv'
Dotenv.load

require 'discordrb'
bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'], type: :user, prefix: '', advanced_functionality: false, help_command: false, parse_self: true, help_available: false, debug: true #, log_mode: :debug

# Set your ID here
bot.set_user_permission(163607982473609216, 1)

bot.command(:eval, permission_message: false, permission_level: 1) do |event, *code|
  input = code.join(' ')

  output = eval(input)

  event.message.edit "**Input**: `#{input}`\n**Output**: ```\n#{output}\n```" if output
  event.message.delete if output.nil?
  nil
end

bot.command(:pry, permission_message: false, permission_level: 1) do |event|
  event.message.delete
  binding.pry
end

bot.run
