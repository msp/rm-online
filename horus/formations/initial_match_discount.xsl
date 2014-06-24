<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gh="http://www.govtalk.gov.uk/schemas/govtalk/govtalkheader"
  xmlns:ns="http://xmlgw.companieshouse.gov.uk/v1-0/schema"
  xmlns:url="http://www.jclark.com/xt/java/java.net.URLEncoder">
<xsl:output method="html"/>
<xsl:include href="http://localhost/rmef/includes/rmefclientform2.xsl"/>
<xsl:include href="google.xsl"/>
<xsl:include href="incorporation_form.xsl"/>
<xsl:include href="sensitive_name.xsl"/>
<xsl:include href="check_existing_name.xsl"/>

<xsl:variable name="title">Incorporate A Company</xsl:variable>
<xsl:variable name="searchMatch">
	<xsl:value-of select="//ns:NameSearch/ns:CoSearchItem/ns:SearchMatch"/>
</xsl:variable>
<xsl:variable name="dataSet">
	<xsl:value-of select="//ns:NameSearch/ns:CoSearchItem/ns:DataSet"/>
</xsl:variable>
<xsl:variable name="companyName">
	<xsl:value-of select="//ns:NameSearch/ns:CoSearchItem/ns:CompanyName"/>
</xsl:variable>
<xsl:variable name="companyIndexStatus">
	<xsl:value-of select="//ns:NameSearch/ns:CoSearchItem/ns:CompanyIndexStatus"/>
</xsl:variable>

