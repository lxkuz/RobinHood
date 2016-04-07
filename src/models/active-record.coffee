Sequelize = require 'sequelize'

module.exports = new Sequelize 'development', 'test', 'test',
  host: 'localhost'
  dialect: 'sqlite'
  storage: './db/development.sqlite'