// Generated by CoffeeScript 1.10.0
(function() {
  var Sequelize;

  Sequelize = require('Sequelize');

  module.exports = new Sequelize('development', 'test', 'test', {
    host: 'localhost',
    dialect: 'sqlite',
    storage: './db/development.sqlite'
  });

}).call(this);