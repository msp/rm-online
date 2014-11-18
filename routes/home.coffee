exports.index = (req, res) ->

  title = "Register Company with world no1 company formation firm RM"
  h1 = "Register Company-Fast Company Formation"
  heading= "Welcome to RM"
  intro = "RM Information Professionals - For over 40 years, the first choice for UK and International company formation, company set-up and registration, business information, company data, documents and services. Whether informing your business, or forming a new business, we offer 1-click solutions allowing you to register company names, brand trademarks, find company data and documents, incorporate articles of association for a limited company and register company information for new firms. We are the only professional services firm to consolidate Companies House data from 220 countries with access to the commercial databases, branded solutions and scores from Dun&Bradstreet, Experian, Equifax, Jordans, EBR European Business Registry, RM and Mossack Fonseca. Use our comprehensive company data and accounts to gain the business intelligence required to manage risk; conduct anti-money laundering (AML), know your customer (KYC) and other regulatory compliance audits and carry out credit or fraud checks - all offered with unlimited free company search and discounts for frequent customers."
  meta =  "COMPANY FORMATION AGENTS, REGISTRATION, REPORTS AND CREDIT CHECKS FOR ANY UK OR OFFSHORE COMPANY"
  outro = "RM Information Professionals - The first choice for UK and International company formation, business information, company data, documents and services. Whether informing your business, or forming a new business, we offer a 1 click company services solution. Search for and research companies data and accounts, available instantly online, and covering company data comprehensively - we are the only professional services firm to consolidate company by country data with the commercial databases, branded solutions and scores from Dun & Bradstreet, Experian, Equifax, EBR, RM and Mossack Fonseca. Credit check your customers, order company documents and detailed business and credit reports online instantly. Anti money laundering information & documents online & in hard copy. Incorporate and register your company & file trademarks for your brand. Free search functions allow you to access over 200 million company reports from 220 countries."
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
  partners = ["D&B partner organisation", "Experian partner organisation", "Equifax partner organisation", "Companies House partner organisation", "Mossack Fonseca partner organisation", "Jordans partner organisation"]

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
