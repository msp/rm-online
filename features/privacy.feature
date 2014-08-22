Feature: Privacy & Cookies page
  As a visitor
  I can view an privacy & cookies page

  Scenario: Privacy sections
    When I visit the "privacy-and-cookies" page
    Then I should be on the privacy page
    And I should see the privacy sections separated by section

  Scenario: Footer link
    When I visit the home page
    Then I should see an "privacy-and-cookies" link in the footer
