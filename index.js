var Spooky = require('spooky');
var config = require('config');
var Lives = require("./config/lives");

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
    spooky.then([{config: config, Lives: Lives}, function(){
        this.fillSelectors('form#fLogin2', {
            'input#userLogin': config.login,
            'input#userPassword': config.password
        });
        this.click("#userConButton");
        //while(true){
        this.wait(3000, function () {
            var nextUrl = config.siteUrl + "/" + Lives[0].url;
            this.thenOpen(nextUrl, function () {
                this.click("#one_click");
                this.fillSelectors(".sports_widget", {
                    'input.input_one_click': config.minbet
                });
                this.wait(1000, function(){
                    this.capture('out/result.png', {
                        top: 0,
                        left: 0,
                        width: 2000,
                        height: 1000
                    });
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

//spooky.on('log', function (log) {
//    if (log.space === 'remote') {
//        console.log(log.message.replace(/ \- .*/, ''));
//    }
//});