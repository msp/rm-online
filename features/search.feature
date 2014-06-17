Feature: UK Company Information search
  As a visitor
  I can search for UK companies
  So that I can get background information about company activites

  Scenario: Search page
    When I visit the "search/uk" page
    Then I should be on the "uk" search page
    And I should see the search box

  Scenario: Executing a search
    When I visit the "search/uk" page
    And I execute a company search for "radial solutions"
    Then I should see 1 search results for "radial solutions"

  # Scenario: Empty search , no table, message
  # Scenario: Number of results & pagination?
  # Scenario: Server Errors ?