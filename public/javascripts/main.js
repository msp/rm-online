$(document).ready(function() {
  $(".faq-section li").collapse({
      open: function() {
        this.slideDown(100);
      },
      close: function() {
        this.slideUp(100);
      }
    });


  $('.horus-formations-post').click(function(){
    $('#company-available').slideUp();
    $('.company-unavailable').slideUp();
    $("html, body").animate({ scrollTop: 0 }, "slow");
    $('#horus-iframe').show();
  })

  $('#responsiveTabs').responsiveTabs({
    startCollapsed: 'accordion'
  });

  $('#docResponsiveTabs').responsiveTabs({
    startCollapsed: 'accordion'
  });

  function redrawButtons() {
    // reset all
    $(".item_add").text("ADD TO CART");
    // update those in basket
    simpleCart.each(function(item){
      var htmlId = "#"+item.get("rmid");
      $(htmlId).text("("+item.get("quantity")+") IN CART");
    })
  }

  simpleCart({
    checkout: {
      type: "SendForm"
      ,url: "/mock-checkout"}
    ,cartStyle: "table"
    ,currency: "GBP"
    ,cartColumns: [
        { attr: "name" , label: "Name" } ,
        { attr: "price" , label: "Price", view: 'currency' } ,
        { view: "decrement" , label: false , text: "-" } ,
        { attr: "quantity" , label: "Qty" } ,
        { view: "increment" , label: false , text: "+" } ,
        { attr: "total" , label: "Total", view: 'currency' } ,
        { view: "remove" , label: false }
      ]
  });

  simpleCart.bind( 'load' , function(){
    redrawButtons();
  });

  simpleCart.bind( 'beforeCheckout' , function( data ){
    $('#checkout-intro').toggle("slow");
  });

  simpleCart.bind( 'update' , function(){
    redrawButtons();
  });
});
