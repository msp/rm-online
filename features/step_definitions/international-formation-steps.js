var myStepDefinitionsWrapper = function () {

  var TOTAL_JURISDICTIONS = 18;

  this.Then(/^I should be on the "([^"]*)" formations search page$/, function (country, callback) {
    this.assert.equal(this.browser.location.pathname, "/company-formations/"+country);
    this.assert.equal(this.browser.text("H1").toLowerCase(), country+" Company Formation".toLowerCase());
    callback();
  });

  this.Then(/^I should see a list of jurisdictions with prices$/, function (callback) {
    this.assert.ok(this.browser.query(".jurisdictions"));
    this.assert.equal(this.browser.queryAll(".jurisdictions tbody tr").length, TOTAL_JURISDICTIONS);
    callback();
  });

  this.Then(/^I should see an option to buy now$/, function (callback) {
    this.assert.equal(this.browser.queryAll(".jurisdictions tbody tr .buy-now").length, TOTAL_JURISDICTIONS);
    callback();
  });

  this.Then(/^I should see a buy now link with pre populated subject & body$/, function (callback) {
    var els = this.browser.queryAll(".jurisdictions tbody tr .buy-now a")
    var countries = this.browser.queryAll(".jurisdictions tbody tr .country-name")

    for (var i = 0; i < els.length; i++) {
      var country = this.browser.text(countries[i]);
      this.assert.ok(decodeURIComponent(els[i].href).indexOf(country) != -1);
      this.assert.ok(decodeURIComponent(els[i].href).indexOf("subject=") != -1);
      this.assert.ok(decodeURIComponent(els[i].href).indexOf("body=") != -1);
    }
    callback();
  });

  this.When(/^I click through to British Virgin Islands$/, function (callback) {
    this.browser.clickLink("British Virgin Islands", callback);
  });

  this.Then(/^I should see a list of (\d+) "([^"]*)"$/, function (num, selector, callback) {
    this.assert.equal(this.browser.queryAll(selector).length, num);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
