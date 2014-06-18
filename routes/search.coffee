fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

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
  country =  req.params.country
  term = req.query.term
  title = SearchRoute.UK_INFO_SEARCH_TITLE
  req.breadcrumbs(title, "/search/#{country}")
  title = SearchRoute.SEARCH_RESULTS_TITLE
  req.breadcrumbs(title, "/search/#{country}/results?term=#{term}")

  parser = new xml2js.Parser()
  error = undefined
  results = undefined

  if term
    https.get("https://www.rmonline.com/servlet/com.armadillo.online?service=rm008&function=busmatch_nocaptcha&searchdata="+term+"&stylesheet=none", (resp) ->
      console.log("##################################################")
      console.log "Got response: " + resp.statusCode
      console.log("##################################################")

      responseBuffer = ""

      resp.on "data", (chunk) ->
        responseBuffer += chunk;

      resp.on "end", () ->
      # console.log(responseBuffer)
        if resp.statusCode == 200
          parser.parseString responseBuffer, (err, result) ->
            # inspect(err)
            # inspect(result)
            console.log("RESULTS from Horus")
            results =  result.horus.row

            inspect(results)

            res.render "search/results",
              title: title
              bcList: req.breadcrumbs()
              results: results
              term: term
              country: country
            return
        else
          error = {
            code: [98]
            description: ["Sorry, unsuccessful response from our search API. Please try again later."]
          }

          res.render "search/results",
            title: title
            bcList: req.breadcrumbs()
            results: results
            term: term
            country: country
            error: error
          return


    ).on "error", (e) ->
      console.log("ERROR transport error talking to Horus: "+e.message)
      error = {
        code: [99]
        description: [e.message]
      }
      res.render "search/results",
        title: title
        bcList: req.breadcrumbs()
        results: results
        term: term
        error: error
      return
  else
    res.render "search/results",
      title: title
      bcList: req.breadcrumbs()
      results: undefined
      term: term
      country: country
    return
