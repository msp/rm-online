fs = require 'fs'
https = require 'https'
xml2js = require 'xml2js'
slug = require 'slug'
inspect = require('eyes').inspector({maxLength: false})
search = require('./search')
HorusAPI = require('./horus-api')
Company = require('./models/company')

# TODO move to utils
Array::toDict = (key) ->
  @reduce ((dict, obj) -> dict[ obj[key] ] = obj if obj[key]?; return dict), {}

exports.ACCOUNT_TYPES = ["Not Available"
                ,"Full Accounts"
                ,"Small Company"
                ,"Medium Company"
                ,"Group Accounts"
                ,"Dormant"
                ,"Interim"
                ,"Initial"
                ,"Not Available"
                ,"Full Accounts"
                ,"Small Company"
                ,"Medium Company"
                ,"Group Accounts"
                ,"Dormant"
                ,"Interim"
                ,"Initial"]

exports.IMAGES_SHIM = {
  ex: "Experian"
  db: "D&B"
  jd: "Jordans"
  eq: "Equifax"
  rm: "RM"
  rmi: "Companies House"
  cs: "Credit Safe"
}

exports.CABINETS = [
  {
    cabinet: "acc"
    label: "Accounts documents"
    short: "Accounts"
  }
  {
    cabinet: "363"
    label: "Annual Return documents"
    short: "Returns"
  }
  {
    cabinet: "newc"
    label: "New company documents"
    short: "Incorp."
  }
  {
    cabinet: "con"
    label: "Change of name documents"
    short: "Name Change"
  }
  {
    cabinet: "287"
    label: "Changes of registered office documents"
    short: "Office"
  }
  {
    cabinet: "288"
    label: "Changes of directors documents"
    short: "Directors"
  }
  {
    cabinet: "cap"
    label: "Capital details documents"
    short: "Capital"
  }
  {
    cabinet: "misc"
    label: "Miscellaneous documents"
    short: "Misc"
  }
  {
    cabinet: "mort"
    label: "Mortgage documents"
    short: "Mortgage"
  }
  {
    cabinet: "eire"
    label: "Irish Republic documents"
    short: "Irish"
  }
  {
    cabinet: "liq"
    label: "Liquidation documents"
    short: "Liquid."
  }
  {
    cabinet: "other"
    label: "Other Documents"
    short: "Other"
  }
]

CABINETS_DICT = exports.CABINETS.toDict("cabinet")

exports.show = (req, res) ->
  console.log("companies SHOW, company: #{req.params.cro}")
  title = ""
  api = new HorusAPI(req, res, req.params.cro, title, req.params.country)

  if req.params.country.toLowerCase() == "gb"
    api.ukCompany()
  else
    api.intCompany()

exports.viewReports = (req, res) ->
  console.log("companies REPORTS, company: #{req.params.cro}")
  title = ""
  api = new HorusAPI(req, res, req.params.cro, title, req.params.country)

  if req.params.country.toLowerCase() == "gb"
    api.ukCompanyReports()
  else
    api.intCompanyReports()

exports.viewDocuments = (req, res) ->
  console.log("companies Documents, company: #{req.params.cro}")
  title = ""
  api = new HorusAPI(req, res, req.params.cro, title, req.params.country)
  api.ukCompanyDocuments()

# callbacks
exports.ukMappingCallback = (result) ->

  if result.horus.error
    this.error = result.horus.error[0]
    console.log("ERROR from Horus")
    inspect(this.error)
  else
    this.results = result.horus.access_control[0].companies_house_data
    this.reports =  result.horus.reports[0]

    vendors = Object.keys(result.horus.documents[0])
    ungrouped = result.horus.documents[0]

    grouped = []

    # we need to group the docs by vendor, then cabinet
    for vendor in vendors
      # console.log("VENDOR: "+vendor)
      if vendor = "RM"
        do (vendor) ->
          tmpVendor = {}
          vendorDocs = []
          for group in exports.CABINETS
            do (group) ->
              key = group.cabinet
              tmpGrp = {}
              tmpGrp["name"] = key
              tmpGrp["values"] = ungrouped[vendor][0].document.filter (doc) -> doc.$.cabinet == group.cabinet
              tmpGrp["short"] = CABINETS_DICT[key].short
              tmpGrp["label"] = CABINETS_DICT[key].label
              vendorDocs.push tmpGrp
          tmpVendor[vendor] = vendorDocs
          grouped.push tmpVendor
    # inspect grouped

    this.documentsByCabinet = grouped
    this.documents = result.horus.documents[0]

    company = new Company

    company.id = this.results[0].cro_number
    company.name =  this.results[0].name
    company.address1 = this.results[0].ro_address[0].line_one
    company.address2 = this.results[0].ro_address[0].line_two
    company.address3 = this.results[0].ro_address[0].line_three
    company.address4 = this.results[0].ro_address[0].line_four

    if String(company.address3) != String(this.results[0].ro_address[0].postcode) &&
       String(company.address4) != String(this.results[0].ro_address[0].postcode)
      company.postcode = this.results[0].ro_address[0].postcode


    company.type = this.results[0].company_type_description
    company.incorporationDate = this.results[0].incorporation_date
    company.status = this.results[0].company_status
    company.latestAccounts = this.results[0].acc_made_up_date
    company.latestAnnualReturn = this.results[0].ret_made_up_date
    company.accountsType = exports.ACCOUNT_TYPES[this.results[0].accounts_type]

    this.company = company
    this.title = company.name
    this.country = this.req.params.country

    buildBreadcrumbs(this.req, company.name)

exports.ukValidationCallback = () ->
  console.log("validationCallback, term: [#{this.term}]")
  if !this.term then this._renderTemplate()

exports.intMappingCallback = (result) ->

  if result.horus.error
    this.error = result.horus.error[0]
    console.log("ERROR from Horus")
    inspect(this.error)
  else
    this.results = result.horus.DGX[0].CREDITMSGSRSV2[0].LOOKUPTRNRS[0].LOOKUPRS[0].LOOKUPRSCOMPANY
    this.reports = result.horus.DGX[0].reports[0]
    this.document = []

    company = new Company

    inspect(this.results)
    company.id = this.results[0].DUNS_NBR
    company.name =  this.results[0].NME
    company.address1 = this.results[0].ADR_LINE
    company.address2 = this.results[0].POST_CODE
    # company.address3 = this.results[0].ro_address[0].line_three
    # company.address4 = this.results[0].ro_address[0].line_four
    # company.postcode = this.results[0].POST_CODE
    # company.type = this.results[0].company_type_description
    # company.incorporationDate = this.results[0].incorporation_date
    # company.status = this.results[0].company_status
    # company.latestAccounts = this.results[0].acc_made_up_date
    # company.latestAnnualReturn = this.results[0].ret_made_up_date
    # company.accountsType = exports.ACCOUNT_TYPES[this.results[0].accounts_type]

    this.company = company
    this.title = company.name

    buildBreadcrumbs(this.req, company.name)

exports.intValidationCallback = () ->
  console.log("validationCallback, term: [#{this.term}]")

buildBreadcrumbs = (req, name) ->
  companyURL = "/companies/#{req.params.country}/#{req.params.cro}/#{slug(name).toLowerCase()}"
  req.breadcrumbs(name, companyURL)

  if req.params.vendor
    label = "Reports"
    if /documents/i.test(req.path) then label = "Documents"
    req.breadcrumbs("#{exports.IMAGES_SHIM[req.params.vendor]} #{label}", "#{companyURL}/reports/#{req.params.vendor}")
