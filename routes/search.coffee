fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
horusAPI = require('./horus-api')

class SearchRoute
  @SEARCH_RESULTS_TITLE: "Search Results"
  @UK_INFO_SEARCH_TITLE: "UK Company Information Search"

exports.SearchRoute = SearchRoute

exports.index = (req, res) ->
  title = SearchRoute.UK_INFO_SEARCH_TITLE
  country =  if req.params.country then req.params.country else "UK"
  req.breadcrumbs(title, "/search/#{country}")
  res.render "search/index",
    title: title
    bcList: req.breadcrumbs()
    country: country
  return


exports.execute = (req, res) ->

  term = req.query.term
  country =  req.params.country
  title = SearchRoute.UK_INFO_SEARCH_TITLE
  req.breadcrumbs(title, "/search/#{country}")
  title = SearchRoute.SEARCH_RESULTS_TITLE
  req.breadcrumbs(title, "/search/#{country}/results?term=#{term}")

  api = new horusAPI(req, res, term, title, country)
  api.companySearch()
