var myStepDefinitionsWrapper = function () {

  var COMPANY_NUMBER = undefined;

  this.When(/^I visit the profile page for company "([^"]*)"$/, function (company_number, callback) {
    COMPANY_NUMBER = company_number;
    this.visit("companies/"+company_number, callback);
  });

  this.Then(/^I should be on the profile page$/, function (callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Northern Connectors Limited".toLowerCase());
    callback();
  });

  this.Then(/^I should see and company overview$/, function (callback) {
    this.assert.equal(this.browser.text("#cro_number"), COMPANY_NUMBER);
    this.assert.ok(this.browser.query("address"));
    callback();
  });

  this.Then(/^I should see the available documents & reports$/, function (callback) {
    this.browser.clickLink("Reports");
    this.assert.equal(this.browser.queryAll("#reports .report-box").length, 7);
    callback();
  });

  this.Then(/^I should see a company unavailable error message$/, function (callback) {
    this.assert.equal(this.browser.text("H1").toLowerCase(), "Error [9]: Company number not on file".toLowerCase());
    callback();
  });

  this.When(/^I view the reports tab$/, function (callback) {
    this.browser.clickLink("Reports");
    callback();
  });

  this.When(/^I click through to the Credit Safe report$/, function (callback) {
    this.browser.clickLink("#reports .report-box a", callback);
  });

  this.Then(/^I should be on the the report detail page$/, function (callback) {
    this.assert.ok(this.browser.success);
    this.assert.equal(this.browser.location.pathname, "/companies/"+COMPANY_NUMBER+"/reports/cs");
    this.assert.equal(this.browser.queryAll(".report-box").length, 1);
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
