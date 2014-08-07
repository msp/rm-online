Feature: As a customer
  I can interact with a shopping cart
  So I can purchase documents & reports

Scenario: Add to cart
  When I visit the profile page for company "02425919"
  And I view the reports tab
  And I click through to the Experian report
  When I add 1 standard report to my cart
  Then I should see the product button display 1 item in cart
  When I view the cart
  Then I should see 1 items in the cart total
  And the total cost should be 10.78

Scenario: Remove from cart
  When I visit the profile page for company "02425919"
  And I view the reports tab
  And I click through to the Experian report
  And I add 3 standard reports to my cart
  Then I should see the product button display 3 items in cart
  When I view the cart
  And I decrement the number of items in my cart
  # Zombie can't handle links with JS in them so revisit :/
  And I visit the profile page for company "02425919"
  And I view the cart
  Then I should see 2 items in the cart total
  When I view the reports tab
  And I click through to the Experian report
  And I should see the product button display 2 items in cart
  And the total cost should be 21.56


