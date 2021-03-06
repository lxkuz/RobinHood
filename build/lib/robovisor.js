// Generated by CoffeeScript 1.10.0
(function() {
  var Robot, Robovisor, _, spawn;

  Robot = require('../models/robot');

  spawn = require('child_process').spawn;

  _ = require('underscore');

  Robovisor = (function() {
    function Robovisor() {}

    Robovisor.prototype.start = function(callback) {
      return Robot.findAll({
        where: {
          state: 'new'
        }
      }).then(function(robots) {
        var i, len, robot, watcherProcess;
        for (i = 0, len = robots.length; i < len; i++) {
          robot = robots[i];
          console.log(process.argv[1]);
          watcherProcess = spawn('node', ['build/lib/watcher', robot.get('id')]);
          watcherProcess.stdout.on('data', function(data) {
            return console.log("stdout: " + data);
          });
          watcherProcess.stderr.on('data', function(data) {
            return console.log("stderr: " + data);
          });
          watcherProcess.on('close', function(code) {
            return console.log("child watcherProcess exited with code " + code);
          });
          console.log("init watcherProcess for " + (robot.get('name')));
          robot.set({
            pid: watcherProcess.pid,
            state: 'working'
          });
          robot.save();
        }
        return typeof callback === "function" ? callback(robots) : void 0;
      });
    };

    Robovisor.prototype.startInstance = function(robot, callback) {
      var watcherProcess;
      watcherProcess = spawn('node', ['build/lib/watcher', robot.get('id')]);
      watcherProcess.stdout.on('data', function(data) {
        return console.log("stdout: " + data);
      });
      watcherProcess.stderr.on('data', function(data) {
        return console.log("stderr: " + data);
      });
      watcherProcess.on('close', function(code) {
        return console.log("child watcherProcess exited with code " + code);
      });
      console.log("init watcherProcess for " + (robot.get('name')));
      robot.set({
        pid: watcherProcess.pid,
        state: 'working'
      });
      return robot.save().then(callback);
    };

    Robovisor.prototype.stop = function(callback) {
      return Robot.findAll({
        where: {
          state: 'working'
        }
      }).then(function(robots) {
        var finish, i, len, pid, results, robot;
        finish = _.after(callback, robots.length);
        results = [];
        for (i = 0, len = robots.length; i < len; i++) {
          robot = robots[i];
          pid = robot.get('pid');
          spawn('kill', ['-QUIT', "-$(ps opgid= " + pid + ")"]);
          robot.set({
            state: 'stopped'
          });
          results.push(robot.save().then(finish));
        }
        return results;
      });
    };

    return Robovisor;

  })();

  module.exports = new Robovisor;

}).call(this);
