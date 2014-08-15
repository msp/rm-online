Feature: T&Cs page
  As a visitor
  I can view an terms and conditions page

  Scenario: Terms from current site
    When I visit the "terms" page
    Then I should be on the terms page
    And I should see 12 T&Cs

  Scenario: Footer link
    When I visit the home page
    Then I should see a "terms" link in the footer
