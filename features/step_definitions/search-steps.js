var myStepDefinitionsWrapper = function () {

  var WAIT = 4000;

  this.Then(/^I should be on the "([^"]*)" search page$/, function (country, callback) {
    this.assert.equal(this.browser.location.pathname, "/search/"+country);
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Company Information Search".toLowerCase());
    callback();
  });

  this.Then(/^I should see the search box$/, function (callback) {
    this.assert.ok(this.browser.query(".search-box"));
    this.assert.equal(this.browser.text(".search-box H3").toLowerCase(), "Search for information on a company".toLowerCase());
    this.assert.equal(this.browser.query(".search-box #search-submit").value.toLowerCase(), "Search".toLowerCase());
    callback();
  });

  this.When(/^I execute a company search for "([^"]*)"$/, function (term, callback) {
    this.browser.fill("#search-term", term).
      pressButton("#search-submit", callback);
  });

  this.Then(/^I should see (\d+) search results? for "([^"]*)"$/, function (num, term, callback) {
    this.assert.equal(this.browser.location.pathname.toLowerCase(), "/search/results".toLowerCase());
    self = this;
    this.browser.wait(WAIT, function() {
      self.assert.equal(self.browser.text("#num-search-results").toLowerCase(), num+" results for '"+term+"'".toLowerCase());
      self.assert.equal(self.browser.text("H1").toLowerCase(), "Search Results".toLowerCase());
      self.assert.ok(self.browser.query(".search-results"));
      self.assert.ok(self.browser.text(".search-results tr td.company-name").toLowerCase().indexOf(term) != -1);
      callback();
    })
  });

  this.Then(/^I should see a prompt to enter a valid search term$/, function (callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Please enter a valid search term and try again.".toLowerCase());
    callback();
  });

  this.When(/^I should see an error message that Horus returned an error$/, function (callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Error [98]: Sorry, unsuccessful response from our search API. Please try again later.".toLowerCase());
    callback();
  });

  this.Then(/^I should see a link taking me back to try the search again$/, function (callback) {
    this.assert.equal(this.browser.text("#back-to-search").toLowerCase(), "Back to search".toLowerCase());
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
