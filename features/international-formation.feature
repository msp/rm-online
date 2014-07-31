Feature: International Company Formation
  As a customer
  I can buy an off the shelf international company

  Scenario: Jurisdictions & prices
    When I visit the "company-formations/international" page
    Then I should be on the "international" formations search page
    And I should see a list of jurisdictions with prices
    
  Scenario: Click to buy now
    When I visit the "company-formations/international" page
    Then I should see an option to buy now
    And I should see a buy now link with pre populated subject & body
    
  Scenario: Viewing a jurisdiction
    When I visit the "company-formations/international" page
    And I click through to British Virgin Islands
    Then I should see a list of 8 ".highlights li"
    And I should see a list of 10 ".social li"
    And I should see a list of 2 ".guideline"
    And I should see a list of jurisdictions with prices
