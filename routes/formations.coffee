fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
horusAPI = require('./horus-api')
slug = require('slug')
GoogleSpreadsheets = require("google-spreadsheets")

COUNTRIES = [
  {
    name: "Belize"
    setup: 399
    withLegalisation: 649
    twoYears: 748
    twoYearsWithLegalisation: 998
  }
  {
    name: "British Anguilla"
    setup: 600
    withLegalisation: 850
    twoYears: 1000
    twoYearsWithLegalisation: 1250
  }
  {
    name: "British Samoa"
    setup: 550
    withLegalisation: 800
    twoYears: 950
    twoYearsWithLegalisation: 1200
  }
  {
    name: "British Virgin Islands"
    setup: 550
    withLegalisation: 845
    twoYears: 950
    twoYearsWithLegalisation: 1200
  }
  {
    name: "Cook Islands"
    setup: 599
    withLegalisation: 849
    twoYears: 1148
    twoYearsWithLegalisation: 1398
  }
  {
    name: "Cyprus"
    setup: 1750
    withLegalisation: 2000
    twoYears: 2700
    twoYearsWithLegalisation: 2950
  }
  {
    name: "Delaware"
    setup: 299
    withLegalisation: 549
    twoYears: 550
    twoYearsWithLegalisation: 799
  }
  {
    name: "Dubai"
    setup: 2150
    withLegalisation: "-"
    twoYears: 3650
    twoYearsWithLegalisation: "-"
  }
  {
    name: "Gibraltar"
    setup: 799
    withLegalisation: 1049
    twoYears: 1399
    twoYearsWithLegalisation: 1650
  }
  {
    name: "Hong Kong"
    setup: 1050
    withLegalisation: 1445
    twoYears: 1900
    twoYearsWithLegalisation: 2700
  }
  {
    name: "Malta"
    setup: 2175
    withLegalisation: 2425
    twoYears: 3175
    twoYearsWithLegalisation: 3425
  }
  {
    name: "Marshall Islands"
    setup: 699
    withLegalisation: 949
    twoYears: 1198
    twoYearsWithLegalisation: 1448
  }
  {
    name: "Nevada"
    setup: 1050
    withLegalisation: 1300
    twoYears: 1900
    twoYearsWithLegalisation: 2150
  }
  {
    name: "New Zealand"
    setup: 1900
    withLegalisation: "-"
    twoYears: 3100
    twoYearsWithLegalisation: "-"
  }
  {
    name: "Panama"
    setup: 600
    withLegalisation: 850
    twoYears: 1000
    twoYearsWithLegalisation: 1250
  }
  {
    name: "Seychelles"
    setup: 340
    withLegalisation: 600
    twoYears: 550
    twoYearsWithLegalisation: 850
  }
  {
    name: "Wyoming (USA)"
    setup: 700
    withLegalisation: 950
    twoYears: 1300
    twoYearsWithLegalisation: 1600
  }
]

COUNTRIES_SHOW = {}

for country in COUNTRIES
  do (country) ->
    COUNTRIES_SHOW[slug(country.name).toLowerCase()] = require("../json/#{slug(country.name).toLowerCase()}.json")

exports.international = (req, res) ->
  title = "International Company Formation"
  req.breadcrumbs(title, "/company-formations/international")
  res.render "formations/international",
    title: title
    bcList: req.breadcrumbs()
    countries: COUNTRIES
  return

exports.internationalShow = (req, res) ->

  country = COUNTRIES_SHOW[req.params.jurisdiction][0]

  title = "International Company Formation"
  req.breadcrumbs(title, "/company-formations/international")
  title = country.country
  req.breadcrumbs(title, "/company-formations/"+req.params.jurisdiction)
  res.render "formations/international-show",
    title: title
    bcList: req.breadcrumbs()
    countryShow: country
    countries: COUNTRIES
    polymer: true
  return

exports.uk = (req, res) ->

  title = "UK Company Formation"
  h1 = ""
  heading= "UK Company Formations"
  intro = "RM have been assisting law firms, accountants and professional service organisations with company information for due diligence and forming companies around the Globe for over 40 years. The services are discreet, professional and cost effective."
  meta =  "COMPANY FORMATION, REGISTRATION, REPORTS AND CREDIT CHECKS FOR ANY UK OR OFFSHORE COMPANY"
  benefitsHeading = ""
  benefits = ""
  servicesHeading = ""
  services = ""
  req.breadcrumbs(title, req.url)

  # https://docs.google.com/spreadsheets/d/1ZblOqr9Fhz0SEU3kaK1amtDGOgA7uz8BaTk8BSs9xRA/pubhtml
  GoogleSpreadsheets
    key: "1ZblOqr9Fhz0SEU3kaK1amtDGOgA7uz8BaTk8BSs9xRA"
  , (err, spreadsheet) ->
    console.log("ERROR: #{err}")
    if !err
      spreadsheet.worksheets[0].cells
        range: "R1C1:R10C10"
      , (err, cells) ->

        inspect(cells.cells)

        title             = cells.cells[2][1].value
        h1                = cells.cells[2][2].value
        heading           = cells.cells[2][3].value
        intro             = cells.cells[2][4].value
        meta              = cells.cells[2][5].value
        benefitsHeading   = cells.cells[2][6].value
        benefits          = cells.cells[2][7].value.split("\n")
        servicesHeading   = cells.cells[2][8].value
        services          = cells.cells[2][9].value.split("\n")

        res.render "formations/uk",
          title: title
          h1: h1
          heading: heading
          intro: intro
          meta: meta
          benefits: benefits
          benefitsHeading: benefitsHeading
          services: services
          servicesHeading: servicesHeading
          bcList: req.breadcrumbs()
          searchTitle: "Check company name availability"
          searchButton: "Check name"
          searchURL: "/company-formations/UK/search/results"
        return

    else
      res.render "formations/uk",
        title: title
        h1: h1
        heading: heading
        intro: intro
        meta: meta
        benefits: benefits
        benefitsHeading: benefitsHeading
        services: services
        servicesHeading: servicesHeading
        bcList: req.breadcrumbs()
        searchTitle: "Check company name availability"
        searchButton: "Check name"
        searchURL: "/company-formations/UK/search/results"
    return


class FormationsRoute
  @SEARCH_RESULTS_TITLE: "Search Results"
  @UK_INFO_SEARCH_TITLE: "UK Company Formation"
  @PAYMENT_SUCCESSFUL_TITLE: "Payment Successful"

exports.search = (req, res) ->
  country =  req.params.country
  term = req.query.term
  title = FormationsRoute.UK_INFO_SEARCH_TITLE
  req.breadcrumbs(title, "/company-formations/UK/search")
  title = FormationsRoute.SEARCH_RESULTS_TITLE
  req.breadcrumbs(title, "/company-formations/UK/search/results?term=#{term}")

  api = new horusAPI(req, res, term, title, country)
  api.formationSearch()

exports.paymentSuccessful = (req, res) ->
  title = FormationsRoute.UK_INFO_SEARCH_TITLE
  req.breadcrumbs(title, "/company-formations/UK/search")
  title = FormationsRoute.PAYMENT_SUCCESSFUL_TITLE
  req.breadcrumbs(title, req.url)

  res.render "formations/payment-successful",
    title: title
    bcList: req.breadcrumbs()


exports.countries = COUNTRIES
