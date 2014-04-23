var myStepDefinitionsWrapper = function () {

  this.World = require("../support/world.js").World;

  this.When(/^I visit the FAQ page$/, function (callback) {
    this.visit('#/faq', callback);
  });

  this.When(/^I visit the home page$/, function (callback) {
    this.visit('#/', callback);
  });


  this.Then(/^I should be on the FAQ page$/, function (callback) {
    this.assert.equal(this.browser.text("H1"), "Frequently Asked Questions");
    callback();
  });

  this.Then(/^I should see the FAQs separated by section$/, function (callback) {
    this.assert.equal(this.browser.queryAll(".faq-section").length, 3);
    callback();
  });

  this.Then(/^I should see an FAQ link in the footer$/, function (callback) {
    this.assert.ok(this.browser.query(".footer a[href='#/faq']"));
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;