locallydb = require 'locallydb'

class Recorder
  constructor: ->
    console.log "new recorder"
    @db = new locallydb 'db'
    @events = @db.collection 'events'

  push: (data) =>
    console.log "push data"
    console.log data
    @events.insert data

module.exports = new Recorder