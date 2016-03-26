RoboTest = require './robo-test'
_ = require 'underscore'

test = ->
  stepsCount = 185
  bookmakerKoef = 0.6
  bookmakerSafeKoef = 0.95
  delta = 0.3
  simpleBet = 10
  money = 100
  gamesCount = 1
  profitKoef = 2.1
  puts = true

  MatchDataFactory = require './match-data-factory'
  factory = new MatchDataFactory
    koef: bookmakerKoef
    delta: delta
    safeKoef: bookmakerSafeKoef
    stepsCount: stepsCount

  gamesData = require("./sample-data") # reall data from snooker
  # gamesData =  factory.buildGamesData(stepsCount, gamesCount)

  WavesRobot = require '../robots/simple-waves'
  simpleRobot = new WavesRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: puts

  CarefulRobot = require '../robots/careful-waves'
  carefulRobot = new CarefulRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: puts

  GreedyRobot = require '../robots/greedy-waves'
  greedyRobot = new GreedyRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: puts

  GreedyWLBRobot = require '../robots/greedy-waves-wlb'
  greedyWLBRobot = new GreedyWLBRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: puts

  SmartRobot = require '../robots/smart-waves'
  smartRobot = new SmartRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: puts

  SmartWavesWLBRobot = require '../robots/smart-waves-wlb'
  smartWavesWLBRobot = new SmartWavesWLBRobot
    bet: simpleBet
    money: money
    stepsCount: stepsCount
    profitKoef: profitKoef
    puts: puts

  res = []
  res.push RoboTest('Simple Waves robot', simpleRobot, gamesData, puts)
  res.push RoboTest('Careful Waves robot', carefulRobot, gamesData, puts)
  res.push RoboTest('Greedy Waves robot', greedyRobot, gamesData, puts)
  res.push RoboTest('Greedy Waves with last bet robot', greedyWLBRobot, gamesData, puts)
  res.push RoboTest('Smart Waves robot', smartRobot, gamesData, puts)
  res.push RoboTest('Smart Waves with last bet robot', smartWavesWLBRobot, gamesData, puts)

  for obj in _.sortBy(res, (obj)-> -obj.value)
    console.log obj.message

test()