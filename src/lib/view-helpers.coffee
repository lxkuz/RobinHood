module.exports =
  algorithmLabel: (algorithm) ->
    switch algorithm
      when "WavesRobot"
        "Простой волновой"
      when "CarefulRobot"
        "Осторожный волновой"
      when "GreedyRobot"
        "Жадный робот"
      when "GreedyWLBRobot"
        "Жадный робот с последнец ставкой"
      when "SmartRobot"
        "Умный робот"
      when "SmartWavesWLBRobot"
        "Умный робот с последней ставкой"
  betsParser: (bets) ->
    for bet in bets
      "Ставка #{bet.value} на #{bet.type} под коэффициент #{bet.k}"
