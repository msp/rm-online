fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

class HorusAPI

  @SERVLET = "https://www.rmonline.com/servlet/com.armadillo.online"
  @UK_COMPANY_SEARCH_URL = "#{HorusAPI.SERVLET}?service=rm008&function=busmatch_nocaptcha&searchdata="
  @INT_COMPANY_SEARCH_URL = "#{HorusAPI.SERVLET}?service=rm008&function=intcomatch_rmonline_nocaptcha&databases=LDP&type=A&requestType=search&archdb=LPD"
  @FORMATIONS_URL = "#{HorusAPI.SERVLET}?service=einc&function=cosearch_ch_alt&Request=NameAvailableSearch&SearchRows=1&stylesheet=none&SearchData="

  @HTTP_ERROR = "Sorry, unsuccessful response from our search API. Please try again later."
  @TRANSPORT_ERROR = "ERROR transport error talking to Horus: "
  @SUFFIXES = ["LIMITED", "PLC", "LLP"]

  constructor: (@req, @res, @term, @title, @country, @suffix) ->
    @parser = new xml2js.Parser()
    @error =  undefined
    @results = undefined
    @template = "search/results"
    @results = undefined
    @debug = false
    @term = @term.trim()
    @country = country

  ukCompanySearch: ->
    console.log("UK companySearch")

    mappingCallback = (result) ->
      records = []
      for record, index in result.horus.row
        # first record is meta data
        if index > 0
          tmp =
            name: String(record.name)
            addressLine1: String(record.addressline1)
            addressLine2: String(record.addressline2)
            addressLine3: String(record.addressline3)
            registeredNumber: String(record.company)
          records.push tmp
      this.results = records

    @_search(HorusAPI.UK_COMPANY_SEARCH_URL+"#{@term}&stylesheet=none", mappingCallback)

  intCompanySearch: ->
    console.log("INT companySearch")

    mappingCallback = (result) ->
      records = []

      if result.horus.error
        this.error = { code: [97], description: result.horus.error }
      else
        for record in result.horus.DGX[0].CREDITMSGSRSV2[0].LOOKUPTRNRS[0].LOOKUPRS[0].LOOKUPRSCOMPANY
          tmp =
            name: String(record.NME)
            addressLine1: String(record.ADR_LINE)
            addressLine2: String(record.NON_POST_TOWN)
            addressLine3: String(record.POST_CODE)
            registeredNumber: String(record.DUNS_NBR)
          records.push tmp
        this.results = records

    # love this clean API :/
    @_search(HorusAPI.INT_COMPANY_SEARCH_URL+"&country=#{@country}&searchdata=#{@term}&searchdata2=#{@term}&companyName=#{@term}&stylesheet=none", mappingCallback)

  formationSearch: ->
    console.log("formationSearch")
    @template = "formations/results"
    @_removeAnyUserSuffixes()

    @_search(HorusAPI.FORMATIONS_URL+"#{@term} #{@suffix}", (result) -> this.results = result.horus)

  _removeAnyUserSuffixes: () ->
    for suffix in HorusAPI.SUFFIXES
      @term = @term.replace(new RegExp(suffix+"$", "gi"), "")

  _search: (@url, @callback) ->
    self = this
    responseBuffer = ""

    if self.term
      https.get(@url, (resp) ->
        resp.on "data", (chunk) ->
          responseBuffer += chunk

        resp.on "end", () ->
          if self.debug then console.log(responseBuffer)
          if resp.statusCode == 200
            self.parser.parseString responseBuffer, (err, result) ->
              if err && self.debug then inspect(err)
              if self.debug then inspect(result)

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
      suffix: self.suffix
      country: self.country
      error: self.error
    return

module.exports = HorusAPI
