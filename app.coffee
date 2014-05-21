express = require("express")
breadcrumbs = require('express-breadcrumbs')
path = require("path")
favicon = require("static-favicon")
logger = require("morgan")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
routes = require("./routes/index")
users = require("./routes/users")
app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# breadcrumbs
app.use(breadcrumbs.init())
app.use(breadcrumbs.setHome("Home"))

app.use favicon()
app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()

app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))
app.use "/", routes

TERMS = [
  "You shall use the Reports only for your own personal usage. You shall not provide the Reports to any other person."
  "From time to time we may amend the format and content of the Reports and any of the Report Information."
  "You will pay us our charges, by a payment method we accept, before we send you any Reports."
  "You acknowledge that we may refuse to accept any order you make for a Report at our discretion.  In such circumstances, we shall reimburse you for any charges paid by you in relation to such refused order."
  "Most of the Report Information is provided to RM Online Limited by others and as such RM Online Limited does not control the Report Information's accuracy or completeness.  The volume and nature of the information on RM Online Limited's databases makes it impractical for RM Online Limited to check it.  Because of this, RM Online Limited will only be liable to you for any loss or damage caused by its negligence or willful default and RM Online Limited shall not in any other circumstances be liable for any inaccuracies, faults, or omissions in the Report or the Report Information."
  "You must not rely upon any Report or Report Information as the only factor or source of information in making any decision.  Further advice and information from appropriate experts and professionals should be obtained before making any decision."
  "RM Online Limited shall not in any circumstances (whether for breach of contract, negligence or any other tort, under statute or otherwise at all) be liable for any indirect or consequential loss or damage at all, or any loss of business, capital, profit, reputation or goodwill."
  "Nothing in these terms shall limit or exclude RM Online Limited's liability for its fraud or for death or personal injury arising from negligence."
  "RM Online Limited's entire liability in respect of all causes of action arising by reason of or in connection with these terms (whether for breach of contract, negligence or any other tort, under statute or otherwise at all) shall be limited to the amount you paid RM Online Limited for the Report (excluding VAT)."
  "If you want to make a claim against RM Online Limited in relation to the Report or the Report Information, you must give RM Online Limited written notice of the claim within 3 months of becoming aware of the circumstances giving rise to the claim or, if earlier, 3 months from the time you ought reasonably to have become aware of such circumstances.  If you do not, RM Online Limited shall not be liable for the claim."
  "You shall indemnify RM Online Limited against the claims or legal proceedings, brought or threatened against RM Online Limited by a third party, or loss or damage suffered by RM Online Limited, which in either case is caused by your use of the Reports and/or Report Information or caused by your negligent acts or omissions for non-compliance with these terms."
  "The agreement between you and RM Online Limited under which RM Online Limited provides the Reports to you shall be governed by the laws of England and Wales.  You and RM Online Limited shall submit to the exclusive jurisdiction of the courts of England and Wales."
]

FAQ_SECTIONS = [
  {
    title: "General"
    faqs: [
      {
        q: "Tell me more about RM"
        a: "RM is the brand name used by the Raymond Morris Group Limited who were founded in 1974. The RM Group specialises in providing Company Information and Company Registration services. Our commitment to high standards of quality and technological development continues to bring benefits to all our clients."
      }
      {
        q: "How many companies are covered by the service?"
        a: "The service provides comprehensive reports on all U.K. registered Companies and over 200 Million companies worldwide."
      }
      {
        q: "How are the reports prepared?"
        a: "We take company information from major official sources on a daily basis, credit limits in reports are prepared by experienced credit analysts."
      }
      {
        q: "What can I use the service for?"
        a: "You can use the service to credit check new and existing customers, find out about your competitors and generally find out all you need to know about a company, its owners/managers and its financial standing."
      }
      {
        q: "What type of credit card can I use?"
        a: "All major credit cards are accepted."
      }
      {
        q: "What's the helpdesk number?"
        a: "+44 (0) 207 729 1234"
      }
      {
        q: "Can I pay using another method? "
        a: "If you do not have, or do not wish to use your card, you can have your report emailed or posted back to you and you can pay be cheque."
      }
      {
        q: "Will I get a receipt? "
        a: "Your receipt is emailed at the end of your transaction."
      }
      {
        q: "When will the money be taken from my account?"
        a: "The payment is taken immediately from your card."
      }
      {
        q: "Do I have to register to use the service?"
        a: "Yes, you have to register to use the service for the first time. After that you will be issued with a client code and a password of your choice which you can then use to access the service. Your credit card details will not be saved. Registered clients will have to input their credit card details each time an order is placed."
      }
    ]
  }
  {

    title: "Company Formation"
    faqs: [
      {
        q: "International and UK formations are simple and easy"
        a: "For UK, just search the name of the company that you require to ensure it has not already been registered. After you find the company name, select the level of formation pack you require, pay and you will be registered in minutes.
            <br/><br/>For International formations around the world, select the country you require and contact our team of experienced lawyers who will liaise with you by telephone or mail. They will respond and advise immediately"
      }
    ]
  }
  {
    title: "Company Information"
    faqs: [
      {
        q: "What Information is contained in a Comprehensive UK and international report?"
        a: "The information content varies depending on the jurisdiction concerned, disclosure requirements and size of company.  Financial information is not always available.  We normally try to provide the following, but no guarantee is given that this informaiton will be present.
                                                          <br/><br/> Ownership and Management
                                                          <br/> Names of directors, shareholders or proprietors
                                                          <br/> Capital structure and shareholdings
                                                          <br/> Names and job titles of senior company personnel
                                                          <br/> Legal Status and History
                                                          <br/> Date of  incorporation
                                                          <br/> Legal status, Company number and trading style
                                                          <br/> Registered address
                                                          <br/> Associated companies
                                                          <br/> Historical information, change of ownership
                                                          <br/> Operations
                                                          <br/> Full details of business activities
                                                          <br/> Equipment employed
                                                          <br/> Description of premises
                                                          <br/> Number of employees
                                                          <br/> Financial Information
                                                          <br/> Extracts from or full balance sheets (if available) obtained from official registries or directly from the company
                                                          <br/> Registered mortgages and charges
                                                          <br/> Bankers
                                                          <br/> Credit Appraisal and Conclusion
                                                          <br/> an opinion based on the payment experience of trade suppliers, banks, known public record details of any court action and protested bills."
      }
    ]
  }
]
  
app.get "/news", (req, res) ->
  title = "Industry News"
  req.breadcrumbs(title, 'news')

  res.render "pages/news",
    title: title
    bcList: req.breadcrumbs()
  return

app.get "/about", (req, res) ->
  title = "About"
  req.breadcrumbs(title, 'about')
  res.render "pages/about",
    title: title
    bcList: req.breadcrumbs()
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

app.get "/faq", (req, res) ->
  title = "Frequently Asked Questions"
  req.breadcrumbs(title, 'faq')
  res.render "pages/faq",
    title: title
    faq_sections: FAQ_SECTIONS
    bcList: req.breadcrumbs()
  return

app.get "/terms", (req, res) ->
  title = "Terms and Conditions"
  req.breadcrumbs(title, 'terms')
  res.render "pages/terms",
    title: title
    terms: TERMS
    bcList: req.breadcrumbs()
  return

app.use "/users", users

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