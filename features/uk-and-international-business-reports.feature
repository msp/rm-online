Feature: UK and International business reports
 As a site visitor
 I can search for UK and International reports
 So that I can get background information about company activities

Scenario: UK and International Reports
   When I visit the "uk-and-international-reports/search" page
   Then I should be on the uk and international search page
   And I should see the company search box
  And I should see a country selector

Scenario: Executing a UK report search
   When I visit the "uk-and-international-reports/search" page
   And I execute a company search for "radial solutions"
   Then I should see 1 "reports" search result for "radial solutions"

 Scenario: Executing an International report search (Belgium)
   When I visit the "uk-and-international-reports/search" page
   And I execute an Belgium company search for "auchan"
   Then I should see 7 "reports" search results for "auchan"

Scenario: Empty search doesn't hit Horus API
    When I visit the "uk-and-international-reports/search" page
    And I execute a company search for ""
    And I should see a prompt to enter a valid search term
    And I should see a link taking me back to try the search again

Scenario: Horus returns a 500 error
   When I visit the "uk-and-international-reports/search" page
   And I execute a company search for "'"
   Then I should see an error message that Horus returned an error
   And I should see a link taking me back to try the search again
