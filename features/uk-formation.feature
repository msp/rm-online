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
    And I should see 4 alternative suggestions similar to "radial solutions"

  Scenario: Non existing company search
    When I visit the "company-formations/uk" page
    And I execute a company search for "XradialX XsolutionsX"
    Then I should see that "XradialX XsolutionsX" is available
