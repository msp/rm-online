exports.index = (req, res) ->
  console.log(req.body)
  console.log("total items: "+req.body.itemCount)
  checkoutItems = []

  for num in [1..req.body.itemCount]
    console.log(req.body["item_name_"+num] + " | " + req.body["item_price_"+num] + " | " + req.body["item_quantity_"+num])
    checkoutItems.push {name: req.body["item_name_"+num], price: req.body["item_price_"+num], quantity: req.body["item_quantity_"+num]}

  title = "Mock of Horus Checkout Process in an iFrame"
  req.breadcrumbs(title, 'mock checkout')
  res.render "mock-checkout",
    title: title
    bcList: req.breadcrumbs()
    checkoutItems: checkoutItems
    path: req.path
    verb: req.method
    excludeHeader: true
    excludeFooter: true
  return
