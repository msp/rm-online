Feature: Contact page feature
  As a visitor
  I can view a Contact page
  So that I can get info on which staff member can help me with my enquiry

  Scenario: Contact points
    When I visit the "contact" page
    Then I should be on the contact page
    And I should see 3 staff contact points
    
  Scenario: Address, phone & maps link
    When I visit the "contact" page
    Then I should see a contact address
    And I should see a contact telephone
    And I should see a link to open in Google Maps