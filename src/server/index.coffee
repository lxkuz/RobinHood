npid = require 'npid'
express = require('express')
reload = require('require-reload')(require)
#Watcher = require('../lib/watcher')
Robot = require '../models/robot'
bodyParser = require('body-parser')
robovisor = require '../lib/robovisor'

try
  pid = npid.create './pids/server.pid'
  pid.removeOnExit()
catch err
  console.log err
  process.exit 1

app = express()
app.set('view engine', 'jade')
app.use(express.static('../../public'));
app.use(bodyParser.urlencoded())

app.get '/', (req, res) ->
  Robot.all().then (robots) ->
      res.render 'index',
        title: 'RobinHoodXbet'
        robots: robots

app.post '/robots', (req, res) ->
  Robot.create
    name: req.body.name
    url: req.body.url
    type: req.body.type
  res.redirect('/')

app.get '/new', (req, res) ->
  res.render 'new',
    title: 'Новый робот'

app.post '/robots/:id', (req, res) ->
  console.log("DELETE ROBOT!!!!!!!!")
  Robot.find
    id: req.param('id')
  .then (robot) ->
    console.log(robot)
    robot.destroy()
  .then ->
    res.redirect('/')

app.post '/robovisor/start', (req, res) ->
  robovisor.start ->
    res.redirect('/')

app.post '/robovisor/stop', (req, res) ->
  robovisor.stop ->
    res.redirect('/')


app.get '/robots/:id', (req, res) ->
  Robot.find
    id: req.param('id')
  .then (robot) ->
    res.render 'show',
      robot: robot


app.listen 3000, ->
  console.log('RobinHood Viewer listen:3000')