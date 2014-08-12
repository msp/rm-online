ADMIN_SECTIONS = [
  {
    title: "Registered Office"
    intro: "All Limited Company's (LTD) / Limited Liability Partnership Company (LLP) registered in the UK are required by law to have a \"Registered Office\" address in the UK. This address is kept on the Companies House database and is available for anybody to inspect free of charge. It must also be written on all company correspondence such as letterheads and invoices. RM can provide a full registered office address service."
    bullets: []
  }
  {
    title: "Nominee secretary"
    intro: "Under the 2006 Companies Act it is no longer a legal requirement to have a company secretary unless the company's articles of association require it. RM provides a full nominee secretarial service. RM recommends that clients always appoint a company secretary as:"
    bullets: [
      "They can easily be checked by 3rd parties"
      "They can sign documents on the company’s behalf without supplying authorisation proof"
      "Notaries can easily legalise by Apostille the appointment form by downloading it directly from Companies House"
      "No need to supply the written resolution for authorised signatory, each time"
    ]
  }
  {
    title: "Nominee directors/shareholders"
    intro: "The Companies Act 2006 requires a private company to have at least one director, although the company’s articles of association may impose a higher minimum requirement for the number of directors. At least one director must be an individual. UK Company law requires that information on directors/shareholders must be registered on the public files at Companies House. RM can provide nominee directors or shareholders that can shield and protect this information to keep it confidential."
    bullets: []
  }
  {
    title: "Filing annual returns"
    intro: "All UK Ltd/LLP companies must submit an annual return form to Companies House each year. This provides a snapshot of general information about the company, including details of key personnel, the registered office, share capital and shareholdings. As part of RM company administration service we can assist and file on your behalf."
    bullets: []
  }
  {
    title: "Accounts"
    intro: "It is a legal requirement for accounts to be filed every financial year for UK LTD/LLP companies. First accounts for a company, must be filed within 21 months of the date of incorporation. Every subsequent filing of accounts must be done within 9 months from the accounting reference date (ARD). RM can assist with preparation and filing of these accounts; however they need to be signed by the director/member."
    bullets: []
  }
  {
    title: "Tax Returns"
    intro: "It is a legal requirement for UK LTD/LLP Companies to file an annual tax return at the UK HM Revenue & Customs (HMRC), even if it is not trading and pay the due taxes. RM can provide assistance and advice in the process of filing these tax returns."
    bullets: []
  }
  {
    title: "VAT registrations"
    intro: "Companies whose total sales exceed £70,000 in 12 month period must register for VAT as failure to do so could result in fines. VAT is added on to everything sold (with a few exceptions) and every 3 months a VAT return needs to be completed, signed by the director/member and filed at the VAT office. If the company buys from another VAT registered business, this VAT can be claimed back. RM can assist with the process of registering for VAT and the completion of the 1/3 VAT returns."
    bullets: []
  }
  {
    title: "Mail forwarding"
    intro: "Many UK companies use a mail forwarding service for a number of different reasons including: operating the business from home or based outside of the UK and need a UK presence or the business may be moving locations."
    bullets: []
  }
  {
    title: "Telephone answering"
    intro: "RM can provide a dedicated telephone line for any UK LTD/LLP company and answer all calls in the company name. All telephone messages will be taken and sent to the company by email."
    bullets: []
  }
]


exports.index = (req, res) ->
  title = "Company Admin Services"
  req.breadcrumbs(title, 'company-admin')
  res.render "pages/company-admin",
    title: title
    admin_sections: ADMIN_SECTIONS
    bcList: req.breadcrumbs()
  return
