RoboTest = require './robo-test'

test = ->
  stepsCount = 60
  bookmakerKoef = 0.6
  bookmakerSafeKoef = 0.95
  delta = 0.2
  simpleBet = 10
  money = 100
  gamesCount = 1
  profitKoef = 2.5

  MatchDataFactory = require './match-data-factory'
  factory = new MatchDataFactory
    koef: bookmakerKoef
    delta: delta
    safeKoef: bookmakerSafeKoef
    stepsCount: stepsCount

  gamesData = factory.buildGamesData(stepsCount, gamesCount)

  SmartRobot = require '../robots/greedy-waves-wlb'
  smartRobot = new SmartRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: true

  RoboTest('Smart Waves robot', smartRobot, gamesData, true)

test()