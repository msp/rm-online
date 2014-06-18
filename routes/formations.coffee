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

]

# Cook Islands	599	849	1,148	1,398
# Cyprus	1,750	2,000	2,700	2,950
# Delaware	299	549	550	799
# Dominica IBC	599	850	1,149	1,400
# Dubai	2,150	 	3,650
# Gibraltar	799	1,049	1,399	1,650
# Hong Kong	1,050	1,445	1,900	2,700
# Malta	2,175	2,425	3,175	3,425
# Marshall Islands	699	949	1,198	1,448
# Nevada	1,050	1,300	1,900	2,150
# New Zealand	1,900	 	3,100
# Panama	600	850	1,000	1,250
# Seychelles	340	600	550	850
# Wyoming (USA)	700	950	1,300	1,600


exports.international = (req, res) ->
  title = "International Company Formation"
  req.breadcrumbs(title, "/formations/international")
  res.render "formations/international",
    title: title
    bcList: req.breadcrumbs()
    countries: COUNTRIES
  return