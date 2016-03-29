ActiveRecord = require './active-record'
Sequelize = require 'Sequelize'

Robot = ActiveRecord.define 'robots',
  id:
    type: Sequelize.INTEGER
    primaryKey: true
  type: Sequelize.STRING
  url: Sequelize.TEXT
,
  freezeTableName: true

module.exports = Robot