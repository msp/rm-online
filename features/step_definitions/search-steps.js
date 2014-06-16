var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the search page$/, function (callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "UK Company Information Search".toLowerCase());
    callback();  
  });

  this.Then(/^I should see the search box$/, function (callback) {
    this.assert.ok(this.browser.query(".search-box"));
    callback();
  });

  this.When(/^I execute a company search for "([^"]*)"$/, function (term, callback) {
    this.browser.fill("#search-term", term).
      pressButton("Search", callback);
  });

  this.Then(/^I should see some search results$/, function (callback) {
    this.assert.ok(this.browser.query(".search-results"));
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;