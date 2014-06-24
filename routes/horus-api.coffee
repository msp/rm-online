fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

class HorusAPI

  @SERVLET = "https://www.rmonline.com/servlet/com.armadillo.online"
  @COMPANY_SEARCH_URL = "#{HorusAPI.SERVLET}?service=rm008&function=busmatch_nocaptcha&searchdata="
  @FORMATIONS_URL = "#{HorusAPI.SERVLET}?service=einc&function=cosearch_ch&Request=NameAvailableSearch&SearchRows=1&stylesheet=none&SearchData="

  @HTTP_ERROR = "Sorry, unsuccessful response from our search API. Please try again later."
  @TRANSPORT_ERROR = "ERROR transport error talking to Horus: "

  constructor: (@req, @res, @term, @title, @country) ->
    @parser = new xml2js.Parser()
    @error =  undefined
    @results = undefined
    @template = "search/results"
    @results = undefined
    @debug = true

  companySearch: ->
    console.log("companySearch")
    @_search(HorusAPI.COMPANY_SEARCH_URL+"#{@term}&stylesheet=none", (result) -> this.results = result.horus.row)

  formationSearch: ->
    console.log("formationSearch")
    @template = "formations/results"
    # after lunch walk the DOM
    @_search(HorusAPI.FORMATIONS_URL+"#{@term}", (result) -> this.results = result.horus.GovTalkMessage)

  _search: (@url, @callback) ->
    self = this
    responseBuffer = ""

    if self.term
      https.get(@url, (resp) ->
        resp.on "data", (chunk) ->
          responseBuffer += chunk;

        resp.on "end", () ->
          console.log(responseBuffer)
          if resp.statusCode == 200
            self.parser.parseString responseBuffer, (err, result) ->
              if err && self.debug then inspect(err)

              self.callback(result)

              if self.debug then inspect(self.results)
              self._renderTemplate()
          else
            self.error = { code: [98], description: [HorusAPI.HTTP_ERROR] }
            self._renderTemplate()

      ).on "error", (e) ->
        console.log(HorusAPI.TRANSPORT_ERROR+e.message)
        self.error = { code: [99], description: [e.message]}
        self._renderTemplate()
    else
      self._renderTemplate()

  _renderTemplate: () ->
    self = this
    self.res.render self.template,
      title: self.title
      bcList: self.req.breadcrumbs()
      results: self.results
      term: self.term
      country: self.country
      error: self.error
    return

module.exports = HorusAPI
