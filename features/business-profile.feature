Feature: Business Profile feature
  As a visitor
  I can view a business profile
  So that I can purchase documents and reports

  Scenario: Business overview, docs & reports
    When I visit the profile page for company "02425919"
    Then I should be on the profile page
    And I should see and company overview
    And I should see the available documents & reports
    
    
  Scenario: Unavailable Company
    When I visit the profile page for company "02425919XXX"
    Then I should see a company unavailable error message
    
  Scenario: Report details
    When I visit the profile page for company "02425919"
    And I view the reports tab
    And I click through to the Credit Safe report
    Then I should be on the the report detail page
    