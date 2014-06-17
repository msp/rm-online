var myStepDefinitionsWrapper = function () {
  this.Then(/^I should be on the "([^"]*)" search page$/, function (country, callback) {
    this.assert.equal(this.browser.location.pathname, "/search/"+country);
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

  this.Then(/^I should see (\d+) search results? for "([^"]*)"$/, function (num, term, callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Search Results".toLowerCase());
    this.assert.equal(this.browser.text("H3").toLowerCase(), num+" results for '"+term+"'".toLowerCase());
    this.assert.ok(this.browser.query(".search-results"));
    this.assert.ok(this.browser.text(".search-results tr td.company-name").toLowerCase().indexOf(term) == 0);
    callback();
  });

};
module.exports = myStepDefinitionsWrapper;