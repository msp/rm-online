Feature: As a customer
  I can interact with a shopping cart
  So I can purchase documents & reports
  
Scenario: Add to cart
  When I visit the profile page for company "02425919"
  And I view the reports tab
  And I click through to the Credit Safe report
  When I add 1 standard report to my cart
  And I view the cart
  Then I should see 1 items in the cart total
  And the total cost should be 18.00
  
Scenario: Remove from cart
  When I visit the profile page for company "02425919"
  And I view the reports tab
  And I click through to the Credit Safe report
  And I add 3 standard report to my cart
  When I view the cart
  And I decrement the number of items in my cart
  # Zombie can't handle links with JS in them so revisit :/
  When I visit the profile page for company "02425919"
  And I view the cart
  Then I should see 1 items in the cart total
  And the total cost should be 36.00
  
  