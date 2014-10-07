fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
horusAPI = require('./horus-api')

# clib = require("country-selector")
clib = require("../public/javascripts/vendor-hacked/nodejs.countryList")
slib = require("../public/javascripts/vendor-hacked/nodejs.stateList")
defaultCountry = 'United Kingdom';
# defaultCountry = ''

class SearchRoute
  @SEARCH_RESULTS_TITLE: "Search Results"
  @INFO_SEARCH_TITLE: "Company Information Search"
  @UK_AND_INT_REPORTS: "UK & International Reports"
  @COMPANY_DOCUMENTS: "Company Documents"

  @BREADCRUMBS = {
    "/uk-and-international-reports/search": @UK_AND_INT_REPORTS
    "/company-documents/search": @COMPANY_DOCUMENTS
  }

exports.SearchRoute = SearchRoute

exports.index = (req, res) ->
  title = SearchRoute.INFO_SEARCH_TITLE
  country =  if req.params.country then req.params.country else "UK"
  req.breadcrumbs(title, "/search/#{country}")
  res.render "search/index",
    title: title
    bcList: req.breadcrumbs()
    country: country
    countries: clib.countryList(defaultCountry)
    USStates: slib.stateList()
    CAStates: slib.stateList("CA")
    path: req.path
  return

exports.reports = (req, res) ->
  renderView(req, res, "search/uk-and-international-reports", SearchRoute.UK_AND_INT_REPORTS)

exports.documents = (req, res) ->
  renderView(req, res, "search/company-documents",SearchRoute.COMPANY_DOCUMENTS)


exports.execute = (req, res) ->
  sourceURL = req.path.replace("/results", "")
  term = req.query.term
  country =  req.query.country
  title = SearchRoute.BREADCRUMBS[sourceURL]
  req.breadcrumbs(title, sourceURL)
  title = SearchRoute.SEARCH_RESULTS_TITLE
  req.breadcrumbs(title, "#{req.path}?term=#{term}&country=#{country}")

  api = new horusAPI(req, res, term, title, country)

  if country.toLowerCase() == "gb"
    api.ukCompanySearch()
  else
    api.intCompanySearch()

renderView = (req, res, view, title) ->
  country =  if req.params.country then req.params.country else "UK"
  req.breadcrumbs(title, req.path)
  res.render view,
    title: title
    bcList: req.breadcrumbs()
    country: country
    countries: clib.countryList(defaultCountry)
    USStates: slib.stateList()
    CAStates: slib.stateList("CA")
    path: req.path
    searchURL: req.path+"/results"
    searchTitle: "Search for information on a company"
    searchButton: "Search"
  return

