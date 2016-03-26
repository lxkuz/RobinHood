BaseRobot = require './base'

class GreedyWavesRobot extends BaseRobot
  playAlgorithm: (data) =>
    if @betsData.length is 0
      @nextBet data
    else
      @nextBet data, @betsData[@betsData.length - 1].type

  nextBet: (data, lastType) =>
    if @matchData.length > 1
      prev = @matchData[@matchData.length - 2]
      deltaP1 = data.p1 - prev.p1
      deltaP2 = data.p2 - prev.p2
    else
      deltaP1 = 0
      deltaP2 = 0

    if lastType
      if lastType is 'p1'
        @makeBet @bet, "p2", data.p2 if data.p2 > @profitKoef && deltaP2 < 0 && !data.locked.p2
      else
        @makeBet @bet, "p1", data.p1 if data.p1 > @profitKoef && deltaP1 < 0 && !data.locked.p1
    else
      if data.p1 > @profitKoef && deltaP1 < 0
        @makeBet @bet, "p1", data.p1 unless data.locked.p1

      if data.p2 > @profitKoef && deltaP2 < 0
        @makeBet @bet, "p2", data.p2 unless data.locked.p2

module.exports = GreedyWavesRobot