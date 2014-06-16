Feature: UK Company Information search
  As a visitor
  I can search for UK companies
  So that I can get background information about company activites

  Scenario: Search page
    When I visit the "search" page
    Then I should be on the search page
    And I should see the search box

  Scenario: Executing a search
    When I visit the "search" page
    And I execute a company search for ""
    Then I should see some search results

  # Scenario: Empty search
  # Scenario: Number of results & pagination?
  # Scenario: Server Errors ?