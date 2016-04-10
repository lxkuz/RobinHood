_ = require 'underscore'
stepsCount = 100
bookmakerKoef = 0.5
bookmakerSafeKoef = 0.95
delta = 0.2
simpleBet = 10
money = 100
gamesCount = 100
profitKoef = 2.5

WavesRobot = require '../robots/simple-waves'

makePlayData = (robot)->
  gameData = JSON.parse(robot.get 'gameData')
  res = {}
  robot = new WavesRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef

  for el in gameData
    robot.play(el)

  res['simple_waves'] = robot.betsData
  res

module.exports = makePlayData