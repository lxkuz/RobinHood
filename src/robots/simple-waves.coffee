BaseRobot = require './base'

class SimpleWavesRobot extends BaseRobot
  playAlgorithm: (data) =>
    if @betsData.length is 0
      @firstBet data
    else
      @nextBet data, @betsData[@betsData.length - 1].type

  firstBet: (data) =>
    if data.p1 > data.p2 && data.p1 > @profitKoef
      @makeBet @bet, "p1", data.p1 unless data.locked.p1
    else
      @makeBet @bet, "p2", data.p2 if data.p2 > @profitKoef && !data.locked.p2

  nextBet: (data, lastType) =>
    if lastType is 'p1'
      @makeBet @bet, "p2", data.p2 if data.p2 > @profitKoef && !data.locked.p2
    else
      @makeBet @bet, "p1", data.p1 if data.p1 > @profitKoef && !data.locked.p1

module.exports = SimpleWavesRobot