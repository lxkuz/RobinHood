Bet = require './bet'

class BaseRobot
  constructor: (options = {}) ->
    @bet = options.bet
    @money = options.money
    @stepsCount = options.stepsCount
    @profitKoef = options.profitKoef
    @puts = options.puts || false
    @betsData = []
    @matchData = []

  play: (data) =>
    console.log "p1 - #{data.p1}; p2 - #{data.p2}" if @puts
    @matchData.push data
    return if @money < @bet
    @playAlgorithm data

  playAlgorithm: ->
    throw 'fill play algorithm'


  makeBet: (value, type, koef) ->
    @money -= value
    console.log("Making bet #{value} on #{type} - #{koef}") if @puts
    bet = new Bet
      value: value
      type: type
      k: koef

    @betsData.push bet

  funds: =>
    res =
      costs: 0
      p1: 0
      p2: 0
      betsCount: @betsData.length
    for obj in @betsData
      res.costs += obj.value
      if obj.type is 'p1'
        res.p1 += obj.value * obj.k
      else
        res.p2 += obj.value * obj.k
    res

  stop: =>
    @betsData = []
    @matchData = []

module.exports = BaseRobot