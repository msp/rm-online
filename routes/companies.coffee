fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})
search = require('./search');

ACCOUNT_TYPES = ["Not Available"
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

IMAGES_SHIM = {
  ex: "Experian"
  ,db: "D&B"
  ,jd: "Jordans"
  ,eq: "Equifax"
  ,rm: "RM"
  ,rmi: "Companies House"
  ,cs: "Credit Safe"
}

exports.show = (req, res) ->
  if req.company
    title = req.company.name

  res.render "companies/show",
    title: title
    bcList: req.breadcrumbs()
    company: req.company
    error: req.error
    reports: req.reports
    account_types: ACCOUNT_TYPES
    images: IMAGES_SHIM


exports.viewReport = (req, res) ->

  vendor = req.params.vendor

  if req.company
    title = req.company.name
    req.breadcrumbs(IMAGES_SHIM[vendor.toLowerCase()], '/companies/'+req.params.cro+'/view/'+vendor)

  res.render "companies/view-report",
    title: title
    bcList: req.breadcrumbs()
    company: req.company
    error: req.error
    reports: req.reports
    vendor: vendor
    images: IMAGES_SHIM
  return

exports.param = (req, res, next, id) ->

  parser = new xml2js.Parser()
  title = id
  company = ""
  error = ""
  reports = undefined

  https.get("https://www.rmonline.com/servlet/com.armadillo.online?service=ccard_v2&function=cobasic_nocaptcha&reference="+id+"&stylesheet=none", (resp) ->
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

        if result.horus.error
          error = result.horus.error[0]
          console.log("ERROR from Horus")
          inspect(error)
          req.company = company
          req.error = error
          next()
        else
          company = result.horus.access_control[0].companies_house_data[0]
          reports =  result.horus.reports[0]

          inspect(company)
          inspect(reports)
          title = company.name
          req.breadcrumbs(title, '/companies/'+req.params.cro)
          req.company = company
          req.reports = reports
          next()

  ).on "error", (e) ->
    console.log "Got error: " + e.message
    error = {
              code: [99]
              description: [e.message]
            }
    console.log("ERROR transport error talking to Horus")
    req.company = company
    req.error = error
    next()
