// Generated by CoffeeScript 1.10.0
(function() {
  var RoboTest;

  RoboTest = function(title, robot, gamesData, puts) {
    var credit, el, funds, gameData, i, it, j, len, len1, message, money, profit, res;
    if (puts == null) {
      puts = false;
    }
    if (puts) {
      console.log("------------- " + title + " -------------");
    }
    money = robot.money;
    credit = 0;
    for (it = i = 0, len = gamesData.length; i < len; it = ++i) {
      gameData = gamesData[it];
      profit = 0;
      for (j = 0, len1 = gameData.length; j < len1; j++) {
        el = gameData[j];
        robot.play(el);
      }
      funds = robot.funds();
      if (funds.betsCount > 0) {
        profit = Math.min(funds.p1, funds.p2);
        if (puts) {
          console.log("profit: " + profit);
        }
        robot.money += profit;
      }
      if (robot.money < robot.bet) {
        if (puts) {
          console.log("LOST ALL MONEY! step: " + it);
        }
        robot.money = 100;
        credit += 100;
      }
      robot.stop();
    }
    message = title + ": " + (parseInt(robot.money - credit)) + ", " + (parseInt(((robot.money - money - credit) / money) * 100)) + "%, credit: " + credit;
    if (parseInt(robot.money - money - credit) < 0) {
      message += " - FAIL";
    } else {
      message += " - PROFIT";
    }
    res = {
      value: parseInt(robot.money - credit),
      message: message
    };
    return res;
  };

  module.exports = RoboTest;

}).call(this);
