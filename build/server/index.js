// Generated by CoffeeScript 1.10.0
(function() {
  var Robot, app, bodyParser, express, reload, robovisor;

  express = require('express');

  reload = require('require-reload')(require);

  Robot = require('../models/robot');

  bodyParser = require('body-parser');

  robovisor = require('../lib/robovisor');

  app = express();

  app.set('view engine', 'jade');

  app.use(express["static"]('../../public'));

  app.use(bodyParser.urlencoded());

  app.get('/', function(req, res) {
    return Robot.all().then(function(robots) {
      return res.render('index', {
        title: 'RobinHoodXbet',
        robots: robots
      });
    });
  });

  app.post('/robots', function(req, res) {
    Robot.create({
      name: req.body.name,
      url: req.body.url,
      type: req.body.type
    });
    return res.redirect('/');
  });

  app.get('/new', function(req, res) {
    return res.render('new', {
      title: 'Новый робот'
    });
  });

  app.post('/robots/:id', function(req, res) {
    console.log("DELETE ROBOT!!!!!!!!");
    return Robot.find({
      id: req.param('id')
    }).then(function(robot) {
      console.log(robot);
      return robot.destroy();
    }).then(function() {
      return res.redirect('/');
    });
  });

  app.post('/robovisor/start', function(req, res) {
    return robovisor.start(function() {
      return res.redirect('/');
    });
  });

  app.post('/robovisor/stop', function(req, res) {
    return robovisor.stop(function() {
      return res.redirect('/');
    });
  });

  app.get('/robots/:id', function(req, res) {
    return Robot.find({
      id: req.param('id')
    }).then(function(robot) {
      return res.render('show', {
        robot: robot
      });
    });
  });

  app.listen(3000, function() {
    return console.log('RobinHood Viewer listen:3000');
  });

}).call(this);
