RoboGameTest = (title, robot, gameData, puts = false) ->
  console.log "------------- #{title} -------------" if puts
  money = robot.money
  credit = 0
  for el in gameData
    robot.play(el)
  funds = robot.funds()

  if funds.betsCount > 0
    if gameData[gameData.length - 1].win
      console.log("P1 win") if puts
      profit = funds.p1
    else
      console.log("P2 win") if puts
      profit = funds.p2

    console.log "profit: #{profit}" if puts
    robot.money += profit

    if robot.money < robot.bet
      console.log "LOST ALL MONEY!" if puts
    robot.stop()

  #After #{gamesData.length} games result of
  message = "#{title}: #{parseInt(robot.money - credit)}, #{parseInt(((robot.money - money - credit) / money) * 100)}%, credit: #{credit}"

  console.log message

module.exports = RoboGameTest