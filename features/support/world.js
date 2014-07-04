var zombie = require('zombie');
var assert = require("assert");

var World = function World(callback) {
    this.browser = new zombie; // this.browser will be available in step definitions
    this.assert = assert;

    this.visit = function (url, visitCallback) {
        this.browser.visit("http://localhost:9000/"+url, {waitFor: 3000}, visitCallback);
    };

    callback(); // tell Cucumber we're finished and to use 'this' as the world instance
};
exports.World = World;
