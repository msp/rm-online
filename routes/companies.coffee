fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

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


exports.viewReport = (req, res) ->

  vendor = req.params.vendor

  if req.company
    title = req.company.name
    req.breadcrumbs(vendor, '/companies/'+req.params.cro+'/view/'+vendor)

  res.render "companies/view-report",
    title: title
    bcList: req.breadcrumbs()
    company: req.company
    error: req.error
    reports: req.reports
    vendor: vendor
  return

exports.param = (req, res, next, id) ->

  parser = new xml2js.Parser()
  title = id
  company = ""
  error = ""
  reports = ""

  https.get("https://www.rmonline.com/servlet/com.armadillo.online?service=rm008&function=cobasic_nocaptcha&reference="+id+"&stylesheet=none", (resp) ->
    console.log("##################################################")
    console.log "Got response: " + resp.statusCode

    resp.on "data", (data) ->
      console.log("##################################################")

      parser.parseString data, (err, result) ->
        # inspect(result)

        if result.horus.error
          error = result.horus.error[0]
          console.log("ERROR from Horus")
          req.company = company
          req.error = error
          next()
        else
          company = result.horus.access_control[0].companies_house_data[0]
          reports =  result.horus.reports[0]

          inspect(company)
          title = company.name
          req.breadcrumbs(title, '/companies/'+req.params.cro)
          req.company = company
          req.reports = reports
          next()

  ).on "error", (e) ->
    console.log "Got error: " + e.message
    error = {
              code: 99
              description: e.message
            }
    console.log("ERROR transport error talking to Horus")
    req.company = company
    req.error = error
    next()
