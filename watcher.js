var Spooky = require('spooky');
var config = require('config');

var RobinHoodWatcher = function(gameUrl, callback) {

    var spooky = new Spooky({
        child: {
            transport: 'http'
        },
        casper: {
            logLevel: 'debug',
            verbose: true
        }
    }, function (err) {
        if (err) {
            e = new Error('Failed to initialize SpookyJS');
            e.details = err;
            throw e;
        }
        var nextUrl = gameUrl;
        spooky.on("game-is-ready", callback);
        spooky.start(nextUrl, function(){
            var data = {
                p1: this.fetchText("#b_1_0"),
                x: this.fetchText("#b_2_0"),
                p2: this.fetchText("#b_3_0")
            };
            this.emit("game-is-ready", data);
        });
        spooky.run();
    });
};

module.exports = RobinHoodWatcher;