fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
horusAPI = require('./horus-api')
slug = require('slug')

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
    name: "Dominica IBC"
    setup: 599
    withLegalisation: 850
    twoYears: 1149
    twoYearsWithLegalisation: 1400
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
  inspect(country)

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
  req.breadcrumbs(title, "/company-formations/UK")
  res.render "formations/uk",
  title: title
  bcList: req.breadcrumbs()
  return

class FormationsRoute
  @SEARCH_RESULTS_TITLE: "Search Results"
  @UK_INFO_SEARCH_TITLE: "UK Company Formation"

exports.search = (req, res) ->
  country =  req.params.country
  term = req.query.term
  title = FormationsRoute.UK_INFO_SEARCH_TITLE
  req.breadcrumbs(title, "/company-formations/UK")
  title = FormationsRoute.SEARCH_RESULTS_TITLE
  req.breadcrumbs(title, "/company-formations/UK/results?term=#{term}")

  api = new horusAPI(req, res, term, title, country)
  api.formationSearch()

exports.countries = COUNTRIES
