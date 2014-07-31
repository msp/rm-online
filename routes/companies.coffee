fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
search = require('./search');
horusAPI = require('./horus-api')

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
  ,db: "D&B"
  ,jd: "Jordans"
  ,eq: "Equifax"
  ,rm: "RM"
  ,rmi: "Companies House"
  ,cs: "Credit Safe"
}

exports.show = (req, res) ->
  console.log("companies SHOW, company: #{req.params.cro}")
  title = ""
  api = new horusAPI(req, res, req.params.cro, title, req.params.country)

  if req.params.country.toLowerCase() == "gb"
    api.ukCompany()
  else
    api.intCompany()

exports.viewReport = (req, res) ->
  console.log("companies REPORTS, company: #{req.params.cro}")
  title = ""
  api = new horusAPI(req, res, req.params.cro, title, req.params.country)
  api.ukCompanyReports()


# callbacks
exports.ukMappingCallback = (result) ->

  if result.horus.error
    this.error = result.horus.error[0]
    console.log("ERROR from Horus")
    inspect(this.error)
  else
    this.results = result.horus.access_control[0].companies_house_data
    this.reports =  result.horus.reports[0]

    this.company = this.results[0]
    this.title = this.company.name

  this.req.breadcrumbs(this.title, "/companies/#{this.req.params.country}/#{this.req.params.cro}")

exports.ukValidationCallback = () ->
  console.log("validationCallback, term: [#{this.term}]")
  if !this.term then this._renderTemplate()

exports.intMappingCallback = (result) ->

  this.results = []
  this.error = { code: [88], description: ["Session lockdown! We need this removed from Horus"] }

exports.intValidationCallback = () ->
  console.log("validationCallback, term: [#{this.term}]")
  if !this.term then this._renderTemplate()
