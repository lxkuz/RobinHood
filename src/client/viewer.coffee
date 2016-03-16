$ ->
  setInterval ->
    id = "robinhood-info-module"
    if $(".bet_group:first .bets span.koeff:first").length > 0
      infoContainer = if $("##{id}").length is 0
        $("<div id='#{id}' style='display:none;'>").appendTo $('body')
      else
        $("##{id}")

      console.log "П1 " + $(".bet_group:first .bets span.koeff:first").text()
      try
        data =
          date: currentDate()
          name: $("#page_title").text() + " " + Date().toString()
          p1: parseFloat($(".bet_group:first .bets span.koeff:first").text())
          p2: parseFloat($(".bet_group:first .bets span.koeff:last").text())
        infoContainer.html JSON.stringify(data)
  , 1000
