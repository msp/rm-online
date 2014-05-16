var documentObjectArray = [];

$(document).ready(function(){


  $.ajax({
		async: false,
		type: "POST",
    url: "/servlet/com.armadillo.online?service=rmonline&function=ch_document_list&stylesheet=none&conumber=" + $("#company").val(),
    dataType: "xml",
    success: function(xml) {

			var i =0;
			documentObjectArray = [];

			$(xml).find('CABINET').each(function () {
			
				var id = $(this).attr('name');

				// $(".storeListContent").append("<li><h3>" + $(this).find("IMAGE").text() + "</h3><ul>");

				$(this).find("IMAGE").each(function (i, e) {
					var documentObject = new Object();
    			documentObject.id = i++;

					documentObject.grp = id;
					documentObject.document_id = $(e).find("DOCUMENT_ID").text();
					documentObject.encrypted_id = $(e).find("ENCRYPTED_ID").text();
					documentObject.type = $(e).find("DOCUMENT_TYPE").text();
					documentObject.date = $(e).find("DOCUMENT_DATE").text();
					documentObject.year = $(e).find("YEAR").text();
					documentObject.pages = $(e).find("PAGES").text();
					documentObject.description = $(e).find("DOC_DESCRIPTION").text();
					documentObject.barcode_ref = $(e).find("BARCODE_REF").text();
					documentObject.received_date = $(e).find("RECEIVED_DATE").text();
					documentObject.registered_date = $(e).find("REGISTERED_DATE").text();
					documentObject.selected = false;
					documentObject.group_order = getGroupOrder(id);

      		// Push it on to the array
      		documentObjectArray.push(documentObject);
				});
			});

			// Build the document list
  		displayTabbedDocumentArray();

			// Update the product cells
			var ptr = document.getElementById ("downloadStatus");
			ptr.style.display = "none";

			// Update the product cells
			var ptr = document.getElementById ("docTab");
			ptr.style.display = "block";
    }
  });
});

function checkImages(){

	var imageProductString = '';
	numberSelected = 0;
	for (var i=0; i<documentObjectArray.length; i++){
		if (documentObjectArray[i].selected){
			if (numberSelected > 0)	
				imageProductString += "|";
			imageProductString +=  documentObjectArray[i].document_id + ',' + documentObjectArray[i].encrypted_id + ',' + documentObjectArray[i].pages;
			numberSelected ++;
    }
	}
	if (numberSelected == 0)
	{
		alert ("You don't seem to have chosen any images"); 	
		return false;
	}
		
	sendForm();
	return true;	
}

// Build the string required to get the image
function getImageProductString(){

	var imageProductString = '';
  numberSelected = 0;
  for (var i=0; i<documentObjectArray.length; i++){
    if (documentObjectArray[i].selected){
      if (numberSelected > 0)
        imageProductString += "|";
      imageProductString +=  documentObjectArray[i].document_id + ',' + documentObjectArray[i].encrypted_id + ',' + documentObjectArray[i].pages;
      numberSelected ++;
    }
  }
	return imageProductString;
}

// Build the string to make billing
function getImageBillString(){

	var imageBillString = '';
  numberSelected = 0;
  for (var i=0; i<documentObjectArray.length; i++){
    if (documentObjectArray[i].selected){
      if (numberSelected > 0)
        imageBillString += "|";
      imageBillString +=  niceDate(documentObjectArray[i].registered_date) + '-' + documentObjectArray[i].type + '-' + documentObjectArray[i].document_id;
      numberSelected ++;
    }
  }
	return imageBillString;
}

// Build the string to make billing
function getImagesSelected(){

  numberSelected = 0;
  for (var i=0; i<documentObjectArray.length; i++){
    if (documentObjectArray[i].selected)
      numberSelected ++;
  }
	return numberSelected;
}

// Shortcut for adding form fields
function addHiddenFormField(fieldName, value){

	var myHiddenField = document.createElement("input");
  myHiddenField.setAttribute("type", "hidden");
  myHiddenField.setAttribute("name", fieldName);
  myHiddenField.setAttribute("value", value);
  return myHiddenField;
}	

// Send the form - we roll our own form
function sendForm(){

  var form = document.createElement("form");
  form.setAttribute("method", "post");
  form.setAttribute("action", "com.armadillo.online");

  // <input id="imageRequest"  name="imageRequest" value="REP,IMG,{identity},{type},{date}" type="hidden"/>

  var hiddenField = addHiddenFormField("service", $("#service").val());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("function", "login");
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("productList", getImageProductString());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("billList", getImageBillString());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("reptype", "LIM");
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("requestname", $("#companyName").val());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("company", $("#company").val());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("companyName", $("#companyName").val());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("clientRef", $("#clientRef").val());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("imageRequest", getImageProductString());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("imagesSelected", getImagesSelected());
  form.appendChild(hiddenField);

  var hiddenField = addHiddenFormField("reference", $("#company").val());
  form.appendChild(hiddenField);

  document.body.appendChild(form);
  form.submit();
  return true;
}	

