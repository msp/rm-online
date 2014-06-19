COUNTRIES = [
  {
    name: "Belize"
    setup: 399
    withLegislation: 649
    twoYears: 748
    twoYearsWithLegislation: 998
  }
  {
    name: "British Anguilla"
    setup: 600
    withLegislation: 850
    twoYears: 1000
    twoYearsWithLegislation: 1250
  }
  {
    name: "British Samoa"
    setup: 550
    withLegislation: 800
    twoYears: 950
    twoYearsWithLegislation: 1200
  }
  {
    name: "British Virgin Islands"
    setup: 550
    withLegislation: 845
    twoYears: 950
    twoYearsWithLegislation: 1200
  }
  {
    name: "Cook Islands"
    setup: 599
    withLegislation: 849
    twoYears: 1148
    twoYearsWithLegislation: 1398
  }
  {
    name: "Cyprus"
    setup: 1750
    withLegislation: 2000
    twoYears: 2700
    twoYearsWithLegislation: 2950
  }
  {
    name: "Delaware"
    setup: 299
    withLegislation: 549
    twoYears: 550
    twoYearsWithLegislation: 799
  }
  {
    name: "Dominica IBC"
    setup: 599
    withLegislation: 850
    twoYears: 1149
    twoYearsWithLegislation: 1400
  }
  {
    name: "Dubai"
    setup: 2150
    withLegislation: "-"
    twoYears: 3650
    twoYearsWithLegislation: "-"
  }
  {
    name: "Gibraltar"
    setup: 799
    withLegislation: 1049
    twoYears: 1399
    twoYearsWithLegislation: 1650
  }
  {
    name: "Hong Kong"
    setup: 1050
    withLegislation: 1445
    twoYears: 1900
    twoYearsWithLegislation: 2700
  }
  {
    name: "Malta"
    setup: 2175
    withLegislation: 2425
    twoYears: 3175
    twoYearsWithLegislation: 3425
  }
  {
    name: "Marshall Islands"
    setup: 699
    withLegislation: 949
    twoYears: 1198
    twoYearsWithLegislation: 1448
  }
  {
    name: "Nevada"
    setup: 1050
    withLegislation: 1300
    twoYears: 1900
    twoYearsWithLegislation: 2150
  }
  {
    name: "New Zealand"
    setup: 1900
    withLegislation: "-"
    twoYears: 3100
    twoYearsWithLegislation: "-"
  }
  {
    name: "Panama"
    setup: 600
    withLegislation: 850
    twoYears: 1000
    twoYearsWithLegislation: 1250
  }
  {
    name: "Seychelles"
    setup: 340
    withLegislation: 600
    twoYears: 550
    twoYearsWithLegislation: 850
  }
  {
    name: "Wyoming (USA)"
    setup: 700
    withLegislation: 950
    twoYears: 1300
    twoYearsWithLegislation: 1600
  }
]

exports.international = (req, res) ->
  title = "International Company Formation"
  req.breadcrumbs(title, "/company-formations/international")
  res.render "formations/international",
  title: title
  bcList: req.breadcrumbs()
  countries: COUNTRIES
  return