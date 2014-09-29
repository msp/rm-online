var myStepDefinitionsWrapper = function () {

  var FULL_REPORT_ID = "#rep-02425919-LFL";
  
  function addToCart(callback) {
    this.browser.clickLink(FULL_REPORT_ID, callback);
  }

  function viewCart(callback) {
    this.browser.pressButton("#shopping-cart-toggle", callback);
  }

  function assertTotalCostEqual(whole, unit) {
    this.assert.equal(this.browser.text(".simpleCart_total"), "£" + whole + "." + unit)
  }

  this.When(/^I add (\d+) full reports? to my cart$/, function (num, callback) {
    for(var i = 0; i < num; i++) {
      addToCart.call(this);
    }

    callback();
  });

  this.Then(/^I should see (\d+) items in the cart total/, function (num, callback) {
    this.assert.equal(this.browser.text(".simpleCart_quantity"), num);
    callback();
  });

  this.When(/^I view the cart$/, function (callback) {
    viewCart.call(this, callback);
  });

  this.Then(/^the total cost should be (\d+)\.(\d+)$/, function (whole, unit, callback) {
    assertTotalCostEqual.call(this, whole, unit);
    callback();
  });

  this.When(/^I decrement the number of items in my cart$/, function (callback) {
    this.browser.clickLink(".simpleCart_decrement", callback);
  });

  this.Then(/^I should see the product button display (\d+) items? in cart$/, function (num, callback) {
    this.assert.equal(this.browser.text(FULL_REPORT_ID), "("+num+") IN CART");
    callback();
  });
};
module.exports = myStepDefinitionsWrapper;
