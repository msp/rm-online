fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

exports.index = (req, res) ->
  title = "UK Company Information Search"
  req.breadcrumbs(title, 'search')
  res.render "search/index",
    title: title
    bcList: req.breadcrumbs()
  return


exports.execute = (req, res) ->
  title = "UK Company Information Search"
  req.breadcrumbs(title, 'search')
  title = "Search Results"
  req.breadcrumbs(title, 'search')

  parser = new xml2js.Parser()
  error = undefined
  results = undefined

  term = req.body.searchTerm

  https.get("https://www.rmonline.com/servlet/com.armadillo.online?service=rm008&function=busmatch_nocaptcha&searchdata="+term+"&stylesheet=none", (resp) ->
    console.log("##################################################")
    console.log "Got response: " + resp.statusCode
    console.log("##################################################")

    responseBuffer = ""

    resp.on "data", (chunk) ->
      responseBuffer += chunk;

    resp.on "end", () ->
      # console.log(responseBuffer)
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
        return


  ).on "error", (e) ->
    console.log "Got error: " + e.message
    error = {
      code: 99
      description: e.message
    }
    console.log("ERROR transport error talking to Horus")
    req.error = error
    res.render "search/results",
      title: title
      bcList: req.breadcrumbs()
      results: results
    return