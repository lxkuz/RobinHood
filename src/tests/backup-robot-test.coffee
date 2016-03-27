RoboTest = require '../lib/robo-game-test'
Bet = require '../lib/bet'

test = ->
  stepsCount = 60
  bookmakerKoef = 0.6
  bookmakerSafeKoef = 0.95
  delta = 0.2
  simpleBet = 10
  money = 300
  gamesCount = 1
  profitKoef = 2.5


  gameData1 = [
    {"p1": 2.0, "p2": 1.61, "locked": {"p1": false, "p2": false}}
    {"p1": 2.29, "p2": 1.62, "locked": {"p1": false, "p2": false}}
    {"p1": 3.59, "p2": 1.12, "locked": {"p1": false, "p2": false}}
    {"p1": 6.29, "p2": 1.02, "locked": {"p1": false, "p2": false}}
    {"p1": 1.09, "p2": 1.02, "locked": {"p1": false, "p2": false}, win: true}

  ]

  gameData2 = [
    {"p1": 2.0, "p2": 1.61, "locked": {"p1": false, "p2": false}}
    {"p1": 2.29, "p2": 1.62, "locked": {"p1": false, "p2": false}}
    {"p1": 3.59, "p2": 1.12, "locked": {"p1": false, "p2": false}}
    {"p1": 6.29, "p2": 1.02, "locked": {"p1": false, "p2": false}}
    {"p1": 1.09, "p2": 1.02, "locked": {"p1": false, "p2": false}, win: false}
  ]

  BackupRobot = require '../robots/backup'
  robot = new BackupRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: true
    G: 1.2
    betsData: [
      new Bet(k: 1.61, value: 200, type: 'p2')
    ]

  RoboTest('Bakup robot', robot, gameData1, true)


  robot.money = 300
  robot.betsData = [
    new Bet(k: 1.61, value: 200, type: 'p2')
  ]

  RoboTest('Bakup robot', robot, gameData2, true)

test()