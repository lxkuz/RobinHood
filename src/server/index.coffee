express = require('express')
reload = require('require-reload')(require)

app = express()

app.set('view engine', 'jade')

app.get '/', (req, res) ->
  Recorder = reload('./../lib/recorder')
  res.render 'index',
    title: 'RobinHoodXbet'
    data: Recorder.getData()

app.listen 3000, ->
  console.log('RobinHood Viewer listen:3000')
