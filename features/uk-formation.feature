Feature: UK Formation
  As a customer
  I can search for a UK company I'd like to form
  To check that it doesn't already exist.

  Scenario: UK Formation Search
    When I visit the "company-formations/uk" page
    Then I should be on the UK company formation page
    And I should see the company formation search box

  Scenario: Existing company search
    When I visit the "company-formations/uk" page
    And I execute a company search for "radial solutions"
    Then I should see that "radial solutions" is already registered
    And I should see a list of alternative suggestions similar to "radial solutions"
#
#  Scenario: Empty search doesn't hit Horus API
#    When I visit the "search/uk" page
#    And I execute a company search for ""
#    And I should see a prompt to enter a valid search term
#    And I should see a link taking me back to try the search again
#
#  Scenario: Horus returns a 500 error
#    When I visit the "search/uk" page
#    And I execute a company search for "'"
#    Then I should see an error message that Horus returned an error
#    And I should see a link taking me back to try the search again
