var Spooky = require('spooky');
var config = require('config');
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
    spooky.then(function () {
        this.capture('out/google.png', {
            top: 100,
            left: 100,
            width: 500,
            height: 400
        });
        this.emit('hello', 'Hello, from ' + this.evaluate(function () {
                return document.title;
            }));
    });
    spooky.run();
});

spooky.on('error', function (e, stack) {
    console.error(e);

    if (stack) {
        console.log(stack);
    }
});

/*
 // Uncomment this block to see all of the things Casper has to say.
 // There are a lot.
 // He has opinions.
 spooky.on('console', function (line) {
 console.log(line);
 });
 */

spooky.on('hello', function (greeting) {
    console.log(greeting);
});

spooky.on('log', function (log) {
    if (log.space === 'remote') {
        console.log(log.message.replace(/ \- .*/, ''));
    }
});