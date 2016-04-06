Spooky = require 'spooky'
config = require 'config'
_ = require 'underscore'
https = require("https")

class RobinHoodWatcher
  constructor: (@url, @options)->
    eventName = _(@url.split("/")).chain().compact().reverse().value()[0]
    eventId = eventName.split("-")[0]
    baseUrl = @url.split("https://")[1].split("/")[0]

    @requestOptions =
      host: baseUrl
      path: "/LiveFeed/GetGame?id=#{eventId}&lng=ru&cfview=0"

    @readData()

  readData: =>
    https.get @requestOptions, (response) =>
      body = ""
      response.on 'data', (chunk) ->
        body += chunk

      response.on 'end', =>
        data = JSON.parse(body)
        if data['Value'] && !data['Value']['Finished']
          obj = {locked: {}}
          for event in data['Value']['Events']
            switch event['T']
              when 1
                obj.p1 = event['C']
                obj.locked.p1 = event['B']
              when 2
                obj.x = event['C']
                obj.locked.x = event['B']
              when 3
                obj.p2 = event['C']
                obj.locked.p2 = event['B']

          @options.onStep obj
          setTimeout @readData, 5000
        else
          @options.onFinish data

module.exports = RobinHoodWatcher


robotId = process.argv[2]

if robotId
  Robot = require '../models/robot'
  Robot.findById(robotId).then (robot) ->
    processUrl = robot.get 'url'
    new RobinHoodWatcher processUrl,
      onStep: (obj) ->
        gameData = robot.get('gameData')
        baseData = if gameData
          JSON.parse(gameData)
        else
          []
        console.log baseData
        baseData.push(obj)
        robot.set
          gameData: JSON.stringify(baseData)
        robot.save()
      onFinish: ->
        robot.set
          state: 'done'
        robot.save()
        console.log 'FINISH'


