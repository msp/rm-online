
exports.stateList = function(selectedElementName){
    // https://gist.github.com/mshafrir/2646763
    var json = [{"name":"Alabama","data-alternative-spellings":"AL"},{"name":"Alaska","data-alternative-spellings":"AK"},{"name":"American Samoa","data-alternative-spellings":"AS"},{"name":"Arizona","data-alternative-spellings":"AZ"},{"name":"Arkansas","data-alternative-spellings":"AR"},{"name":"California","data-alternative-spellings":"CA"},{"name":"Colorado","data-alternative-spellings":"CO"},{"name":"Connecticut","data-alternative-spellings":"CT"},{"name":"Delaware","data-alternative-spellings":"DE"},{"name":"District Of Columbia","data-alternative-spellings":"DC"},{"name":"Federated States Of Micronesia","data-alternative-spellings":"FM"},{"name":"Florida","data-alternative-spellings":"FL"},{"name":"Georgia","data-alternative-spellings":"GA"},{"name":"Guam","data-alternative-spellings":"GU"},{"name":"Hawaii","data-alternative-spellings":"HI"},{"name":"Idaho","data-alternative-spellings":"ID"},{"name":"Illinois","data-alternative-spellings":"IL"},{"name":"Indiana","data-alternative-spellings":"IN"},{"name":"Iowa","data-alternative-spellings":"IA"},{"name":"Kansas","data-alternative-spellings":"KS"},{"name":"Kentucky","data-alternative-spellings":"KY"},{"name":"Louisiana","data-alternative-spellings":"LA"},{"name":"Maine","data-alternative-spellings":"ME"},{"name":"Marshall Islands","data-alternative-spellings":"MH"},{"name":"Maryland","data-alternative-spellings":"MD"},{"name":"Massachusetts","data-alternative-spellings":"MA"},{"name":"Michigan","data-alternative-spellings":"MI"},{"name":"Minnesota","data-alternative-spellings":"MN"},{"name":"Mississippi","data-alternative-spellings":"MS"},{"name":"Missouri","data-alternative-spellings":"MO"},{"name":"Montana","data-alternative-spellings":"MT"},{"name":"Nebraska","data-alternative-spellings":"NE"},{"name":"Nevada","data-alternative-spellings":"NV"},{"name":"New Hampshire","data-alternative-spellings":"NH"},{"name":"New Jersey","data-alternative-spellings":"NJ"},{"name":"New Mexico","data-alternative-spellings":"NM"},{"name":"New York","data-alternative-spellings":"NY"},{"name":"North Carolina","data-alternative-spellings":"NC"},{"name":"North Dakota","data-alternative-spellings":"ND"},{"name":"Northern Mariana Islands","data-alternative-spellings":"MP"},{"name":"Ohio","data-alternative-spellings":"OH"},{"name":"Oklahoma","data-alternative-spellings":"OK"},{"name":"Oregon","data-alternative-spellings":"OR"},{"name":"Palau","data-alternative-spellings":"PW"},{"name":"Pennsylvania","data-alternative-spellings":"PA"},{"name":"Puerto Rico","data-alternative-spellings":"PR"},{"name":"Rhode Island","data-alternative-spellings":"RI"},{"name":"South Carolina","data-alternative-spellings":"SC"},{"name":"South Dakota","data-alternative-spellings":"SD"},{"name":"Tennessee","data-alternative-spellings":"TN"},{"name":"Texas","data-alternative-spellings":"TX"},{"name":"Utah","data-alternative-spellings":"UT"},{"name":"Vermont","data-alternative-spellings":"VT"},{"name":"Virgin Islands","data-alternative-spellings":"VI"},{"name":"Virginia","data-alternative-spellings":"VA"},{"name":"Washington","data-alternative-spellings":"WA"},{"name":"West Virginia","data-alternative-spellings":"WV"},{"name":"Wisconsin","data-alternative-spellings":"WI"},{"name":"Wyoming","data-alternative-spellings":"WY"}]

    var html = "";

    // Provide a "Select Country" leader element, but only if there is no pre-selected item.
    // This is to prevent users who have previously selected a country from setting an empty country.

  // MSP
    if( !selectedElementName || selectedElementName.length < 1)
        html = '<option value="" selected="selected">Select State</option>\n';

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
