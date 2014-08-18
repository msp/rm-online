Feature: Company Documents
 As a site visitor
 I can search for UK and International company documents
 So that I can get background information about company activities

Scenario: Company documents
   When I visit the "company-documents/search" page
   Then I should be on the company documents search page
   And I should see the company search box
   And I should see a country selector

Scenario: Executing a UK document search
   When I visit the "company-documents/search" page
   And I execute a company search for "apiary"
   Then I should see 8 "documents" search results for "apiary"

 Scenario: Executing an International document search (Belgium)
   When I visit the "company-documents/search" page
   And I execute an Belgium company search for "auchan"
   Then I should see 7 "documents" search results for "auchan"

Scenario: Empty search doesn't hit Horus API
    When I visit the "company-documents/search" page
    And I execute a company search for ""
    And I should see a prompt to enter a valid search term
    And I should see a link taking me back to try the search again

Scenario: Horus returns a 500 error
   When I visit the "company-documents/search" page
   And I execute a company search for "'"
   Then I should see an error message that Horus returned an error
   And I should see a link taking me back to try the search again
