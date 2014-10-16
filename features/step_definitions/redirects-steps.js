var myStepDefinitionsWrapper = function () {
  
  var WAIT = 500
  
  this.When(/^I visit (.*) from the old site$/, function (oldURL,callback) {
    console.log("Visiting: "+oldURL);
    this.visit(oldURL, callback);
  });

  this.Then(/^I should be redirected to (.*)$/, function (newURL, callback) {
    self = this;
    this.browser.wait(WAIT, function() {
//    self.assert.equal(self.browser.statusCode, 301);
      self.assert.equal(self.browser.location.pathname, newURL);
      callback();
    })
  });
};
module.exports = myStepDefinitionsWrapper;