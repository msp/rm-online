GoogleSpreadsheets = require("google-spreadsheets")
inspect = require('eyes').inspector({maxLength: false})

exports.index = (req, res) ->

  title = "Welcome to RM"
  h1 = ""
  heading= ""
  intro = "RM have been assisting law firms, accountants and professional service organisations with company information for due diligence and forming companies around the Globe for over 40 years. The services are discreet, professional and cost effective."
  meta =  "COMPANY FORMATION, REGISTRATION, REPORTS AND CREDIT CHECKS FOR ANY UK OR OFFSHORE COMPANY"
  outro = ""
  funnels = [
    {
      title: "UK & International Business Reports"
      body: "The only consolidator of all the major brand products from D&B, Experian, Equifax, EBR and RM."
    }
    {
      title: "Company Documents"
      body: "Available from Companies House and 200 countries across the globe, many instantly."
    }
    {
      title: "UK Company Formations"
      body: "Fast, professional, easy."
    }
    {
      title: "International Company Formations"
      body: "Simple, professional, cost effective."
    }
    {
      title: "Company Admin Services"
      body: "Making things simple for you."
    }

  ]
  partners = []

  # https://docs.google.com/spreadsheets/d/1UdXbKkQawR5dPbPFzt8efE0CO9i1cDCW1z6A7HUo3qo/pubhtml
  GoogleSpreadsheets
    key: "1UdXbKkQawR5dPbPFzt8efE0CO9i1cDCW1z6A7HUo3qo"
  , (err, spreadsheet) ->
    console.log("ERROR: #{err}")
    if !err
      spreadsheet.worksheets[0].cells
        range: "R1C1:R23C23"
      , (err, cells) ->

        inspect(cells.cells)

        title             = cells.cells[2][1].value
        h1                = cells.cells[2][2].value
        heading           = cells.cells[2][3].value
        intro             = cells.cells[2][4].value
        meta              = cells.cells[2][5].value
        outro             = cells.cells[2][6].value
        funnels[0].title  = cells.cells[2][7].value
        funnels[0].body   = cells.cells[2][8].value
        funnels[1].title  = cells.cells[2][9].value
        funnels[1].body   = cells.cells[2][10].value
        funnels[2].title  = cells.cells[2][11].value
        funnels[2].body   = cells.cells[2][12].value
        funnels[3].title  = cells.cells[2][13].value
        funnels[3].body   = cells.cells[2][14].value
        funnels[4].title  = cells.cells[2][15].value
        funnels[4].body   = cells.cells[2][16].value
        partners[0]       = cells.cells[2][17].value
        partners[1]       = cells.cells[2][18].value
        partners[2]       = cells.cells[2][19].value
        partners[3]       = cells.cells[2][20].value
        partners[4]       = cells.cells[2][21].value
        partners[5]       = cells.cells[2][22].value


        res.render "pages/home",
          title: title
          h1: h1
          heading: heading
          intro: intro
          meta: meta
          outro: outro
          funnels: funnels
          partners: partners
          extendTemplate: true

    else
      res.render "pages/home",
        title: title
        h1: h1
        heading: heading
        intro: intro
        meta: meta
        outro: outro
        funnels: funnels
        partners: partners
        extendTemplate: true
    return
return
