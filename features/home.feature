Feature: Home page feature
  As a visitor
  I can view a Home page
  So that I can get so get a clear overview of the site services

  Scenario: Services available
    When I visit the home page
    Then I should be on the home page
    And I should see 5 available services