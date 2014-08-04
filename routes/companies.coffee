fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
search = require('./search');
horusAPI = require('./horus-api')

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
  api = new horusAPI(req, res, req.params.cro, title, req.params.country)

  if req.params.country.toLowerCase() == "gb"
    api.ukCompany()
  else
    api.intCompany()

exports.viewReports = (req, res) ->
  console.log("companies REPORTS, company: #{req.params.cro}")
  title = ""
  api = new horusAPI(req, res, req.params.cro, title, req.params.country)
  api.ukCompanyReports()

exports.viewDocuments = (req, res) ->
  console.log("companies Documents, company: #{req.params.cro}")
  title = ""
  api = new horusAPI(req, res, req.params.cro, title, req.params.country)
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

    console.log("CABINETS_DICT: #{CABINETS_DICT["acc"].short}")

    # we need to group the docs by vendor, then cabinet
    for vendor in vendors
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

    this.company = this.results[0]
    this.title = this.company.name

  companyURL = "/companies/#{this.req.params.country}/#{this.req.params.cro}"
  this.req.breadcrumbs(this.title, companyURL)

  if this.req.params.vendor
    label = "Reports"
    if /documents/i.test(this.req.path) then label = "Documents"

    this.req.breadcrumbs("#{exports.IMAGES_SHIM[this.req.params.vendor]} #{label}", "#{companyURL}/reports/#{exports.IMAGES_SHIM[this.req.params.vendor]}")



exports.ukValidationCallback = () ->
  console.log("validationCallback, term: [#{this.term}]")
  if !this.term then this._renderTemplate()

exports.intMappingCallback = (result) ->

  this.results = []
  this.error = { code: [88], description: ["Session lockdown! We need this removed from Horus"] }

exports.intValidationCallback = () ->
  console.log("validationCallback, term: [#{this.term}]")
  if !this.term then this._renderTemplate()
