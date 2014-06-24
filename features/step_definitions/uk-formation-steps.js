var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the UK company formation page$/, function (callback) {
    this.assert.equal(this.browser.location.pathname, "/company-formations/uk");
    this.assert.equal(this.browser.text("H1").toLowerCase(), "UK Company Formation".toLowerCase());
    callback();
  });

  this.Then(/^I should see the company formation search box$/, function (callback) {
    this.assert.ok(this.browser.query(".search-box"));
    this.assert.equal(this.browser.text(".search-box H3").toLowerCase(), "Check company name availability".toLowerCase());
    this.assert.equal(this.browser.query(".search-box #search-submit").value.toLowerCase(), "Check name".toLowerCase());
    callback();
  });

  this.Then(/^I should see that "([^"]*)" is already registered$/, function (company, callback) {
    this.assert.equal(this.browser.text("#formation-results H3").toLowerCase(),
      "the name '"+company+"' is already taken. please try an alternative or select one of our suggested variations");
    callback();
  });

  this.Then(/^I should see a list of alternative suggestions similar to "([^"]*)"$/, function (arg1, callback) {
    callback.pending();
  });
};
module.exports = myStepDefinitionsWrapper;
