Feature: Business Profile feature
  As a visitor
  I can view a business profile
  So that I can purchase documents and reports

  Scenario: Business overview
    When I visit the profile page for company "02425919"
    Then I should be on the profile page
    And I should see and company overview