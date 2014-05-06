Feature: FAQ page feature
  As a visitor
  I can view an FAQ page

  Scenario: FAQ sections
    When I visit the "FAQ" page
    Then I should be on the FAQ page
    And I should see the FAQs separated by section
    
  Scenario: Footer link
    When I visit the home page
    Then I should see an "FAQ" link in the footer