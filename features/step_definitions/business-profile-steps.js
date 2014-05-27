var myStepDefinitionsWrapper = function () {
  this.When(/^I visit the profile page for company "([^"]*)"$/, function (company_number, callback) {
    this.visit("companies/"+company_number, callback);
  });

  this.Then(/^I should be on the profile page$/, function (callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Northern Connectors Limited".toLowerCase());
    callback();
  });

  this.Then(/^I should see and company overview$/, function (callback) {
    this.assert.equal(this.browser.text("#cro_number"), "02425919");
    this.assert.ok(this.browser.query("address"));
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;