fs = require 'fs',
https = require 'https',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

exports.show = (req, res) ->

  parser = new xml2js.Parser()
  title = req.params.id
  company = ""
  error = ""

  https.get("https://www.rmonline.com/servlet/com.armadillo.online?service=rm008&function=cobasic_nocaptcha&reference="+req.params.id+"&stylesheet=none", (resp) ->
    console.log("##################################################")
    console.log "Got response: " + resp.statusCode

    resp.on "data", (data) ->
      console.log("##################################################")

      parser.parseString data, (err, result) ->
        # inspect(result)

        if result.horus.error
          error = result.horus.error[0]
        else
          company = result.horus.access_control[0].companies_house_data[0]

          # inspect(company)
          title = company.name
          req.breadcrumbs(title, 'companies/'+req.params.id)

        res.render "companies/show",
          title: title
          bcList: req.breadcrumbs()
          company: company
          error: error
        return

    return

  ).on "error", (e) ->
    console.log "Got error: " + e.message
    error = {
              code: 99
              description: e.message
            }
    res.render "companies/show",
      title: title
      bcList: req.breadcrumbs()
      company: company
      error: error
    return
