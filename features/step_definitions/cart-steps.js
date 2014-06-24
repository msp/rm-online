var myStepDefinitionsWrapper = function () {
  function addToCart(callback) {
    this.browser.clickLink("ADD TO BASKET", callback);
  }

  function viewCart(callback) {
    this.browser.clickLink("#shopping-cart-toggle", callback);
  }

  function assertTotalCostEqual(whole, unit) {
    this.assert.equal(this.browser.text(".simpleCart_total"), "£" + whole + "." + unit)
  }

  this.When(/^I add (\d+) standard reports? to my cart$/, function (num, callback) {
    for(var i = 0; i < num; i++) {
      addToCart.call(this);
    }
    callback();

  });

  this.Then(/^I should see (\d+) items in the cart total/, function (num, callback) {
    this.assert.equal(this.browser.queryAll(".simpleCart_quantity").length, num);
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
};
module.exports = myStepDefinitionsWrapper;