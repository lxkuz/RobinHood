_ = require 'underscore'
stepsCount = 100
bookmakerKoef = 0.5
bookmakerSafeKoef = 0.95
delta = 0.2
simpleBet = 10
money = 100
gamesCount = 100
profitKoef = 2.5

algorithms = [
    name: "WavesRobot"
    func: require '../robots/simple-waves'
  ,
    name: "CarefulRobot"
    func: require '../robots/careful-waves'
  ,
    name: "GreedyRobot"
    func: require '../robots/greedy-waves'
  ,
    name: "GreedyWLBRobot"
    func: require '../robots/greedy-waves-wlb'
  ,
    name: "SmartRobot"
    func: require '../robots/smart-waves'
  ,
    name: "SmartWavesWLBRobot"
    func: require '../robots/smart-waves-wlb'
  ]

makePlayData = (robot)->
  gameData = JSON.parse(robot.get 'gameData')
  res = {}
  for algorighm in algorithms
    robot = new algorighm.func
      bet: simpleBet
      money: money
      stepsCount: stepsCount
      profitKoef: profitKoef

    for el in gameData
      robot.play(el)

    res[algorighm.name] = robot.betsData
  res

module.exports = makePlayData