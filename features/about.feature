Feature: About page
  As a visitor
  I can view an About page
  So that I can get assurance RM are an established company

  Scenario: Stats and Partners
    When I visit the "about" page
    Then I should be on the about page
    And I should see the company stats
    And I should see the company partners

  Scenario: Services partial
    When I visit the "about" page
    Then I should be on the about page
    And I should see 5 available services
