exports.reasonCodeList = function(selectedElementName){

  var json = [{"data-alternative-spellings":"1","name":"Credit Decision"},
            {"data-alternative-spellings":"2","name":"Credit Check - Intended Business Connection"},
            {"data-alternative-spellings":"3","name":"Credit Check - Ongoing Business Connection"},
            {"data-alternative-spellings":"4","name":"Debt Collection"},
            {"data-alternative-spellings":"5","name":"Commercial Credit Insurance"},
            {"data-alternative-spellings":"6","name":"Insurance Contract"},
            {"data-alternative-spellings":"7","name":"Leasing Agreement"},
            {"data-alternative-spellings":"8","name":"Rental Agreement"}]

    var html = "";

    // Provide a "Select Country" leader element, but only if there is no pre-selected item.
    // This is to prevent users who have previously selected a country from setting an empty country.

    // MSP
    if( !selectedElementName || selectedElementName.length < 1)
        html = '<option value="" selected="selected">type a reason</option>\n';

    json.forEach(function(element, index, array){

    // MSP
    // var str =  '<option value="' + element.name+'"';
        var str =  '<option value="' + element["data-alternative-spellings"].split(" ")[0]+'"';
        if( element.name == selectedElementName )
            str += " selected ";

        var helper=function(field){
            if( typeof element[field] != "string" ) return("");
            if( element[field].length == 0 ) return("");
            return(" "+field+'="'+element[field]+'" ');
        }

        str += helper("data-alternative-spellings");
        str += helper("data-relevancy-booster");

        str += ">"+element.name+"</option>\n";

        html += str;
    })

    return(html);

}
