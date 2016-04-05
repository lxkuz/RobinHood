Spooky = require 'spooky'
config = require 'config'
_ = require 'underscore'
https = require("https")

class RobinHoodWatcher
  constructor: (@url, @callback)->
    eventName = _(@url.split("/")).chain().compact().reverse().value()[0]
    eventId = eventName.split("-")[0]
    baseUrl = @url.split("https://")[1].split("/")[0]

    @gameUrl =
      host: baseUrl
      path: "/LiveFeed/GetGame?id=#{eventId}&lng=ru&cfview=0"

    @options = @gameUrl
    @gameData = []
    @readData()

  stopReadData: =>
    @counter = 0 unless @counter
    @counter += 1
    @counter > 100

  readData: (callback) =>
    https.get @options, (response) =>
      body = ""
      response.on 'data', (chunk) ->
        body += chunk

      response.on 'end', =>
        data = JSON.parse(body)
        obj =
          p1: data['Value']['Events'][0]['C']
          p2: data['Value']['Events'][1]['C']
        console.log obj
        @gameData.push obj
        setTimeout =>
          if @stopReadData()
            callback @gameData
          else
            @readData(callback)
        , 3000


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


