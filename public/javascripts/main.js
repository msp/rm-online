$(document).ready(function() {
  $(".faq-section li").collapse({
      open: function() {
        this.slideDown(100);
      },
      close: function() {
        this.slideUp(100);
      }
    });

  $('#responsiveTabs').responsiveTabs({
    startCollapsed: 'accordion'
  });

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

  simpleCart.bind( 'beforeCheckout' , function( data ){
    $('#checkout-intro').toggle("slow");
  });



});