<xsl:template match="/">
 <xsl:call-template name="form">
  <xsl:with-param name="PARAM">REPORTS</xsl:with-param>
  <xsl:with-param name="TITLE"><xsl:value-of select="$title"/></xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template name="body">
 <xsl:comment>START OF BODY DISPLAY</xsl:comment>
 <xsl:variable name="SID"><xsl:value-of select="*/@session"/></xsl:variable>

 <script language="JavaScript">

 <xsl:call-template name="basic_form_script_functions"/>
  
  var conAddr1 = '<xsl:value-of select="/horus/row[defaulttype='contact']/addressline1"/>';
  var conAddr2 = '<xsl:value-of select="/horus/row[defaulttype='contact']/addressline2"/>';
  var conAddr3 = '<xsl:value-of select="/horus/row[defaulttype='contact']/addressline3"/>';
  var conTown = '<xsl:value-of select="/horus/row[defaulttype='contact']/posttown"/>';
  var conCounty = '<xsl:value-of select="/horus/row[defaulttype='contact']/county"/>';
  var conPostcode = '<xsl:value-of select="/horus/row[defaulttype='contact']/postcode"/>';
  var conCountry = '<xsl:value-of select="/horus/row[defaulttype='contact']/country"/>';
  var conName = '<xsl:value-of select="/horus/row[defaulttype='contact']/surname"/>';
  var conTelephone = '<xsl:value-of select="/horus/row[defaulttype='contact']/telephone"/>';
  var conDxnumber = '<xsl:value-of select="/horus/row[defaulttype='contact']/dxnumber"/>';
  var conDxexchange = '<xsl:value-of select="/horus/row[defaulttype='contact']/dxexchange"/>';
  
  var clientAddr1 = '';
  var clientAddr2 = '';
  var clientAddr3 = '';
  var clientTown = '';
  var clientCounty = '';
  var clientPostcode = '';
  var clientCountry = '';
  var clientName = '';
  var clientTelephone = '';
  var clientDxnumber = '';
  var clientDxexchange = '';

	var foreign = '';
  
  <xsl:comment><![CDATA[

	function checkLoginForm() {
		// Check email and password
    if (isFilled(document.login.email)==false) {
      alert("The email address cannot be blank\n" + "Please correct to continue");
      document.login.email.focus();
      return false;
    }
    if (isFilled(document.login.password)==false) {
      alert("The password cannot be blank\n" + "Please correct to continue");
      document.login.password.focus();
      return false;
    }
  }

  function checkSearchForm() {
		if (isFilled(document.einc.SearchData)==false) {
      alert("The company name cannot be blank\n" + "Please correct to continue");
      document.einc.SearchData.focus();
      return false;
    }
    // Check the name contains acceptable ltd/plc suffixesname
    if (checkSuffixNoType(document.einc.SearchData) == false) {
      document.einc.SearchData.focus();
      return false;
    }
    // Get the company type
    document.einc.compType.value = getCompType(document.einc.SearchData);
  }

  function checkContactForm() {

		// Set the taxcode
		document.einc.taxCode.value = getTaxCode(document.einc.clientCountry.value, document.einc.vatNumber);

		if (isFilled(document.einc.clientName)==false) {
	  	alert("The contact name cannot be blank\n" + "Please correct to continue");
	  	// document.einc.clientName.focus();
	  	return false;
		}
	
		if (isFilled(document.einc.clientAddr1)==false) {
	  	alert("First line of the address cannot be blank\n" + "Please correct to continue");
	  	document.einc.clientAddr1.focus();
	  	return false;
		}
	
		if (isFilled(document.einc.clientTown)==false) {
	  	alert("The town cannot be blank\n" + "Please correct to continue");
	  	document.einc.clientTown.focus();
	  	return false;
		}
		
		if (isFilled(document.einc.clientPostcode)==false) {
	  	alert("The postcode cannot be blank\n" + "Please correct to continue");
	  	document.einc.clientPostcode.focus();
	  	return false;
		}

		if (isFilled(document.einc.clientTelephone)==false) {
	  	alert("The contact telephone number cannot be blank\n" + "Please correct to continue");
	  	document.einc.clientTelephone.focus();
	  	return false;
		}
		
		if (isFilled(document.einc.clientEmail)==false) {
	  	alert("The contact email address cannot be blank\n" + "Please correct to continue");
	  	document.einc.clientEmail.focus();
	  	return false;
		}
	
		if (isEmailValid(document.einc.clientEmail)==false) {
	  	alert ("The contact email address appears to be invalid\n" + "Please correct to continue");
	  	document.einc.clientEmail.focus();
	  	return false;
		}
	
		if (document.einc.clientEmail.value!=document.einc.clientEmail2.value) {
	  	alert ("The contact email address's appears to be different\n" + "Please correct to continue");
	  	document.einc.clientEmail.focus();
	  	return false;
		}

		if (isFilled(document.einc.clientPassword)==false) {
	  	alert("The password cannot be blank\n" + "Please correct to continue");
	  	document.einc.clientPassword.focus();
	  	return false;
		}
	
		if (document.einc.clientPassword.value!=document.einc.clientPassword2.value) {
	  	alert ("The passwords appears to be different\n" + "Please correct to continue");
	  	document.einc.clientPassword.focus();
	  	return false;
		}
		if (isFilled(document.einc.discount))
      document.einc["function"].value = "eincfull_initial_discount_contact";
    else
      document.einc["function"].value = "eincfull_initial_add_contact";

	}

	function trim(stringToTrim) {
    return stringToTrim.replace(/^\s+|\s+$/g,"");
  }
  
  function doUpperCase (myValue) {
		document.einc.compName.value = trim(document.einc.compName.value.toUpperCase()); 
		document.einc.compNameCheck.value = trim(document.einc.compNameCheck.value.toUpperCase()); 
  }
  
  function doCountry (sel, val) {
    for (var i = 0; i < document.getElementById(sel).length; i++) {
      if (document.getElementById(sel).options[i].value == val)
        document.getElementById(sel).options[i].selected=true;
    }	
  }


	function showHide(objStr, show) {
  	obj = document.getElementById(objStr);
  	if (show) obj.style.display = '';
  	else obj.style.display = 'none';
  }

    
  //]]></xsl:comment>
 </script>

 <!-- No match. Ready to go -->
 <xsl:if test="$searchMatch	!= 'EXACT'">

 	<table cellspacing="0" align="center" cellpadding="0" width="98%" border="0">
		<tr>	
		<td>
			<p class="pagetext"><b>Congratulations! - <xsl:value-of select="/horus/row/searchdata"/></b> is Available.</p>  
			<xsl:call-template name="sensitive_name_check"><xsl:with-param name="COMPANY_NAME"><xsl:value-of select="/horus/row/searchdata"/></xsl:with-param></xsl:call-template>
			<p>If you need help please contact our helpdesk on 01462 427300.</p>
	
		</td>
		<td align="right">
	
		<!-- BEGIN ProvideSupport.com Graphics Chat Button Code -->
        <div id="ciArRy" style="z-index:100;position:absolute"></div>
        <div id="scArRy" style="display:inline"></div>
        <div id="sdArRy" style="display:none"></div>
        <script type="text/javascript">
         <xsl:comment><![CDATA[
          var seArRy=document.createElement("script");seArRy.type="text/javascript";var seArRys=(location.protocol.indexOf("https")==0?"https":"http")+"://image.providesupport.com/js/0xwrlulm7zomo09eb4gq0vx0dj/safe-standard.js?ps_h=ArRy&ps_t="+new Date().getTime();setTimeout("seArRy.src=seArRys;document.getElementById('sdArRy').appendChild(seArRy)",1)
          //]]></xsl:comment>

        </script>
        <noscript>
          <div style="display:inline"><a href="http://www.providesupport.com?messenger=0xwrlulm7zomo09eb4gq0vx0dj">Online Chat</a></div>
        </noscript>
      <!-- END ProvideSupport.com Graphics Chat Button Code -->
	


		</td>
		</tr>
		</table>
	</xsl:if>
	
 <!-- Dissolved so pass but with message -->
 <xsl:if test="$searchMatch	= 'EXACT' and $companyIndexStatus = 'DISSOLVED'">

 	<table cellspacing="0" align="center" cellpadding="0" width="98%" border="0">
		<tr>	
		<td>
			<p><b>Congratulations!</b> - <xsl:value-of select="/horus/row/searchdata"/> is available.</p>  
			<p>(note that Companies House shows that a company has previously registered with that name but that company has dissolved) <a href="javascript:doCoSearch('{//ns:NameSearch/ns:CoSearchItem/ns:CompanyName}')"> Click here</a> for full details </p>  
			<p>To complete your company incorporate please enter the details below.</p>
			<xsl:call-template name="sensitive_name_check">
				<xsl:with-param name="COMPANY_NAME">
					<xsl:value-of select="/horus/row/searchdata"/>
				</xsl:with-param>
				<xsl:with-param name="REGISTERED">TRUE</xsl:with-param>
			</xsl:call-template>
			<p>If you need help please contact our helpdesk on 01462 427300.</p>
	
		</td>
		<td align="right">
	
		<!-- BEGIN ProvideSupport.com Graphics Chat Button Code -->
        <div id="ciArRy" style="z-index:100;position:absolute"></div>
        <div id="scArRy" style="display:inline"></div>
        <div id="sdArRy" style="display:none"></div>
        <script type="text/javascript">
         <xsl:comment><![CDATA[
          var seArRy=document.createElement("script");seArRy.type="text/javascript";var seArRys=(location.protocol.indexOf("https")==0?"https":"http")+"://image.providesupport.com/js/0xwrlulm7zomo09eb4gq0vx0dj/safe-standard.js?ps_h=ArRy&ps_t="+new Date().getTime();setTimeout("seArRy.src=seArRys;document.getElementById('sdArRy').appendChild(seArRy)",1)
          //]]></xsl:comment>

        </script>
        <noscript>
          <div style="display:inline"><a href="http://www.providesupport.com?messenger=0xwrlulm7zomo09eb4gq0vx0dj">Online Chat</a></div>
        </noscript>
      <!-- END ProvideSupport.com Graphics Chat Button Code -->

		</td>
		</tr>
		</table>
	</xsl:if>

 <!-- Existing match found so redo the form -->
 <xsl:if test="$searchMatch	= 'EXACT' and $companyIndexStatus != 'DISSOLVED'">

 	<table cellspacing="0" align="center" cellpadding="0" width="98%" border="0">
		<tr>	
		<td>
			
			<xsl:call-template name="check_existing_name">
				<xsl:with-param name="COMPANY_NAME"><xsl:value-of select="$companyName"/></xsl:with-param>
				<xsl:with-param name="SEARCH_DATA_NAME"><xsl:value-of select="/horus/row/searchdata"/></xsl:with-param>
			</xsl:call-template>
			
			<p>If you need help please contact our helpdesk on 01462 427300.</p>
	
		</td>
		<td align="right">
		<!-- BEGIN ProvideSupport.com Graphics Chat Button Code -->
        <div id="ciArRy" style="z-index:100;position:absolute"></div>
        <div id="scArRy" style="display:inline"></div>
        <div id="sdArRy" style="display:none"></div>
        <script type="text/javascript">
         <xsl:comment><![CDATA[
          var seArRy=document.createElement("script");seArRy.type="text/javascript";var seArRys=(location.protocol.indexOf("https")==0?"https":"http")+"://image.providesupport.com/js/0xwrlulm7zomo09eb4gq0vx0dj/safe-standard.js?ps_h=ArRy&ps_t="+new Date().getTime();setTimeout("seArRy.src=seArRys;document.getElementById('sdArRy').appendChild(seArRy)",1)
          //]]></xsl:comment>

        </script>
        <noscript>
          <div style="display:inline"><a href="http://www.providesupport.com?messenger=0xwrlulm7zomo09eb4gq0vx0dj">Online Chat</a></div>
        </noscript>
      <!-- END ProvideSupport.com Graphics Chat Button Code -->
	
		</td>
		</tr>
		</table>
		<table cellspacing="0" align="center" cellpadding="0" width="98%" border="0">
		<form name="einc" method="post" action="/servlet/com.armadillo.online" onSubmit="return checkSearchForm()">
    <input type="hidden" name="service" value="einc"/>
    <input type="hidden" name="function" value="cosearch_ch"/>
    <input type="hidden" name="Request" value="NameAvailableSearch"/>
    <input type="hidden" name="SearchRows" value="20"/>
    <input type="hidden" name="agent" value="rm001"/>
    <input type="hidden" name="stylesheet" value="initial_match_discount.xsl"/>
    <input type="hidden" name="previousSearch" value="{//ns:NameSearch/ns:CoSearchItem/ns:CompanyName}"/>
	  <input type="hidden" name="compType" value="{/horus/row/comptype}"/>

	 <tr><td><br/></td></tr>
   <tr>
    <td colspan="2" class="subhead">Check Company Names At Companies House</td>
   </tr>
   <tr><td><br/></td></tr>
	  <tr>
   <td colspan="2">
    <p class="page-text">Enter your Company (remember to add the word '<b>limited</b>' or '<b>plc</b>')</p>
    </td>
   </tr>	
	 <tr><td><br/></td></tr>
   <tr>
   <td class="texthead">Company Name</td>
   <td>
      <input class="eincInput" name="SearchData" id="SearchData" type="text" size="40"/>
      <xsl:text> </xsl:text> <input class="eincButton" type="submit" value="Search"/>&#xA0;
  </td>
  </tr>

  </form>

		</table>
	</xsl:if>

 <!-- MAIN PART OF THE FORM -->	
 <xsl:if test="($searchMatch != 'EXACT') or ($searchMatch	= 'EXACT' and $companyIndexStatus = 'DISSOLVED')">


 <table cellspacing="0" align="center" cellpadding="0" width="98%" border="0">
  <form name="login" method="post" action="/servlet/com.armadillo.online" onSubmit="return checkLoginForm()">
   <input type="hidden" name="service" value="einc"/>
   <input type="hidden" name="function" value="login_with_company"/>
	 <input type="hidden" name="compType" value="{/horus/row/comptype}"/>
	 <input type="hidden" name="SearchData" value="{/horus/row/searchdata}"/>
   <input type="hidden" name="previousSearch" value="{//ns:NameSearch/ns:CoSearchItem/ns:CompanyName}"/>
	 <input name="agentId" type="hidden" value="rm001"/>

		<script language="JavaScript">
			// Get the company type
			document.login.compType.value = getCompType(document.login.SearchData);
		</script>


   <tr>
    <td colspan="2" class="subhead">Existing clients - please log on to incorporate <xsl:value-of select="/horus/row/searchdata"/></td>
   </tr>
   <tr><td><br/></td></tr>
	<tr>
	 <td class="texthead">Email *</td>
	 <td><input class="eincInput" name="email" id="email" type="text" size="40" style="text-transform:lowercase;"/></td>
  </tr>
	<tr>
	 <td class="texthead">Password *<br/></td>
	 <td><input class="eincInput" name="password" id="password" type="password" size="15"/></td>
  </tr>
   <tr>
    <td/>
    <td>
	 <input class="eincButton" type="submit" value="Login"/>&#xA0; 
		<a class="link1" href="/servlet/com.armadillo.online?service=einc&amp;function=&amp;stylesheet=forgot.xsl">(forgot password?)</a>
	</td>
   </tr>
	 
	</form>
		
	
  <form name="einc" method="post" action="/servlet/com.armadillo.online" onSubmit="return checkContactForm()">
   <input type="hidden" name="service" value="einc"/>
   <input type="hidden" name="function" value="eincfull_initial_discount_contact"/>
	 <input type="hidden" name="compType" value="{/horus/row/comptype}"/>
	 <input type="hidden" name="compName" value="{/horus/row/searchdata}"/>
	 <input type="hidden" name="SearchData" value="{/horus/row/searchdata}"/>
   <input type="hidden" name="previousSearch" value="{//ns:NameSearch/ns:CoSearchItem/ns:CompanyName}"/>
	 <input name="agentId" type="hidden" value="rm001"/>
	 <input name="taxCode" type="hidden" value="T1"/>
 
		<script language="JavaScript">
			// Get the company type
			document.einc.compType.value = getCompType(document.login.SearchData);
		</script>

   <xsl:for-each select="/horus/row[defaulttype='declarant']">
    <input name="decPerscode" type="hidden" value="{persauthcode}"/>
		<input name="decSurname" type="hidden" value="{decsurname}"/>
		<input name="decForename" type="hidden" value="{decforename}"/>
		<input name="decCorporate" type="hidden" value="1"/>
		<input name="decCompany" type="hidden" value="{surname}"/>
		<input name="decDesignation" type="hidden" value="1"/>
		<input name="decAddr1" type="hidden" value="{addressline1}"/>
		<input name="decAddr2" type="hidden" value="{addressline2}"/>
		<input name="decAddr3" type="hidden" value="{addressline3}"/>
		<input name="decTown" type="hidden" value="{posttown}"/>
		<input name="decPostcode" type="hidden" value="{postcode}"/>
		<input name="decCounty" type="hidden" value="{county}"/>
		<input name="decCountry" type="hidden" value="{county}"/>
   </xsl:for-each>

   <xsl:for-each select="/horus/row[defaulttype='agent']">
		<input name="ageSurname" type="hidden" value="{surname}"/>
		<input name="ageForename" type="hidden" value="{forename}"/>
		<input name="ageAddr1" type="hidden" value="{addressline1}"/>
		<input name="ageAddr2" type="hidden" value="{addressline2}"/>
		<input name="ageAddr3" type="hidden" value="{addressline3}"/>
		<input name="ageTown" type="hidden" value="{posttown}"/>
		<input name="agePostcode" type="hidden" value="{postcode}"/>
		<input name="ageCounty" type="hidden" value="{county}"/>
		<input name="ageCountry" type="hidden" value="{country}"/>
   </xsl:for-each>
 
	 <!-- CH Contact details -->
   <xsl:for-each select="/horus/row[defaulttype='contact']">
    <input name="conName" id="conName" type="hidden" value="{surname}"/>
    <input name="conAddr1" id="conAddr1" type="hidden" value="{addressline1}"/>
		<input name="conAddr2" id="conAddr2" type="hidden" value="{addressline2}"/>
    <input name="conAddr3" id="conAddr3" type="hidden" value="{addressline3}"/>
		<input name="conTown" id="conTown" type="hidden" value="{posttown}"/>
		<input name="conCounty" id="conCounty" type="hidden" value="{county}"/>
		<input name="conPostcode" id="conPostcode" type="hidden" value="{postcode}" style="text-transform:uppercase;"/>
		<input name="conEmail" id="conEmail" type="hidden" value="rmcs@rmonline.com"/>
		<input name="conEmail2" id="conEmail2" type="hidden" value="rmcs@rmonline.com"/>
		<input name="conTelephone" id="conTelephone" type="hidden" value="{telephone}"/>
		<input name="conDxnumber" id="conDxnumber" type="hidden" value="{dxnumber}"/>
		<input name="conDxexchange" id="conDxexchange" type="hidden" value="{dxexchange}"/>
	 </xsl:for-each>    
   <tr><td><br/></td></tr>
   <tr>
    <td colspan="2" class="subhead">New clients - please register to complete your incorporation of <xsl:value-of select="/horus/row/searchdata"/></td>
   </tr>
   <tr><td><br/></td></tr>
	<tr>
	 <td class="texthead">Your Name *</td>
	 <td><input class="eincInput" name="clientName" id="clientName" type="text" size="40"/></td>
  </tr>
	<tr>
	 <td class="texthead">Contact Company<br/></td>
	 <td><input class="eincInput" name="clientCompany" id="clientCompany" type="text" size="40"/></td>
  </tr>
   <tr><td><br/></td></tr>
	 
	<tr>
	 <td class="texthead">Address *</td>
	 <td><input class="eincInput" name="clientAddr1" id="clientAddr1" type="text" size="40"/></td>
    </tr>
	<tr>
	 <td></td>
	 <td><input class="eincInput" name="clientAddr2" id="clientAddr2" type="text" size="40"/></td>
    </tr>
	<tr>
	 <td></td>
	 <td><input class="eincInput" name="clientAddr3" id="clientAddr3" type="text" size="40"/></td>
    </tr>
	<tr>
	 <td class="texthead">Town *</td>
	 <td><input class="eincInput" name="clientTown" id="clientTown" type="text" size="40"/></td>
    </tr>
	<tr>
	 <td class="texthead">County</td>
	 <td><input class="eincInput" name="clientCounty" id="clientCounty" type="text" size="40"/></td>
    </tr>
	<tr>
	 <td class="texthead">Postcode *</td>
	 <td><input class="eincInput" name="clientPostcode" id="clientPostcode" type="text" size="10" style="text-transform:uppercase;"/></td>
    </tr>
	<tr>
	 <td class="texthead">Country *</td>
	 <td>
	  <xsl:call-template name="country">
       <xsl:with-param name="NAME">clientCountry</xsl:with-param>
       <xsl:with-param name="COUNTRY"><xsl:value-of select="country"/></xsl:with-param>
	   	 <xsl:with-param name="DISABLED">no</xsl:with-param>
	   	 <xsl:with-param name="ONCHANGE">return foreignContact()</xsl:with-param>
      </xsl:call-template>
	 </td>
    </tr>
		<tr id="row_vat_number" style="display:none">
      <td class="texthead">VAT Number (Optional)</td>
	 		<td><input class="eincInput" name="vatNumber" id="vatNumber" type="text" size="14"/></td>
    </tr>
	
   <tr><td><br/></td></tr>
	<tr>
	 <td class="texthead">Telephone *</td>
	 <td><input class="eincInput" name="clientTelephone" id="clientTelephone" type="text" size="20"/></td>
    </tr>
	<tr>
	 <td class="texthead">Email Address *</td>
	 <td><input class="eincInput" name="clientEmail" id="clientEmail" type="text" size="40" style="text-transform:lowercase;"/>
		</td>
    </tr>
	<tr>
	 <td class="texthead">Retype Email Address *</td>
	 <td><input class="eincInput" name="clientEmail2" id="clientEmail2" type="text" size="40" value="" style="text-transform:lowercase;"/></td>
    </tr>
   <tr><td><br/></td></tr>
	<tr>
	 <td class="texthead">Choose a Password *</td>
	 <td><input class="eincInput" name="clientPassword" id="clientPassword" type="password" size="15"/></td>
    </tr>
	<tr>
	 <td class="texthead">Retype your Password *</td>
	 <td><input class="eincInput" name="clientPassword2" id="clientPassword2" type="password" size="15"/></td>
    </tr>
   <tr><td><br/></td></tr>
	<tr>
	 <td class="texthead">Discount/Promotion Code</td>
	 <td><input class="eincInput" name="discount" id="discount" type="text" size="15"/></td>
    </tr>
   <tr><td><br/></td></tr>
	<tr>
	 <td class="texthead">How did you hear of us?</td>
	 <td>
			<select name="lead" onChange="doCheckOtherLead()">
				<option value=""></option>
				<option value="Search engine">Search engine</option>
				<option value="Word of mouth">Word of mouth</option>
				<option value="Email advertising">Email advertising</option>
				<option value="RM Sales person">RM Sales person</option>
				<option value="Exhibition or Trade show">Exhibition or Trade show</option>
				<option value="Other">Other</option>
			</select> 
	 </td>
   </tr>
		 <tr id="row_other_lead" style="display:none">
      <td class="texthead">Please explain how you <br/>heard of us</td>
      <td><input class="eincInput" name="otherLead" id="otherLead" type="text" size="40" maxlength="50"/></td>
    </tr>

   <tr><td><br/></td></tr>

   <tr>
    <td/>
    <td>
	 <input class="eincButton" type="submit" value="Next"/>
	</td>
   </tr>
  </form>
 </table>
	
	</xsl:if>

  <br/>
  <xsl:comment>END OF BODY DISPLAY</xsl:comment>
	<xsl:call-template name="google"/>

	
</xsl:template>
</xsl:stylesheet>
			  
