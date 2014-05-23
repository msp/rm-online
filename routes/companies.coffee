fs = require 'fs',
xml2js = require 'xml2js'
inspect = require('eyes').inspector({maxLength: false})

exports.show = (req, res) ->

  parser = new xml2js.Parser()

  file = __dirname + '/../horus/results/bus_pro.xml'
  
  company = ""
  
  fs.readFile file, (err, data) ->
    
    parser.parseString data, (err, result) ->
#      inspect(result)
      console.log('Done');
      console.log("**************************************************")
      
      company = result.horus.access_control[0].companies_house_data[0]

  
#      console.log("Company : "+company)
      inspect(company)
      console.log("+++++++++++++++++++++++++++++++++++++++++++++++++++++")
      
      title = req.params.id
      req.breadcrumbs(title, 'companies/'+req.params.id)
      
      res.render "companies/show",
        title: title
        bcList: req.breadcrumbs()
        company: company
      return