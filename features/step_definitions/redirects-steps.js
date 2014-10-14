var myStepDefinitionsWrapper = function () {
  this.When(/^I visit (.*) from the old site$/, function (oldURL,callback) {
    console.log("Visiting: "+oldURL);
    this.visit(oldURL, callback);
  });

  this.Then(/^I should be redirected to (.*)$/, function (newURL, callback) {
//    this.assert.equal(this.browser.statusCode, 301);
    this.assert.equal(this.browser.location.pathname, newURL);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;