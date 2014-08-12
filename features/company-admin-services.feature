Feature: Company Admin Services
  As a visitor
  I can review RM company admin services
  To allow me to choose whether to outsource these functions.

Scenario: Service overview
  When I visit the "company-admin-services" page
  Then I should be on the company admin services page
  And I should see a list of company admin services
  And I should see a company admin services contact point

