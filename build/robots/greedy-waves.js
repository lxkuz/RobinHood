// Generated by CoffeeScript 1.10.0
(function() {
  var BaseRobot, GreedyWavesRobot,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  BaseRobot = require('./base');

  GreedyWavesRobot = (function(superClass) {
    extend(GreedyWavesRobot, superClass);

    function GreedyWavesRobot() {
      this.nextBet = bind(this.nextBet, this);
      this.playAlgorithm = bind(this.playAlgorithm, this);
      return GreedyWavesRobot.__super__.constructor.apply(this, arguments);
    }

    GreedyWavesRobot.prototype.playAlgorithm = function(data) {
      if (this.betsData.length === 0) {
        return this.nextBet(data);
      } else {
        return this.nextBet(data, this.betsData[this.betsData.length - 1].type);
      }
    };

    GreedyWavesRobot.prototype.nextBet = function(data, lastType) {
      var deltaP1, deltaP2, prev;
      if (this.matchData.length > 1) {
        prev = this.matchData[this.matchData.length - 2];
        deltaP1 = data.p1 - prev.p1;
        deltaP2 = data.p2 - prev.p2;
      } else {
        deltaP1 = 0;
        deltaP2 = 0;
      }
      if (lastType) {
        if (lastType === 'p1') {
          if (data.p2 > this.profitKoef && deltaP2 < 0 && !data.locked.p2) {
            return this.makeBet(this.bet, "p2", data.p2);
          }
        } else {
          if (data.p1 > this.profitKoef && deltaP1 < 0 && !data.locked.p1) {
            return this.makeBet(this.bet, "p1", data.p1);
          }
        }
      } else {
        if (data.p1 > this.profitKoef && deltaP1 < 0) {
          if (!data.locked.p1) {
            this.makeBet(this.bet, "p1", data.p1);
          }
        }
        if (data.p2 > this.profitKoef && deltaP2 < 0) {
          if (!data.locked.p2) {
            return this.makeBet(this.bet, "p2", data.p2);
          }
        }
      }
    };

    return GreedyWavesRobot;

  })(BaseRobot);

  module.exports = GreedyWavesRobot;

}).call(this);
