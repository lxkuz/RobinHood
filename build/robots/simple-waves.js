// Generated by CoffeeScript 1.10.0
(function() {
  var BaseRobot, SimpleWavesRobot,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  BaseRobot = require('./base');

  SimpleWavesRobot = (function(superClass) {
    extend(SimpleWavesRobot, superClass);

    function SimpleWavesRobot() {
      this.nextBet = bind(this.nextBet, this);
      this.firstBet = bind(this.firstBet, this);
      this.playAlgorithm = bind(this.playAlgorithm, this);
      return SimpleWavesRobot.__super__.constructor.apply(this, arguments);
    }

    SimpleWavesRobot.prototype.playAlgorithm = function(data) {
      if (this.betsData.length === 0) {
        return this.firstBet(data);
      } else {
        return this.nextBet(data, this.betsData[this.betsData.length - 1].type);
      }
    };

    SimpleWavesRobot.prototype.firstBet = function(data) {
      if (data.p1 > data.p2 && data.p1 > this.profitKoef) {
        if (!data.locked.p1) {
          return this.makeBet(this.bet, "p1", data.p1);
        }
      } else {
        if (data.p2 > this.profitKoef && !data.locked.p2) {
          return this.makeBet(this.bet, "p2", data.p2);
        }
      }
    };

    SimpleWavesRobot.prototype.nextBet = function(data, lastType) {
      if (lastType === 'p1') {
        if (data.p2 > this.profitKoef && !data.locked.p2) {
          return this.makeBet(this.bet, "p2", data.p2);
        }
      } else {
        if (data.p1 > this.profitKoef && !data.locked.p1) {
          return this.makeBet(this.bet, "p1", data.p1);
        }
      }
    };

    return SimpleWavesRobot;

  })(BaseRobot);

  module.exports = SimpleWavesRobot;

}).call(this);
