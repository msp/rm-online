require('newrelic')
express = require("express")
breadcrumbs = require('express-breadcrumbs')
path = require("path")
favicon = require("static-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
stylus = require('stylus')
config = require('config')
compression = require('compression')
memwatch = require('memwatch')
inspect = require('eyes').inspector({maxLength: false})


#routes
home = require('./routes/home')
terms = require('./routes/terms')
faq = require('./routes/faq')
privacy = require('./routes/privacy')
companies = require('./routes/companies')
search = require('./routes/search')
formations = require('./routes/formations')
mockCheckout = require('./routes/mockCheckout')
sitemap = require('./routes/sitemap')
companyAdmin = require('./routes/company-admin')

app = express()

memwatch.on "leak", (info) ->
  console.log "LEAK"
  inspect info
  return

memwatch.on "stats", (stats) ->
  console.log "STATS"
  inspect stats
  return

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

#  gzip responses
app.use(compression());

# breadcrumbs
app.use(breadcrumbs.init())
app.use(breadcrumbs.setHome("Home"))

app.use(favicon(__dirname + '/public/favicon.ico', { maxAge: config.get('express.staticCache') }))
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()

# grunt is tasking care of this instead. Remove?
app.use(stylus.middleware(path.join(__dirname, "public")))
app.use(express.static(path.join(__dirname, "public"), { maxAge: config.get('express.staticCache') }))

#  helpers
app.locals.slug = require('slug')
app.locals.moment = require('moment')

# filters
# app.param('cro', companies.param)
# app.param('jurisdiction', formations.param)

# routes
app.get('/', home.index)

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

  #  tmp until SEO finalised then remove
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
  res.render "pages/about",
    title: title
    bcList: req.breadcrumbs()
    extendTemplate: true
    funnels: funnels
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

app.get "/corporate-social-responsibility", (req, res) ->
  title = "Corporate Social Responsibility"
  req.breadcrumbs(title, 'corporate-social-responsibility')
  res.render "pages/corporate-social-responsibility",
    title: title
    bcList: req.breadcrumbs()
  return

# Static
app.get('/faq', faq.index)
app.get('/terms', terms.index)
app.get('/privacy-and-cookies', privacy.index)

# Business Profiles
app.get('/companies/:country/:cro', companies.show)
app.get('/companies/:country/:cro/reports/:vendor', companies.viewReports)
app.get('/companies/:country/:cro/documents/:vendor', companies.viewDocuments)
## SEO versions
app.get('/companies/:country/:cro/:name', companies.show)
app.get('/companies/:country/:cro/:name/reports/:vendor', companies.viewReports)
app.get('/companies/:country/:cro/:name/documents/:vendor', companies.viewDocuments)

# Search
app.get('/uk-and-international-reports', search.reports)
app.get('/uk-and-international-reports/results', search.execute)
app.get('/uk-and-international-reports/search', search.reports)
app.get('/uk-and-international-reports/search/results', search.execute)

app.get('/company-documents', search.documents)
app.get('/company-documents/results', search.execute)
app.get('/company-documents/search', search.documents)
app.get('/company-documents/search/results', search.execute)

# Formations
app.get("/company-formations/international", formations.international)
app.get("/company-formations/international/:jurisdiction", formations.internationalShow)
app.get("/company-formations", formations.uk)
app.get("/company-formations/UK", formations.uk)
app.get("/company-formations/UK/search", formations.uk)
app.get("/company-formations/UK/search/results", formations.search)
app.get("/company-formations/payment-successful", formations.paymentSuccessful)

#  Admin
app.get("/company-admin-services", companyAdmin.index)
app.get("/company-admin-services/prices", companyAdmin.prices)

# Checkout

app.post("/mock-checkout", mockCheckout.index)

app.get "/payment-successful/:type/:extension/:session", (req, res) ->
  title = "Payment Successful"
  req.breadcrumbs(title, 'success')

  res.render "checkout",
    title: title
    bcList: req.breadcrumbs()
    path: req.path
    verb: req.method
    url: "http://web.rmonline.com/#{req.params.type}/#{req.params.session}.#{req.params.extension}"
  return

app.get "/checkout", (req, res) ->
  title = "Review your basket"
  req.breadcrumbs(title, 'checkout')
  res.render "checkout",
    title: title
    bcList: req.breadcrumbs()
    path: req.path
    verb: req.method
    url: ""
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

# Old Redirects
app.get "/tm-registration.html", (req, res) -> res.redirect(301, "/services")
app.get "/tm-*-faq.html", (req, res) -> res.redirect(301, "/faq")
app.get "/tm-registration*.html", (req, res) -> res.redirect(301, "/services")
app.get "/tm-search*", (req, res) -> res.redirect(301, "/services")
app.get "/tm-brand*", (req, res) -> res.redirect(301, "/services")
app.get "/tm-monitoring*", (req, res) -> res.redirect(301, "/services")
app.get "/products.html", (req, res) -> res.redirect(301, "/services")
app.get "/cs-cosec.html", (req, res) -> res.redirect(301, "/services")
app.get "/bi-aml-solutions-int.html", (req, res) -> res.redirect(301, "/services")
app.get "/bi-credit-reports-int.html", (req, res) -> res.redirect(301, "/services")
app.get "/bi-company-documents-int.html", (req, res) -> res.redirect(301, "/services")
app.get "/document59.html", (req, res) -> res.redirect(301, "/services")
app.get "/armadillo-app.html", (req, res) -> res.redirect(301, "/services")
app.get "/arm1.htm", (req, res) -> res.redirect(301, "/services")
app.get "/tm-brand-audits.html", (req, res) -> res.redirect(301, "/services")
app.get "/rmlogin.htm", (req, res) -> res.redirect(301, "/services")
app.get "/bi-companies-house-documents-uk.html", (req, res) -> res.redirect(301, "/services")
app.get "/AMLogin.htm", (req, res) -> res.redirect(301, "/services")
app.get "/cs-foundations-dif.html", (req, res) -> res.redirect(301, "/services")
app.get "/cs-trusts.html", (req, res) -> res.redirect(301, "/services")
app.get "/cs-shipreg.html", (req, res) -> res.redirect(301, "/services")
app.get "/cs-foundations-adv.html", (req, res) -> res.redirect(301, "/services")
app.get "/cs-bankaccounts-int.html", (req, res) -> res.redirect(301, "/services")
app.get "/cs-bankaccounts-eu.html", (req, res) -> res.redirect(301, "/services")
app.get "/tm-registration-uk.html", (req, res) -> res.redirect(301, "/services")
app.get "/forms/contactus/lv/lv-form-lv.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/forms/contactus/ukraine/ua-form-ua.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/cs-foundations-lie.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/cs-foundations-aut.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/forms/contactus/md/md-form-ro.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/forms/contactus/pl/pl-form-pl.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/forms/contactus/ca/ca-form-en.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/forms/contactus/safr/safr-form-en.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/cs-int-formation.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/jurisdictions/bahamas.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/jurisdictions/jersey.html", (req, res) -> res.redirect(301, "/company-formations/international")
app.get "/jurisdictions/delaware.html", (req, res) -> res.redirect(301, "/company-formations/international/delaware")
app.get "/cs-foundations-pan.html", (req, res) -> res.redirect(301, "/company-formations/international/panama")
app.get "/jurisdictions/panama.html", (req, res) -> res.redirect(301, "/company-formations/international/panama")
app.get "/about-us.html", (req, res) -> res.redirect(301, "/about")
app.get "/cs-bankaccounts.html", (req, res) -> res.redirect(301, "/company-formations/UK/search")
app.get "/bi-company-database-image-bank-uk.html", (req, res) -> res.redirect(301, "/company-formations/UK/search")
app.get "/bi-company-credit-check-uk.html", (req, res) -> res.redirect(301, "/company-formations/UK/search")
app.get "/bi-company-reports-uk.html", (req, res) -> res.redirect(301, "/company-formations/UK/search")
app.get "/bi-money-laundering-protection-uk.html", (req, res) -> res.redirect(301, "/company-formations/UK/search")
app.get "/cs-bankaccounts-uk.html", (req, res) -> res.redirect(301, "/company-formations/UK/search")
app.get "/jurisdictions/cyprus.html", (req, res) -> res.redirect(301, "/company-formations/international/cyprus")
app.get "/jurisdictions/bvi.html", (req, res) -> res.redirect(301, "/company-formations/international/british-virgin-islands")
app.get "/jurisdictions/*", (req, res) -> res.redirect(301, "/company-formations/international")

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
      status: err.status
      message: err.message
      error: err

    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  # don't log 500/404 but otherwise..
  if !err.status
    console.error("!BANG! #{err.stack}")
  res.status err.status or 500
  res.render "error",
    status: err.status
    message: err.message
    error: {}

  return

module.exports = app
