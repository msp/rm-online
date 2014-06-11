var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the home page$/, function (callback) {
    this.assert.equal(this.browser.text("H1"), "Welcome to RM");
    callback();
  });

  this.Then(/^I should see (\d+) available services$/, function (num, callback) {
    this.assert.equal(this.browser.queryAll(".rm-intro-box").length, num);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;