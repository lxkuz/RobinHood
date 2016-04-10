fs = require 'fs'
path = require 'path'
npid = require 'npid'
express = require 'express'
Robot = require '../models/robot'
bodyParser = require('body-parser')
robovisor = require '../lib/robovisor'
makePlayData = require '../lib/make-play-data'

try
  filePath = './pids/server.pid'
  fs.unlinkSync filePath if fs.existsSync(filePath)
  pid = npid.create filePath
  pid.removeOnExit()
catch err
  console.log err
  process.exit 1

app = express()
app.set('port', 8484)
app.listen(app.get('port'))
app.set('view engine', 'jade')
app.use(express.static(path.join(__dirname, '../../public')));
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

app.post '/robovisor/start', (req, res) ->
  robovisor.start ->
    res.redirect('/')

app.post '/robots/:id/start', (req, res) ->
  Robot.findById(req.param('id')).then (robot) ->
    robovisor.startInstance robot, ->
      res.redirect('/')

app.post '/robots/:id', (req, res) ->
  Robot.findById(req.param('id')).then (robot) ->
    robot.destroy().then ->
      res.redirect('/')


app.post '/robovisor/stop', (req, res) ->
  robovisor.stop ->
    res.redirect('/')

app.post '/robots/:id/kill', (req, res) ->
  Robot.findById(req.param('id')).then (robot) ->
    process.kill(robot.get('pid'))
    robot.set
      state: 'stopped'
    robot.save().then ->
      res.redirect('/')

app.get '/robots/:id', (req, res) ->
  Robot.findById(req.param('id')).then (robot) ->
    res.render 'show',
      robot: robot,
      playData: makePlayData(robot)

app.listen 3000, ->
  console.log('RobinHood Viewer listen:3000')