var zombie = require('zombie');
var assert = require("assert");

var World = function World(callback) {
    this.browser = new zombie; // this.browser will be available in step definitions
    this.assert = assert;
  
    this.visit = function (url, callback) {
        this.browser.visit("http://localhost:3000/"+url, callback);
    };

    callback(); // tell Cucumber we're finished and to use 'this' as the world instance
};
exports.World = World;