// This is used to mark the array as selected  
function handleClick(cb) {
	setTimeout(function() {
		// alert("Clicked, new value = " + cb.value);
		// alert("Id = " + cb.id);
		// alert("selected = " + cb.checked);
		
		// Mark the array as selected
		for (var i=0; i<documentObjectArray.length; i++){
			if (documentObjectArray[i].document_id === cb.id){
				documentObjectArray[i].selected = cb.checked;
    	}
		}
	}, 0);
}


// Some sorting functions
function grpSort(a, b){
	var a1= a.grp, b1= b.grp;
  if(a1== b1) return 0;
    return a1> b1? 1: -1;
}

function groupOrderSort(a, b){
	var a1= a.group_order, b1= b.group_order;
  if(a1== b1) return 0;
    return a1 > b1? 1: -1;
}

function dateSort(a, b){
	var a1= a.registered_date, b1= b.registered_date;
	if(a1== b1) return 0;
	return a1< b1? 1: -1;
}

function idSort(a, b){
	var a1= a.id, b1= b.id;
	if(a1== b1) return 0;
	return a1> b1? 1: -1;
}

// Build the tabs
function displayTabbedDocumentArray(){

  // Sort dates in reverse, then sort into groups
  documentObjectArray.sort(dateSort);
  documentObjectArray.sort(groupOrderSort);

	var xtabs = $("#docTab").tabs();
	var ul = xtabs.find( "ul" );

	var tabHeader = "";
	var currentCount = 0;
  var currentGroup = 0;
  var headerGroup = 0;

	
	buttonString = "<tr><td><br/></td></tr><tr><td colspan=\"5\">"
								+ "<button id=\"imageSubmit\" type=\"submit\" onClick=\"return checkImages()\">Get Companies House Images</button></td></tr>";

  for (var i=0; i<documentObjectArray.length; i++){

    // New headers please
    if ((i == 0) || (documentObjectArray[i].grp != documentObjectArray[i - 1].grp)){
			var tabHeader = "<li><a href='#" + documentObjectArray[i].grp + "'>" + getShortGroupLabel(documentObjectArray[i].grp) + "</a></li>";
			// var tabHeader = "<li><a href='#" + documentObjectArray[i].grp + "'>" + documentObjectArray[i].grp + "</a></li>";
			$(tabHeader).appendTo( ul );

			headerGroup = documentObjectArray[i].grp;

			var sectionString = "<div id='" + headerGroup + "'><table width=\"90%\">"
											//	+ "<tr><td colspan=\"5\" class=\"rm_red_head\">" + getGroupLabel(documentObjectArray[i].grp) + "</td></tr>"
                    		+ "<tr><th align=\"left\" width=\"60px\" valign=\"top\">Select</th><th width=\"120px\" align=\"left\" valign=\"top\">Document<br/>Date</th><th width=\"120px\" align=\"left\" valign=\"top\">Date<br/>Registered </th><th align=\"left\" width=\"240px\" valign=\"top\">Details</th>"
                    		+ "<th align=\"left\" valign=\"top\">Pages</th></tr>";			

			for (x=i; x < documentObjectArray.length; x++)
			{
				if (documentObjectArray[x].grp == headerGroup){
					sectionString +=displayDocumentArrayLine(x) + "\n";
				}
				else break;
			}
			sectionString += buttonString + "</table></div>";		
			$(sectionString).appendTo( xtabs );
		}

  }
	xtabs.tabs( "refresh" );
	xtabs.tabs( "option", "active", 0 );

}

function getGroupOrder(group){

	if (group == 'acc'){
		return 1;
	}
	else if (group == '363'){
		return 2;
	}
	else if (group == 'newc'){
		return 3;
	}
	else if (group == 'con'){
		return 4;
	}
	else if (group == '287'){
		return 5;
	}
	else if (group == '288'){
		return 6;
	}
	else if (group == 'cap'){
		return 7;
	}
	else if (group == 'misc'){
		return 8;
	}
	else if (group == 'mort'){
		return 9;
	}
	else if (group == 'eire'){
		return 10;	
	}
	else if (group == 'liq'){
		return 11;
	}
}

