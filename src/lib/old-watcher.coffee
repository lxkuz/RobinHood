Spooky = require 'spooky'
config = require 'config'
_ = require 'underscore'

#Recorder = require './recorder'

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
        waitTimeout: 10000
      clientScripts: ["build/client/viewer.js"]
    , (err) =>
      if err
        e = new Error('Failed to initialize SpookyJS')
        e.details = err
        throw e

      pageLoadedCallback = ->
        console.log 'pageLoadedCallback...'
        @waitForSelector '#robinhood-info-module', ->
          console.log '@waitForSelector success...'
          data = JSON.parse(@fetchText "#robinhood-info-module")
          @emit 'game-is-ready', data

      spooky.on 'game-is-ready', (data) =>
        console.log 'game-is-ready'
        #        Recorder.push @gameUrl, data
        @callback data
        #        @thenOpen @gameUrl, pageLoadedCallback

      startCallback = ->
        console.log 'pageLoadedCallback...' + url
        @wait 3000, ->
          console.log '@waitForSelector success...'
          #          data = JSON.parse(@fetchText "#robinhood-info-module")
#          @emit 'game-is-ready', data
          name = url.split('/').join('_')
          @capture "out/#{name}.png",
            top: 0,
            left: 0,
            width: 2000,
            height: 1000

      spooky.start @gameUrl
      spooky.then [{
        url:  @gameUrl
      }, startCallback]


      #        reloadPage = (->
      #          console.log('reload page')
      #          clearInterval getPageDataInterval if getPageDataInterval
      #          getPageDataInterval = setInterval getPageData, 1000
      #          setTimeout (->
      #            console.log('setTimeout 5000' )
      #            @thenOpen gameUrl, reloadPage
      #          ).bind(@), 5000
      #        ).bind @
      #
      #        getPageData = (->
      #          console.log('get page data')
      #          try
      #        ).bind @
      #
      #        reloadPage()
      #
      #        @wait 100000, ->
      #          @capture 'out/result.png',
      #            top: 0,
      #            left: 0,
      #            width: 2000,
      #            height: 1000
      #
      #          console.log 'done'

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


robotId = process.argv[2]

if robotId
  Robot = require '../models/robot'
  Robot.findById(robotId).then (robot) ->
    processUrl = robot.get 'url'
    new RobinHoodWatcher processUrl, (data) ->
      robot.set
        gameData: JSON.stringify(data)
      robot.save()


