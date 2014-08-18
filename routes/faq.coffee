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

exports.index = (req, res) ->
  title = "Frequently Asked Questions"
  req.breadcrumbs(title, 'faq')
  res.render "pages/faq",
    title: title
    faq_sections: FAQ_SECTIONS
    bcList: req.breadcrumbs()
  return
