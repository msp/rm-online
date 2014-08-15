var myStepDefinitionsWrapper = function () {

  var WAIT = 4000;

  this.Then(/^I should be on the uk and international search page$/, function (callback) {
    this.assert.equal(this.browser.location.pathname, "/uk-and-international-reports/search");
    this.assert.equal(this.browser.text("H1").toLowerCase(), "UK and International Reports".toLowerCase());
    callback();
  });

  this.Then(/^I should be on the company documents search page$/, function (callback) {
    this.assert.equal(this.browser.location.pathname, "/company-documents/search");
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Company Documents".toLowerCase());
    callback();
  });

  this.Then(/^I should see the company search box$/, function (callback) {
    this.assert.ok(this.browser.query(".search-box"));
    this.assert.equal(this.browser.text(".search-box H3").toLowerCase(), "Search for information on a company".toLowerCase());
    this.assert.equal(this.browser.query(".search-box #search-submit").value.toLowerCase(), "Search".toLowerCase());
    callback();
  });

  this.Then(/^I should see a country selector$/, function (callback) {
    this.assert.ok(this.browser.query("#country-selector"));
    callback();
  });


  this.When(/^I execute a company search for "([^"]*)"$/, function (term, callback) {
    this.browser.fill("#search-term", term).
      pressButton("#search-submit", callback);
  });

  this.When(/^I execute an Belgium company search for "([^"]*)"$/, function (term, callback) {
    this.browser.fill("#search-term", term).
      select("#country-selector", "Belgium").
        pressButton("#search-submit", callback);
  });

  this.Then(/^I should see (\d+) "([^"]*)" search results? for "([^"]*)"$/, function (num, docs, term, callback) {
    if (docs == "documents") {
      this.assert.equal(this.browser.location.pathname.toLowerCase(), "/company-documents/search/results".toLowerCase());
    } else if (docs == "reports") {
      this.assert.equal(this.browser.location.pathname.toLowerCase(), "/uk-and-international-reports/search/results".toLowerCase());
    }
    
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
