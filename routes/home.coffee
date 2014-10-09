GoogleSpreadsheets = require("google-spreadsheets")
GoogleClientLogin = require("googleclientlogin").GoogleClientLogin
inspect = require('eyes').inspector({maxLength: false})

exports.index = (req, res) ->

  title = "Welcome to RM"
  intro = "RM have been assisting law firms, accountants and professional service organisations with company information for due diligence and forming companies around the Globe for over 40 years. The services are discreet, professional and cost effective."
  meta =  "COMPANY FORMATION, REGISTRATION, REPORTS AND CREDIT CHECKS FOR ANY UK OR OFFSHORE COMPANY"
  subTitle = ""
  outro = ""
  # https://docs.google.com/spreadsheets/d/1UdXbKkQawR5dPbPFzt8efE0CO9i1cDCW1z6A7HUo3qo/pubhtml
  GoogleSpreadsheets
    key: "1UdXbKkQawR5dPbPFzt8efE0CO9i1cDCW1z6A7HUo3qo"
  , (err, spreadsheet) ->
    console.log("ERROR: #{err}")
    if !err
      spreadsheet.worksheets[0].cells
        range: "R1C1:R10C10"
      , (err, cells) ->
        title     = cells.cells[2][1].value
        intro     = cells.cells[2][2].value
        meta      = cells.cells[2][3].value
        outro     = cells.cells[2][4].value

        # inspect(cells.cells)

        res.render "pages/home",
          title: title
          intro: intro
          meta: meta
          subTitle: subTitle
          outro: outro

    else
      res.render "pages/home",
        title: title
        intro: intro
        meta: meta
        outro: outro
    return
return
