var myStepDefinitionsWrapper = function () {
  
  var WAIT = 1;
  
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
    self = this;
    this.browser.wait(WAIT, function() {
      self.assert.equal(self.browser.text("H1").toLowerCase(),"'"+company+"' already registered");
      self.assert.equal(self.browser.text("#formation-results H3").toLowerCase(),
        "please try an alternative or select one of our suggested variations.");
      callback();
    })
  });

  this.Then(/^I should see that "([^"]*)" is available$/, function (company, callback) {
    self = this;
    this.browser.wait(WAIT, function() {
      self.assert.equal(self.browser.text("H1").toLowerCase(),"'"+company.toLowerCase()+"' available");
      self.assert.equal(self.browser.text("#formation-results H3").toLowerCase(),
          "great, you're good to go ahead and register '"+company.toLowerCase()+"'.");
      callback();
    })
  });

  this.Then(/^I should see (\d+) alternative suggestions similar to "([^"]*)"$/, function (num, company, callback) {
    this.assert.ok(this.browser.query("#formation-results #alternative-names"));
    this.assert.equal(this.browser.queryAll("#formation-results #alternative-names tbody tr").length, num);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
