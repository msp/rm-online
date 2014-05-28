var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the about page$/, function (callback) {
    this.assert.equal(this.browser.text("H1"), "About Us");
    callback();
  });

  this.Then(/^I should see the company stats$/, function (callback) {
    this.assert.ok(this.browser.query(".stats"));
    callback();
  });

  this.Then(/^I should see the company partners$/, function (callback) {
    this.assert.ok(this.browser.query(".partners"));
    callback();
  });

};
module.exports = myStepDefinitionsWrapper;