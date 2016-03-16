$ ->
  currentDate = ->
    d = new Date()
    curr_date = d.getDate()
    curr_month = d.getMonth() + 1
    curr_year = d.getFullYear()
    "#{curr_date}.#{curr_month}.#{curr_year}"

  setInterval ->
    id = "robinhood-info-module"
    if $(".bet_group:first .bets span.koeff:first").length > 0
      infoContainer = if $("##{id}").length is 0
        $("<div id='#{id}' style='display:none;'>").appendTo $('body')
      else
        $("##{id}")

      try
        data =
          date: currentDate()
          name: $("#page_title").text() + " " + currentDate()
          p1: parseFloat($(".bet_group:first .bets span.koeff:first").text())
          p2: parseFloat($(".bet_group:first .bets span.koeff:last").text())
        infoContainer.html JSON.stringify(data)
  , 1000
