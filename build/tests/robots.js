// Generated by CoffeeScript 1.10.0
(function() {
  var RoboTest, _, test;

  RoboTest = require('./../lib/robo-test');

  _ = require('underscore');

  test = function() {
    var CarefulRobot, GreedyRobot, GreedyWLBRobot, MatchDataFactory, SmartRobot, SmartWavesWLBRobot, WavesRobot, bookmakerKoef, bookmakerSafeKoef, carefulRobot, delta, factory, gamesCount, gamesData, greedyRobot, greedyWLBRobot, i, len, money, obj, profitKoef, puts, ref, res, results, simpleBet, simpleRobot, smartRobot, smartWavesWLBRobot, stepsCount;
    stepsCount = 100;
    bookmakerKoef = 0.5;
    bookmakerSafeKoef = 0.95;
    delta = 0.2;
    simpleBet = 10;
    money = 100;
    gamesCount = 100;
    profitKoef = 2.5;
    puts = true;
    MatchDataFactory = require('./../lib/match-data-factory');
    factory = new MatchDataFactory({
      koef: bookmakerKoef,
      delta: delta,
      safeKoef: bookmakerSafeKoef,
      stepsCount: stepsCount
    });
    gamesData = factory.buildGamesData(stepsCount, gamesCount);
    WavesRobot = require('../robots/simple-waves');
    simpleRobot = new WavesRobot({
      bet: simpleBet,
      money: money,
      stepsCount: stepsCount,
      profitKoef: profitKoef,
      puts: puts
    });
    CarefulRobot = require('../robots/careful-waves');
    carefulRobot = new CarefulRobot({
      bet: simpleBet,
      money: money,
      stepsCount: stepsCount,
      profitKoef: profitKoef,
      puts: puts
    });
    GreedyRobot = require('../robots/greedy-waves');
    greedyRobot = new GreedyRobot({
      bet: simpleBet,
      money: money,
      stepsCount: stepsCount,
      profitKoef: profitKoef,
      puts: puts
    });
    GreedyWLBRobot = require('../robots/greedy-waves-wlb');
    greedyWLBRobot = new GreedyWLBRobot({
      bet: simpleBet,
      money: money,
      stepsCount: stepsCount,
      profitKoef: profitKoef,
      puts: puts
    });
    SmartRobot = require('../robots/smart-waves');
    smartRobot = new SmartRobot({
      bet: simpleBet,
      money: money,
      stepsCount: stepsCount,
      profitKoef: profitKoef,
      puts: puts
    });
    SmartWavesWLBRobot = require('../robots/smart-waves-wlb');
    smartWavesWLBRobot = new SmartWavesWLBRobot({
      bet: simpleBet,
      money: money,
      stepsCount: stepsCount,
      profitKoef: profitKoef,
      puts: puts
    });
    res = [];
    res.push(RoboTest('Greedy Waves with last bet robot', greedyWLBRobot, gamesData, puts));
    ref = _.sortBy(res, function(obj) {
      return -obj.value;
    });
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      obj = ref[i];
      results.push(console.log(obj.message));
    }
    return results;
  };

  test();

}).call(this);