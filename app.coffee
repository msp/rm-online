express = require("express")
breadcrumbs = require('express-breadcrumbs')
path = require("path")
favicon = require("static-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
stylus = require('stylus')

#routes
terms = require('./routes/terms')
faq = require('./routes/faq')
companies = require('./routes/companies')
search = require('./routes/search')
formations = require('./routes/formations')
mockCheckout = require('./routes/mockCheckout')
sitemap = require('./routes/sitemap')
companyAdmin = require('./routes/company-admin')

app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# breadcrumbs
app.use(breadcrumbs.init())
app.use(breadcrumbs.setHome("Home"))

app.use(favicon(__dirname + '/public/favicon.ico'))
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()

# grunt is tasking care of this instead. Remove?
app.use stylus.middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))

#  helpers
app.locals.slug = require('slug')
app.locals.moment = require('moment')

# filters
# app.param('cro', companies.param)
# app.param('jurisdiction', formations.param)

# routes
app.get "/", (req, res) ->
  title = "Home"
  res.render "pages/home",
    title: title
  return

app.get "/news", (req, res) ->
  title = "Industry News"
  req.breadcrumbs(title, 'news')

  res.render "pages/news",
    title: title
    bcList: req.breadcrumbs()
    path: req.path
  return

app.get "/about", (req, res) ->
  title = "About Us"
  req.breadcrumbs(title, 'about')
  res.render "pages/about",
    title: title
    bcList: req.breadcrumbs()
    extendTemplate: true
  return

app.get "/services", (req, res) ->
  title = "Services"
  req.breadcrumbs(title, 'services')
  res.render "pages/services",
    title: title
    bcList: req.breadcrumbs()
  return

app.get "/contact", (req, res) ->
  title = "Contact"
  req.breadcrumbs(title, 'contact')
  res.render "pages/contact",
    title: title
    bcList: req.breadcrumbs()
  return

# Static
app.get('/faq', faq.index)
app.get('/terms', terms.index)

# Business Profiles
app.get('/companies/:country/:cro', companies.show)
app.get('/companies/:country/:cro/reports/:vendor', companies.viewReports)
app.get('/companies/:country/:cro/documents/:vendor', companies.viewDocuments)
## SEO versions
app.get('/companies/:country/:cro/:name', companies.show)
app.get('/companies/:country/:cro/:name/reports/:vendor', companies.viewReports)
app.get('/companies/:country/:cro/:name/documents/:vendor', companies.viewDocuments)

# Search
app.get('/search', search.index)
app.get('/search/results', search.execute)
app.get('/search/:country', search.index)
app.get('/search/:country/results', search.execute)

# Formations
app.get("/company-formations/international", formations.international)
app.get("/company-formations/international/:jurisdiction", formations.internationalShow)
app.get("/company-formations/UK", formations.uk)
app.get("/company-formations/UK/results", formations.search)

#  Admin
app.get("/company-admin-services", companyAdmin.index)

# Checkout
app.post("/mock-checkout", mockCheckout.index)

app.get "/checkout", (req, res) ->
  title = "Review your basket"
  req.breadcrumbs(title, 'checkout')
  res.render "checkout",
    title: title
    bcList: req.breadcrumbs()
    path: req.path
    verb: req.method
  return

app.get "/company-formations/iframe", (req, res) ->
  title = "Spiking the iFrame integration"
  req.breadcrumbs(title, 'iframe')
  res.render "formations/iframe",
    title: title
    bcList: req.breadcrumbs()
  return

app.get "/company-formations/spike", (req, res) ->
  title = "Spiking the iFrame integration"
  req.breadcrumbs(title, 'spike')
  res.render "formations/spike",
    title: title
    bcList: req.breadcrumbs()
  return

# Sitemap
app.get "/sitemap.xml", sitemap.generate

#/ catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err
  return


#/ error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render "error",
      message: err.message
      error: err

    return


# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render "error",
    message: err.message
    error: {}

  return

module.exports = app
