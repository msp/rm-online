moment = require('moment')
formations = require('./formations')

exports.generate = (req, res) ->
  appUrl = 'http://rmonline.herokuapp.com'
  now = moment(new Date).format 'YYYY-MM-DD'

  res.header "Content-Type", "application/xml"

  res.render "sitemap",
    appUrl: appUrl
    now: now
    countries: formations.countries

  return
