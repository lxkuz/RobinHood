Sequelize = require 'Sequelize'

sequelize = new Sequelize 'development', 'test', 'test',
  host: 'localhost'
  dialect: 'sqlite'
  storage: './db/development.sqlite'


SportEvent = sequelize.define 'sport_event',
  id:
    type: Sequelize.INTEGER
    primaryKey: true
  name: Sequelize.STRING
  url: Sequelize.TEXT
,
  freezeTableName: true

Koef = sequelize.define 'koef',
  id:
    type: Sequelize.INTEGER
    primaryKey: true
  p1: Sequelize.FLOAT
  p2: Sequelize.FLOAT
  x: Sequelize.FLOAT
  sport_event_id: Sequelize.INTEGER
,
  freezeTableName: true
  define:
    timestamps: true

Koef.belongsTo(SportEvent)
SportEvent.hasMany(Koef)

SportEvent.sync().then =>
  console.log 'SportEvent.sync() then'
  SportEvent.create
    url: 'http://google.com'
    name: 'test1'

  SportEvent.create
    url: 'http://google.com'
    name: 'test2'



class Recorder
  push: (url, data) =>
    SportEvent.sync().then =>
      SportEvent.findAll
        where:
          url: data.url
      .then (results) =>
        sportEvent = results[0]
        unless sportEvent
          SportEvent.create
            url: data.url
            name: data.name
        end



    console.log 'push recorder'
    console.log data
    data["url"] = url
    if !@last || (@last.url != data.url) || (data.p1 != @last.p1) || (data.p2 != @last.p2)
      @events.insert data
      @last = data

  getData: (callback) =>
    SportEvent.sync().then =>
      DataK.sync()
    .then =>
    res = {}
    for event in SportEvent.findAll
      name = event.get 'name'



module.exports = new Recorder