var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the company admin services page$/, function (callback) {
    this.assert.equal(this.browser.location.pathname, "/company-admin-services");
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Company Admin Services".toLowerCase());
    callback();
  });

  this.Then(/^I should see a list of company admin services$/, function (callback) {
    this.assert.equal(this.browser.queryAll(".admin-section").length, 9);
    callback();
  });

  this.Then(/^I should see a company admin services contact point$/, function (callback) {
    this.assert.ok(this.browser.query("#contact_administration"));
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
