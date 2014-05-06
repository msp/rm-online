var myStepDefinitionsWrapper = function () {
  
  this.World = require("../support/world.js").World;
  
  this.Then(/^I should be on the terms page$/, function (callback) {
    this.assert.equal(this.browser.text("H1"), "Terms and Conditions");
    callback();
  });

  this.Then(/^I should see (\d+) T&Cs$/, function (num, callback) {
    this.assert.equal(this.browser.queryAll(".terms-section").length, num);
    callback();
  });

};
module.exports = myStepDefinitionsWrapper;