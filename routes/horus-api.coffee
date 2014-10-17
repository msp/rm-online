fs = require 'fs',
https = require 'https',
http = require 'http',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
companies = require('./companies')
config = require('config')

class HorusAPI

  @SERVLET = "/servlet/com.armadillo.online"
  @UK_COMPANY_SEARCH_URL = "#{HorusAPI.SERVLET}?service=rm008&function=busmatch_nocaptcha&stylesheet=none&searchdata="
  @INT_COMPANY_SEARCH_URL = "#{HorusAPI.SERVLET}?service=rm008&function=intcomatch_rmonline_nocaptcha&databases=LDP&type=A&requestType=search&archdb=LPD&stylesheet=none"
  @FORMATIONS_URL = "#{HorusAPI.SERVLET}?service=einc&function=cosearch_ch_alt&Request=NameAvailableSearch&SearchRows=1&stylesheet=none&SearchData="

  @UK_COMPANY_URL = "#{HorusAPI.SERVLET}?service=ccard_v3&function=cobasic_nocaptcha&stylesheet=none&reference="
  @INT_COMPANY_URL = "#{HorusAPI.SERVLET}?service=ccard_v3&function=intcobasic&requestType=product&stylesheet=none&session=&companyID="

  @TRANSPORT_ERROR = {code: 99, msg: "ERROR transport error talking to Horus: "}
  @HTTP_ERROR  = {code: 98, msg: "Sorry, unsuccessful response from our search API. Please try again later."}
  @HORUS_ERROR = {code: 97}
  @TIMEOUT_ERROR = {code: 94, msg:"Sorry, unable to get a response from our back end service after "}

  @SUFFIXES = ["LIMITED", "PLC", "LLP"]

  constructor: (@req, @res, @term, @title, @country) ->
    @parser = new xml2js.Parser()
    @error =  undefined
    @results = undefined
    @reports = undefined
    @documents = undefined
    @documentsByCabinet = undefined
    @template = "search/results"
    @results = undefined
    @debug = false
    @term = @term.trim()
    @country = country
    @company = undefined
    @pricePackages = []

  ukCompanyReports: ->
    console.log("UK company reports, vendor: #{this.req.params.vendor}")

    @template = "companies/view-reports"
    @_search(HorusAPI.UK_COMPANY_URL+"#{encodeURIComponent(@term)}", companies.ukMappingCallback, companies.ukValidationCallback)

  intCompanyReports: ->
    console.log("INT company reports, vendor: #{this.req.params.vendor}")

    @template = "companies/view-reports"
    @_search(HorusAPI.INT_COMPANY_URL+"#{encodeURIComponent(@term)}&country=#{@country.toUpperCase()}", companies.intMappingCallback, companies.intValidationCallback)

  ukCompanyDocuments: ->
    console.log("UK company documents, vendor: #{this.req.params.vendor}")

    @template = "companies/view-documents"
    @_search(HorusAPI.UK_COMPANY_URL+"#{encodeURIComponent(@term)}", companies.ukMappingCallback, companies.ukValidationCallback)

  ukCompany: ->
    console.log("UK company")

    @template = "companies/show"
    @_search(HorusAPI.UK_COMPANY_URL+"#{encodeURIComponent(@term)}", companies.ukMappingCallback, companies.ukValidationCallback)

  intCompany: ->
    console.log("INT company")

    @template = "companies/show"
    @_search(HorusAPI.INT_COMPANY_URL+"#{encodeURIComponent(@term)}&country=#{@country.toUpperCase()}", companies.intMappingCallback, companies.intValidationCallback)

  ukCompanySearch: ->
    console.log("UK companySearch")

    # callbacks
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

    validationCallback = () ->
      console.log("validationCallback, term: #{this.term}")
      if !this.term then this._renderTemplate()

    @_search(HorusAPI.UK_COMPANY_SEARCH_URL+"#{encodeURIComponent(@term)}", mappingCallback, validationCallback)

  intCompanySearch: ->
    console.log("INT companySearch")

    # callbacks
    mappingCallback = (result) ->
      records = []

      if result.horus.error
        this.error = { code: [HorusAPI.HORUS_ERROR.code], description: result.horus.error }
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

    validationCallback = () ->
      console.log("validationCallback, term: #{this.term}")
      if !this.term then this._renderTemplate()

    # love this API :/
    searchURL = HorusAPI.INT_COMPANY_SEARCH_URL+"&country=#{@country}&searchdata=#{encodeURIComponent(@term)}&searchdata2=#{encodeURIComponent(@term)}&companyName=#{encodeURIComponent(@term)}"

    if @req.query.region
      searchURL = searchURL + "&region=#{@req.query.region}"
    if @req.query.reasonCode
      searchURL = searchURL + "&reasonCode=#{@req.query.reasonCode}"

    @_search(searchURL, mappingCallback, validationCallback)

  formationSearch: ->
    console.log("formationSearch term: #{@term}, suffix: #{@req.query.suffix}")
    @template = "formations/results"
    @_removeAnyUserSuffixes()

    mappingCallback = (result) ->
      this.results = result.horus
      this.suffix = this.req.query.suffix
      govTalkErrors = 0

      if this.results.GovTalkMessage[0].GovTalkDetails[0].GovTalkErrors
        govTalkErrors = this.results.GovTalkMessage[0].GovTalkDetails[0].GovTalkErrors.length
        console.log("ERRORS govTalkErrors: #{govTalkErrors}")

      this.pricePackages = this.results.packages[0].package

      if govTalkErrors == 0
        numResults = this.results.GovTalkMessage[0].Body[0].NameSearch[0].SearchRows

        if numResults > 0
          this.title = "'#{this.term} #{this.suffix}' already registered"
        else
          this.title = "'#{this.term} #{this.suffix}' available"
      else
        govTalkError = this.results.GovTalkMessage[0].GovTalkDetails[0].GovTalkErrors[0].Error[0]
        this.error = { code: [govTalkError.Number], description: ["GovTalk #{govTalkError.RaisedBy}: #{govTalkError.Text}"] }
        this.results = undefined

    @_search(HorusAPI.FORMATIONS_URL+"#{encodeURIComponent(@term+' '+@req.query.suffix)}", mappingCallback)

  _removeAnyUserSuffixes: () ->
    for suffix in HorusAPI.SUFFIXES
      @term = @term.replace(new RegExp(suffix+"$", "gi"), "")

  _search: (@url, @callback, @validate) ->
    domain = config.get('express.horusDomain')
    console.log("URL: #{domain}#{@url}")
    self = this
    responseBuffer = ""
    timeOut = undefined
    timeOutThreshold = process.env.HORUS_TIMEOUT_MS || 15000

    options = {
      hostname: domain
      ,path: @url
      ,method: 'GET'
    }

    if self.validate then self.validate()

    horusGet = http.request(options, (resp) ->

      resp.on "data", (chunk) ->
        responseBuffer += chunk

      resp.on "end", () ->
        if self.debug then console.log(responseBuffer)
        console.log(resp.statusCode)
        if resp.statusCode == 200
          self.parser.parseString responseBuffer, (err, result) ->
            if err && self.debug then inspect(err)
            if self.debug then inspect(result)

            self.callback(result)

            if self.debug then inspect(self.results)
            self._renderTemplate()
        else
          self.error = { code: [HorusAPI.HTTP_ERROR.code], description: [HorusAPI.HTTP_ERROR.msg] }
          self._renderTemplate()
    )

    # Heroku has 30 secs reponse limit before we get platform errors
    # lets limit req times and handle long running reqs gracefully
    timeOutCallback = ->
      horusGet.emit "horus-timeout"
      return
    timeOut = setTimeout(timeOutCallback, timeOutThreshold)

    horusGet.addListener "response", () ->
      clearTimeout(timeOut)

    horusGet.on "horus-timeout", () ->
      self.error = { code: [HorusAPI.TIMEOUT_ERROR.code], description: [HorusAPI.TIMEOUT_ERROR.msg+timeOutThreshold/1000+" seconds."] }
      horusGet.abort()

    horusGet.on "error", (e) ->
      console.log(HorusAPI.TRANSPORT_ERROR.msg+e.message)
      inspect e
      if !self.error
        self.error = { code: [HorusAPI.TRANSPORT_ERROR.code], description: [e.message]}
      self._renderTemplate()

    horusGet.end()

  # TODO this is WAY overloaded to cater for each template
  _renderTemplate: () ->
    self = this
    self.res.render self.template,
      title: self.title
      bcList: self.req.breadcrumbs()
      results: self.results
      company: self.company
      reports: self.reports
      documents: self.documents
      documentsByCabinet: self.documentsByCabinet
      term: self.term
      suffix: self.suffix
      country: self.country
      vendor: self.req.params.vendor
      account_types: companies.ACCOUNT_TYPES
      images: companies.IMAGES_SHIM
      searchURL: "/company-formations/UK/search/results"
      pricePackages: self.pricePackages
      error: self.error
    return

module.exports = HorusAPI
