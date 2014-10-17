Feature: UK Formation
  As a customer
  I can search for a UK company I'd like to form
  To check that it doesn't already exist.

 Scenario: UK Formation Search
   When I visit the "company-formations/uk/search" page
   Then I should be on the UK company formation page
   And I should see the company formation search box
   And I should see a Limited company selector

 Scenario: Existing company search
   When I visit the "company-formations/uk/search" page
   And I execute a formation search for "radial solutions"
   Then I should see that "radial solutions limited" is already registered
   And I should see the company formation search box
   # Disabled until perf is sorted.
   # And I should see 10 alternative suggestions similar to "radial solutions"
   # And I should see the option to register those alternative 10 suggestions

Scenario: Non existing company search
   When I visit the "company-formations/uk/search" page
   And I execute a formation search for "XradialX XsolutionsX"
   Then I should see that "XradialX XsolutionsX limited" is available
   And I should see 4 pricing packages available

  Scenario: Replace user typed suffixes
    When I visit the "company-formations/uk/search" page
    And I execute a formation search for "XradialX XsolutionsX LIMITED"
    Then I should see that "XradialX XsolutionsX limited" is available
    When I visit the "company-formations/uk/search" page
    And I execute a formation search for "XradialX XsolutionsX PLC"
    Then I should see that "XradialX XsolutionsX limited" is available
    When I visit the "company-formations/uk/search" page
    And I execute a formation search for "XradialX XsolutionsX LLP"
    Then I should see that "XradialX XsolutionsX limited" is available
