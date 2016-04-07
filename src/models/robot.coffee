ActiveRecord = require './active-record'
Sequelize = require 'sequelize'

Robot = ActiveRecord.define 'robots',
  id:
    type: Sequelize.INTEGER
    primaryKey: true
  type: Sequelize.STRING
  url: Sequelize.TEXT
  name: Sequelize.STRING
  state:
    type: Sequelize.STRING
    defaultValue: 'new'
  pid: Sequelize.INTEGER
  gameData: Sequelize.TEXT
,
  freezeTableName: true

Robot.sync()

module.exports = Robot