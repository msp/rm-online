var myStepDefinitionsWrapper = function () {

  this.World = require("../support/world.js").World;

  this.Then(/^I should see (\d+) staff contact points$/, function (num, callback) {
    this.assert.ok(this.browser.query("#contact_formations"));
    this.assert.ok(this.browser.query("#contact_documents"));
    this.assert.ok(this.browser.query("#contact_administration"));
    callback();
  });

  this.Then(/^I should see a documents contact for bespoke international docs$/, function (callback) {
    this.assert.ok(this.browser.query("#contact_documents"));
    callback();
  });

  this.Then(/^I should be on the contact page$/, function (callback) {
    this.assert.equal(this.browser.text("H1"), "Contact RM");
    callback();
  });

  this.Then(/^I should see a contact address$/, function (callback) {
    this.assert.ok(this.browser.query("address"));
    callback();
  });

  this.Then(/^I should see a contact telephone$/, function (callback) {
    this.assert.ok(this.browser.query("#telephone"));
    callback();
  });

  this.Then(/^I should see a link to open in Google Maps$/, function (callback) {
    this.assert.ok(this.browser.text("#maps_link"));
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
