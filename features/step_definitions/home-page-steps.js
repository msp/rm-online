var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the home page$/, function (callback) {
    this.assert.equal(this.browser.location.pathname, "/");
    this.assert.ok(this.browser.query("H1"));
    this.assert.ok(this.browser.query(".intro-copy"));
    callback();
  });

  this.Then(/^I should see (\d+) available services$/, function (num, callback) {
    this.assert.equal(this.browser.queryAll(".rm-intro-box").length, num);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;