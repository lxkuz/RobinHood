BaseRobot = require './base'
_ = require 'underscore'

class BackupRobot extends BaseRobot
  constructor: (options) ->
    super
    @G = options.G

  playAlgorithm: (data) =>
    if @betsData.length is 1
      @tryToCover data

  tryToCover: (data) =>
    prevBet = @betsData[@betsData.length - 1]
    if prevBet.type is 'p1'
      value = @getCoverValue(prevBet, data.p2)
      @makeBet value, 'p2', data.p2 if value
    else
      value = @getCoverValue(prevBet, data.p1)
      @makeBet value, 'p1', data.p1 if value

  getCoverValue: (prevBet, nextKoef) =>
    variants = []
    bet = 0
    minProfit = 0
    costs = prevBet.value
    while bet <= prevBet.value * (prevBet.k - 1) && bet <= @money
      if minProfit / costs >= @G
        variants.push
          bet: bet
          G: minProfit / costs
      bet += 10 #min 1xbet delta
      costs = prevBet.value + bet
      minProfit = Math.min(prevBet.value * prevBet.k, nextKoef * bet)
    return 0 if variants.length is 0
    _.sortBy(variants, (obj) -> obj.G)[0].bet

module.exports = BackupRobot