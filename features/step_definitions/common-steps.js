var myStepDefinitionsWrapper = function () {

  this.World = require("../support/world.js").World;

  this.When(/^I visit the "(.*)" page$/, function (pageURL, callback) {
    this.visit(pageURL.toLowerCase(), callback);
  });

  this.Then(/^I should see an? "(.*)" link in the footer$/, function (linkURL, callback) {
    this.assert.ok(this.browser.query(".footer a[href='/"+linkURL.toLowerCase()+"']"));
    callback();
  });

};
module.exports = myStepDefinitionsWrapper;