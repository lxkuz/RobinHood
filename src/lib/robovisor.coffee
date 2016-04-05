Robot = require '../models/robot'
spawn = require('child_process').spawn

class Robovisor
  constructor: ->
    Robot.findAll
      where:
        state: 'new'
    .then (robots) ->
      for robot in robots
        console.log process.argv[1]
        watcherProcess = spawn('node', ['build/lib/watcher', robot.get('id')])
        watcherProcess.stdout.on 'data', (data) ->
          console.log("stdout: #{data}")

        watcherProcess.stderr.on 'data', (data) ->
          console.log("stderr: #{data}")

        watcherProcess.on 'close', (code) ->
          console.log("child watcherProcess exited with code #{code}")

        console.log "init watcherProcess for #{robot.get('name')}"
        #        robot.set
        #          pid: watcherProcess.pid
        #          state: 'working'
        #        robot.save()

module.exports = new Robovisor