function groupLabel(group){

	var label;
	var href_label;

	if (group == 'acc'){
		label = "Accounts documents";
		href_label = "accounts";
	}
	else if (group == 'cap'){
		label = "Capital details documents";
		href_label = "capital";
	}
	else if (group == 'con'){
		label = "Change of name documents";
		href_label = "con";
	}
	else if (group == 'newc'){
		label = "Incorporation documents";
		href_label = "new";
	}
	else if (group == 'liq'){
		label = "Liquidation documents";
		href_label = "liquid";
	}
	else if (group == 'misc'){
		label = "Miscellaneous documents";
		href_label = "miscellaneous";
	}
	else if (group == 'mort'){
		label = "Mortgage documents";
		href_label = "mortgage";
	}
	else if (group == '363'){
		label = "Annual Return documents";
		href_label = "return";
	}
	else if (group == '288'){
		label = "Changes of directors documents";
		href_label = "directors";
	}
	else if (group == '287'){
		label = "Changes of registered office documents";
		href_label = "registered";
	}
	else if (group == 'eire'){
		label = "Irish Republic documents";
		href_label = "eire";
	}

	return '' // "<a href=\"#" + href_label + "\">" 
		+ "<tr><td colspan=\"5\" class=\"rm_red_head\">- " + label + "</td></tr>"
		// + "<tr><td><h3>" + label + "</h3></td></tr>"
		+	"<tr><th align=\"left\" width=\"80px\">Select</th><th width=\"120px\" align=\"left\">Document Date</th><th align=\"left\">Registered</th><th align=\"left\">Details</th>"
		+ "<th align=\"right\">Pages</th></tr>";

}

function getGroupLabel(group){

	var label;
	if (group == 'acc'){
		return "Accounts documents";
	}
	else if (group == 'cap'){
		return "Capital details documents";
	}
	else if (group == 'con'){
		return "Change of name documents";
	}
	else if (group == 'newc'){
		return "New company documents";
	}
	else if (group == 'liq'){
		return "Liquidation documents";
	}
	else if (group == 'misc'){
		return "Miscellaneous documents";
	}
	else if (group == 'mort'){
		return "Mortgage documents";
	}
	else if (group == '363'){
		return "Annual Return documents";
	}
	else if (group == '288'){
		return "Changes of directors documents";
	}
	else if (group == '287'){
		return "Changes of registered office documents";
	}
	else if (group == 'eire'){
		return "Irish Republic documents";
	}
	else {
		return "Other Document";
	}
}

function getShortGroupLabel(group){

	var label;
	if (group == 'acc'){
		return "Accounts";
	}
	else if (group == 'cap'){
		return "Capital";
	}
	else if (group == 'con'){
		return "Name Change";
	}
	else if (group == 'newc'){
		return "Incorp";
	}
	else if (group == 'liq'){
		return "Liq";
	}
	else if (group == 'misc'){
		return "Misc";
	}
	else if (group == 'mort'){
		return "Mort";
	}
	else if (group == '363'){
		return "Returns";
	}
	else if (group == '288'){
		return "Directors";
	}
	else if (group == '287'){
		return "Office";
	}
	else if (group == 'eire'){
		return "Irish";
	}
	else {
		return "Other Documents ";
	}
}


// dates from yyyymmdd to dd/mm/yyyy
function niceDate(date){

	dateString = 'Not stated';
	if (date.length==8){
		dateString= date.substr(6,2) + '/' + date.substr(4,2) + '/' + date.substr(0,4); 
	}
	return dateString;
}

function displayDocumentArrayLine(lineNumber){

	return"<tr>" 
	+ "<td><input type=\"checkbox\" id=\"" + documentObjectArray[lineNumber].document_id + "\"" 
	+	" value=\"" + documentObjectArray[lineNumber].document_id + ',' + documentObjectArray[lineNumber].encrypted_id + ',' + documentObjectArray[lineNumber].pages + "\""  
	+ " onchange=\"handleClick(this);\"/>"
	+ "</td>" 
	+ "<td>" + niceDate(documentObjectArray[lineNumber].date)         + "</td>" 
	+ "<td>" + niceDate(documentObjectArray[lineNumber].registered_date)         + "</td>" 
	+ "<td>" + documentObjectArray[lineNumber].type         + " - " 
	+ documentObjectArray[lineNumber].description  + "</td>" 
	+ "<td>" + documentObjectArray[lineNumber].pages + "</td>" + "</tr>";

}

function showObj(o) {
	document.getElementById(o).style.display = ( o.style.display=='none' ) ? 'inline' : 'none';
}


