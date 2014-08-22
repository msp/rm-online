var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the privacy page$/, function (callback) {
    this.assert.equal(this.browser.text("H1"), "Privacy & Cookies");
    callback();
  });

  this.Then(/^I should see the privacy sections separated by section$/, function (callback) {
    this.assert.equal(this.browser.queryAll(".privacy-section").length, 6);
    callback();

  });
};
module.exports = myStepDefinitionsWrapper;