Feature: Redirects
  As a site visitor
  I get redirected if I visit old bookmarked URLs
  To give me more context within the new site

  Scenario Outline: Redirects
    When I visit <oldURL> from the old site
    Then I should be redirected to <newURL>

  Examples:
    | oldURL                                  | newURL                                                   |
    | tm-registration-faq.html                | /faq                                                     |
    | tm-search-faq.html                      | /faq                                                     |
    | tm-registration.html                    | /services                                                |
    | tm-registration.html                    | /services                                                |
    | tm-registration-uk.html                 | /services                                                |
    | tm-registration-eu.html                 | /services                                                |
    | tm-registration-int.html                | /services                                                |
    | tm-registration-benefits.html           | /services                                                |
    | tm-registration-fees.html               | /services                                                |
    | tm-search.html                          | /services                                                |
    | tm-search-benefits.html                 | /services                                                |
    | tm-search-fees.html                     | /services                                                |
    | tm-brand-protect.html                   | /services                                                |
    | tm-monitoring.html                      | /services                                                |
    | tm-monitoring.html                      | /services                                                |
    | tm-monitoring-fees.html                 | /services                                                |
    | products.html                           | /services                                                |
    | cs-cosec.html                           | /services                                                |
    | bi-aml-solutions-int.html               | /services                                                |
    | bi-credit-reports-int.html              | /services                                                |
    | bi-company-documents-int.html           | /services                                                |
    | document59.html                         | /services                                                |
    | armadillo-app.html                      | /services                                                |
    | arm1.htm                                | /services                                                |
    | tm-brand-audits.html                    | /services                                                |
    | rmlogin.htm                             | /services                                                |
    | bi-companies-house-documents-uk.html    | /services                                                |
    | AMLogin.htm                             | /services                                                |
    | cs-foundations-dif.html                 | /services                                                |
    | cs-trusts.html                          | /services                                                |
    | cs-shipreg.html                         | /services                                                |
    | cs-foundations-adv.html                 | /services                                                |
    | cs-bankaccounts-int.html                | /services                                                |
    | cs-bankaccounts-eu.html                 | /services                                                |
    | tm-registration-uk.html                 | /services                                                |
    | forms/contactus/lv/lv-form-lv.html      | /company-formations/international                        |
    | forms/contactus/ukraine/ua-form-ua.html | /company-formations/international                        |
    | cs-foundations-lie.html                 | /company-formations/international                        |
    | cs-foundations-aut.html                 | /company-formations/international                        |
    | forms/contactus/md/md-form-ro.html      | /company-formations/international                        |
    | forms/contactus/pl/pl-form-pl.html      | /company-formations/international                        |
    | forms/contactus/ca/ca-form-en.html      | /company-formations/international                        |
    | forms/contactus/safr/safr-form-en.html  | /company-formations/international                        |
    | cs-int-formation.html                   | /company-formations/international                        |
    | jurisdictions/bahamas.html              | /company-formations/international                        |
    | jurisdictions/jersey.html               | /company-formations/international                        |
    | jurisdictions/delaware.html             | /company-formations/international/delaware               |
    | jurisdictions/panama.html               | /company-formations/international/panama                 |
    | cs-foundations-pan.html                 | /company-formations/international/panama                 |
    | about-us.html                           | /about                                                   |
    | cs-bankaccounts.html                    | /company-formations/UK/search                            |
    | bi-company-database-image-bank-uk.html  | /company-formations/UK/search                            |
    | bi-company-credit-check-uk.html         | /company-formations/UK/search                            |
    | bi-company-reports-uk.html              | /company-formations/UK/search                            |
    | bi-money-laundering-protection-uk.html  | /company-formations/UK/search                            |
    | cs-bankaccounts-uk.html                 | /company-formations/UK/search                            |
    | jurisdictions/cyprus.html               | /company-formations/international/cyprus                 |
    | jurisdictions/bvi.html                  | /company-formations/international/british-virgin-islands |
    | jurisdictions/*                         | /company-formations/international                        |