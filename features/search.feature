Feature: UK Company Information search
  As a visitor
  I can search for UK companies
  So that I can get background information about company activities

  Scenario: Search page
    When I visit the "search/uk" page
    Then I should be on the "uk" search page
    And I should see the search box

  Scenario: Executing a search
    When I visit the "search/uk" page
    And I execute a company search for "radial solutions"
    Then I should see 1 search result for "radial solutions"

  Scenario: Empty search doesn't hit Horus API
     When I visit the "search/uk" page
     And I execute a company search for ""
     And I should see a prompt to enter a valid search term
     And I should see a link taking me back to try the search again

  Scenario: Horus returns a 500 error
    When I visit the "search/uk" page
    And I execute a company search for "'"
    Then I should see an error message that Horus returned an error
    And I should see a link taking me back to try the search again
