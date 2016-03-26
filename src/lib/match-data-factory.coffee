class MatchDataFactory
  constructor: (options = {}) ->
    @koef = options.koef
    @delta = options.delta
    @safeKoef = options.safeKoef
    @stepsCount = options.stepsCount

  build: (n = @stepsCount) =>
    it = 0
    val = @koef
    res = [@koefData(val)]
    while it < n
      val = val +  (2.0 * Math.random() - 1.0) * @delta
      val = @normalizeKoef(val)
      res.push @koefData(val)
      it += 1
    last = res[res.length - 1]
    last.win = Math.random() <= last.k
    res

  buildGamesData: (stepsCount, gamesCount)=>
    gamesData = []
    it = 0
    while it < gamesCount
      gamesData.push @build(stepsCount)
      it += 1
    gamesData

  koefData: (p1Koef) =>
    p2Koef = 1.0 - p1Koef

    k: p1Koef
    p1: @bookmakerNormalize(p1Koef)
    p2: @bookmakerNormalize(p2Koef)
    locked:
      p1: @isLocked(p1Koef)
      p2: @isLocked(p2Koef)

  bookmakerNormalize: (v) =>
    val = @toFixed(1.0 / (v / @safeKoef), 2)
    Math.max(Math.min(val, 100), 1.01)

  isLocked: (koef) => @bookmakerNormalize(koef) <= 1.01

  normalizeKoef: (k) -> Math.min(Math.max(k, 0.0), 1.0)

  toFixed: (num, fixed) ->
    fixed = 0 unless fixed
    fixed = parseFloat(Math.pow(10, fixed))
    Math.floor(num * fixed) / fixed

module.exports = MatchDataFactory

