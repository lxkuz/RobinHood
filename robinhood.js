var Spooky = require('spooky');
var config = require('config');
var Lives = require("./config/lives");

var RobinHood = function(gameUrl, callback) {

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

        spooky.start(config.siteUrl);
        //spooky.options.clientScripts = ["./client_scripts/test.js"]
        spooky.on("game-is-ready", callback);

        spooky.then([{config: config, gameUrl: gameUrl}, function () {
            this.fillSelectors('form#fLogin2', {
                'input#userLogin': config.login,
                'input#userPassword': config.password
            });
            this.click("#userConButton");
            //while(true){
            this.wait(3000, function () {
                var nextUrl = config.siteUrl + "/" + gameUrl;
                this.thenOpen(nextUrl, function () {
                    this.click("#one_click");
                    this.fillSelectors(".sports_widget", {
                        'input.input_one_click': config.minbet
                    });
                    this.click("a.input_one_click_but");
                    this.wait(100, function () {
                        this.click(".ui-widget button");
                    });
                    this.wait(1000, function () {
                        var data = {
                            p1: this.fetchText("#b_1_0"),
                            x: this.fetchText("#b_2_0"),
                            p2: this.fetchText("#b_3_0")
                        };
                        this.emit("game-is-ready", data);

                        //this.capture('out/result.png', {
                        //    top: 0,
                        //    left: 0,
                        //    width: 2000,
                        //    height: 1000
                        //});
                    });

                })
            });
            //}
        }]);
        spooky.run();
    });

    spooky.on('error', function (e, stack) {
        console.error(e);

        if (stack) {
            console.log(stack);
        }
    });


    spooky.on('console', function (line) {
        console.log(line);
    });

};

module.exports = RobinHood;
//spooky.on('log', function (log) {
//    if (log.space === 'remote') {
//        console.log(log.message.replace(/ \- .*/, ''));
//    }
//});