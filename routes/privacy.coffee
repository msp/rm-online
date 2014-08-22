PRIVACY_SECTIONS = [
  {
    title: "The information which we collect."
    intro: [
      "You may browse our web site without disclosing personal data. However, if you register, and / or order products from us by completing our online forms or contact us by e-mail, we will collect the following personal information from you so that we can fulfil your order and contact you in case there is a query with your order:"
    ]
    list: [
       "Your name"
      ,"Postal address"
      ,"Organisation/Company  name"
      ,"Email address"
      ,"Phone number"
      ,"Fax number"
      ,"Your debit or credit card number"
      ,"Expiry date and other relevant information to allow us to collect payment"
    ]
  }
  {
    title: "How we use your personal information."
    intro: [
      "In addition to providing our services and products to you as set out above, we will also use your information for credit control purposes & market research purposes."
      ,"We may also use this information to notify you about our services and products, legal developments & training sessions or events which we believe may be of interest to you."
      ,"If you do not wish to receive such information, please write to:
         <br/><br/>The RM Group Ltd
         <br/>Invision House
         <br/>Wilbury Way
         <br/>Hitchin
         <br/>Herts
         <br/>SG4 0TW"
    ]
    list: []
  }
  {
    title: "How we share your personal information."
    intro: [
      "We may share your personal information with other companies in our group."
      ,"In order to provide services to you we may be required to pass your personal information to parties located outside of the European Economic Area in countries which do not have data protection laws equivalent to those in the UK. Where this is the case we will take reasonable steps to ensure the privacy of your information."
      ,"Except in the situations listed above or as required by law or other regulation, we will not pass, disclose, rent or sell your personal information (other than any personal information which is already publicly available and which is incorporated into our search products) to any third party without your prior written consent."
    ]
    list: []
  }
  {
    title: "Protecting your information."
    intro: [
      "When you order from us we use a secure server. All personal and credit card information is encrypted using Secure Sockets Layer (SSL) technology before it is sent to us over the internet."
      ,"We have a Data Protection Policy and strict internal procedures designed to protect your personal information from unauthorised access, alteration, improper use, unintended destruction or other loss. If we change this policy we will post changes on this page so that you are aware of them. By continuing to use this website after such changes have been posted you will be deemed to have accepted and consented to them, whether you revisit this page or not."
    ]
    list: []
  }
  {
    title: "Cookies"
    intro: [
      "Cookies are small files which some websites transfer onto the hard drive of your computer. Cookies store information so that you are recognised the next time that you visit the site or to process your order. You can set your web browser to prevent it from automatically accepting cookies or to notify you before a cookie is accepted."
      ,"This site uses cookies only for the duration of your session to store information relevant to any order you may place with us."
      ,"Please note: If you have disabled cookies you may need to adjust the privacy settings on your internet browser to use this site. Generally, website operators must obtain your consent to use cookies. However, one of the categories of cookies that we use are those which are ‘strictly necessary’ to enable us to provide you with any service which you have requested from us that is to be delivered online. We do not need to ask for your consent to use these cookies, as we would not be able to provide the service you had asked for without them."
      ,"The other category of cookie that we use is Google Analytics which sets cookies to help us accurately estimate the number of visitors to our website and volumes of usage. This information helps us to improve our services and website. The data stored by these cookies can only be seen by Google’s and our relevant teams and never shows any confidential information."
    ]
    list: []
  }
  {
    title: "Accessing personal data"
    intro: [
      "You have the right, by a written formal request and on payment of a small fee, to have a copy of any personal data (as defined in the Data Protection Act 1998) which we hold about you."
    ]
    list: []
  }

]


exports.index = (req, res) ->
  title = "Privacy & Cookies"
  req.breadcrumbs(title, 'privacy-and-cookies')
  res.render "pages/privacy-and-cookies",
    title: title
    privacySections: PRIVACY_SECTIONS
    bcList: req.breadcrumbs()
  return
