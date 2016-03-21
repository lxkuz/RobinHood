Spooky = require 'spooky'
config = require 'config'
Recorder = require './recorder'

class RobinHoodWatcher
  constructor: (gameUrl, callback) ->
    console.log "watch start #{gameUrl}"
    @gameUrl = gameUrl
    @callback = callback
    spooky = new Spooky
      child: transport: 'http'
      casper:
        logLevel: 'debug'
        verbose: true
        remoteDebuggerAutorun: true
        remoteDebuggerPort: 9000
        pageSettings:
          javascriptEnabled: true

      clientScripts: ["build/client/viewer.js"]
    , (err) =>
      if err
        e = new Error('Failed to initialize SpookyJS')
        e.details = err
        throw e

      spooky.on 'game-is-ready', (data) =>
        Recorder.push(@gameUrl, data)
        @callback(data)
      spooky.start @gameUrl, ->
        func = (->
          console.log('interval func')
          try
            data = JSON.parse(@fetchText "#robinhood-info-module")
            @emit 'game-is-ready', data
        ).bind @
        setInterval func, 5000
        @wait 100000, ->
          @capture 'out/result.png',
            top: 0,
            left: 0,
            width: 2000,
            height: 1000

          console.log 'done'
      spooky.run()

      spooky.on 'error', (e, stack) ->
        console.error(e)
        console.log(stack) if (stack)

      spooky.on 'console', (line) ->
        console.log(line)

      spooky.on 'remote.message', (message) ->
        console.log message

      spooky.on "page.error", (msg, trace) ->
        @echo("Error:    " + msg, "ERROR")
        @echo("file:     " + trace[0].file, "WARNING")
        @echo("line:     " + trace[0].line, "WARNING")
        @echo("function: " + trace[0]["function"], "WARNING")
        errors.push(msg)

module.exports = RobinHoodWatcher