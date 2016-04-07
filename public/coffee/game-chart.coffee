class GameChart
  constructor: (@el) ->
    @$el = $ @el
    data = @$el.data 'chart'

    p1Arr = []
    xArr = []
    p2Arr = []

    for obj in data
      p1Arr.push obj.p1
      xArr.push obj.x
      p2Arr.push obj.p2
    @$el.highcharts
      title:
        text: 'Значения коэффициентов по ходу игры'
        x: -20
      yAxis:
        plotLines: [ {
          value: 0
          width: 1
          color: '#808080'
        } ]
      legend:
        layout: 'vertical'
        align: 'right'
        verticalAlign: 'middle'
        borderWidth: 0
      series: [
        {
          name: 'p1'
          data: p1Arr
        }
        {
          name: 'x'
          data: xArr
        }
        {
          name: 'p2'
          data: p2Arr
        }
      ]

$ ->
  $('.game-chart').each (i, obj) ->
    new GameChart obj