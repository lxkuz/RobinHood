express = require('express')
app = express()

app.set('view engine', 'jade')

app.get '/', (req, res) ->
  Recorder = require('./../lib/recorder')
  res.render 'index',
    title: 'RobinHoodXbet'
    data: Recorder.getData()

app.listen 3000, ->
  console.log('RobinHood Viewer listen:3000')
