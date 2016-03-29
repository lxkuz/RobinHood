express = require('express')
reload = require('require-reload')(require)
#Watcher = require('../lib/watcher')
Robot = require '../models/robot'
app = express()

app.set('view engine', 'jade')

app.get '/', (req, res) ->
  Robot.all().then (robots) ->
    console.log "---------------------------------robots---------------------------------"
    console.log robots
    console.log '------------------------------------------------------------------------'

    res.render 'index',
      title: 'RobinHoodXbet'
      robots: robots

app.post '/watch', (req, res) ->
  #watcher = new Watcher req.params.url, (data) ->
  console.log req.params
  Robot.create
    url: req.param('url')
    type: req.param('type')
  res.redirect('/')

app.get '/new', (req, res) ->
  res.render 'new',
    title: 'Новый робот'

app.listen 3000, ->
  console.log('RobinHood Viewer listen:3000')


