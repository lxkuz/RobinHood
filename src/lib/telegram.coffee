TelegramBot = require('node-telegram-bot-api')
RobinHoodWatcher = require('./watcher')
token = '167232741:AAHFF9i8Nl1QZhtgsYL3mLrcPvPw8PSfzKI'

bot = new TelegramBot(token, polling: true)

bot.onText /\/echo (.+)/, (msg, match) ->
  fromId = msg.chat.id
  resp = match[1]
  bot.sendMessage fromId, resp

bot.on 'message', (msg) ->
  chatId = msg.chat.id
  if msg.text.match(/watch/)
    url = msg.text.split('watch ')[1]
    lastMessage = ""
    new RobinHoodWatcher url, (data) ->
      arr = []
      if data['p1']
        arr.push 'П1 - ' + data['p1']
      if data['x']
        arr.push 'X - ' + data['x']
      if data['p2']
        arr.push 'П2 - ' + data['p2']
      console.log('new message')
      console.log arr.join(', ')
      console.log 'lastMessage'
      console.log lastMessage
      if lastMessage != arr.join(', ')
        lastMessage = arr.join(', ')
        bot.sendMessage chatId, lastMessage
  else
    bot.sendMessage chatId, ';)'
