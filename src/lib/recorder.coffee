locallydb = require 'locallydb'

class Recorder
  constructor: ->
    console.log "new recorder"
    @db = new locallydb 'db'
    @events = @db.collection 'events'

  push: (url, data) =>
    data["url"] = url
    if !@last || (@last.url != data.url) || (data.p1 != @last.p1) || (data.p2 != @last.p2)
      @events.insert data
      @last = data

  getData: =>
    res = {}
    for event in @events.items
      name = event.name
      res[name] = [] unless res[name]
      res[name].push event
    res

module.exports = new Recorder