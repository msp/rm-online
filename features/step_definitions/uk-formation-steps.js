var myStepDefinitionsWrapper = function () {

  var WAIT = 30000;

  this.Then(/^I should be on the UK company formation page$/, function (callback) {
    this.assert.equal(this.browser.location.pathname, "/company-formations/uk/search");
    this.assert.equal(this.browser.text("H1").toLowerCase(), "UK Company Formation".toLowerCase());
    callback();
  });

  this.Then(/^I should see the company formation search box$/, function (callback) {
    this.assert.ok(this.browser.query(".search-box"));
    this.assert.equal(this.browser.text(".search-box H3").toLowerCase(), "Check company name availability".toLowerCase());
    this.assert.equal(this.browser.query(".search-box #search-submit").value.toLowerCase(), "Check name".toLowerCase());
    callback();
  });

  this.Then(/^I should see a Limited company selector$/, function (callback) {
    this.assert.ok(this.browser.query("#company-suffix"));
    callback();
  });

  this.Then(/^I should see that "([^"]*)" is already registered$/, function (company, callback) {
    self = this;
    this.browser.wait(WAIT, function() {
      self.assert.equal(self.browser.text("H1").toLowerCase(),"'"+company+"' already registered");
      callback();
    })
  });

  this.Then(/^I should see that "([^"]*)" is available$/, function (company, callback) {
    self = this;
    this.browser.wait(WAIT, function() {
      self.assert.equal(self.browser.text("H1").toLowerCase(),"'"+company.toLowerCase()+"' available");
      callback();
    })
  });

  this.Then(/^I should see (\d+) alternative suggestions similar to "([^"]*)"$/, function (num, company, callback) {
    this.assert.ok(this.browser.query("#formation-results #alternative-names"));
    this.assert.equal(self.browser.text("#formation-results H3").toLowerCase(),
        "please try an alternative or select one of our suggested variations.");

    this.assert.equal(this.browser.queryAll("#formation-results #alternative-names tbody tr").length, num);
    callback();
  });

  this.Then(/^I should see the option to register those alternative (\d+) suggestions$/, function (num, callback) {
    this.assert.equal(this.browser.queryAll("#formation-results #alternative-names .horus-formations-post").length, num);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
