fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
horusAPI = require('./horus-api')

# clib = require("country-selector")
clib = require("../public/javascripts/vendor-hacked/nodejs.countryList")
defaultCountry = 'United Kingdom';
# defaultCountry = ''

class SearchRoute
  @SEARCH_RESULTS_TITLE: "Search Results"
  @INFO_SEARCH_TITLE: "Company Information Search"

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
    path: req.path
  return


exports.execute = (req, res) ->
  term = req.query.term
  country =  req.query.country
  title = SearchRoute.INFO_SEARCH_TITLE
  req.breadcrumbs(title, "/search")
  title = SearchRoute.SEARCH_RESULTS_TITLE
  req.breadcrumbs(title, "/search/results?term=#{term}&country=#{country}")

  api = new horusAPI(req, res, term, title, country)

  if country.toLowerCase() == "gb"
    api.ukCompanySearch()
  else
    api.intCompanySearch()
