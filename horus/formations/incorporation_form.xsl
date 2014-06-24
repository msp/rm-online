<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template name="checkPersCode">
 <xsl:comment><![CDATA[
		function checkPersCode(code, value){

			re = /^[A-Za-z]+$/;

               
			// <option value="01">First 3 letters of the town in which born</option>
			// <option value="03">Last 3 digits of telephone number</option>
			// <option value="05">Last 3 characters of National Insurance number</option>
			// <option value="06">Last 3 digits of Passport Number</option>
			// <option value="07">First 3 letters of mother's maiden name</option>
			// <option value="08">First 3 letters of eye colour</option>
			// <option value="09">First 3 letters of father's first forename</option>
			// <option value="00">Companies House Code</option>
                
			// Check for strings
			if (code == '01' || code == '07' || code == '08' || code == '09'){
				if (isNaN(value) && re.test(value))
					return true;
				else {
					errorString = "You selected ";
					if (code == '01')
						errorString +=  "'First 3 letters of the town in which born'";
					if (code == '07') 
						errorString +=  "'First 3 letters of mother's maiden name'";
					if (code == '08')
						errorString +=  "'First 3 letters of the eye colour'" ;
					if (code == "09")
						errorString +=  "'First 3 letters of your father's first forename'";    
	
					errorString += " as Personal Authentication, but you seem to have entered a number"; 
					alert(errorString);
					return false;
				}
			}
			// Check for numbers
			else if (code == '03'){
				if (!isNaN(value) && !re.test(value))
					return true;
				else
					errorString = "You selected ";
		
				if (code == '03')
					errorString +=  "'Last 3 digits of telephone number'";
		
				errorString += " as Personal Authentication, but you seem to have entered letters"; 
				alert(errorString);
				return false;
			}
			else
				return true;
		}

 //]]></xsl:comment>
</xsl:template>


<xsl:template name="basic_form_script_functions">
 <xsl:comment><![CDATA[
 function doCompanyType() {
   /*********************************************************
	<option value="0001">Private Limited Company (LTD)</option>
	<option value="0002">Public Limited Company (PLC)</option>
	**********************************************************/

   if (document.einc.compType.value == 1) {
     // Its a Plc
	 	document.einc.memType.value="0002";
	 	document.einc.artType.value="0005";
	 	// document.einc.artSel.disabled=true;
	 	// document.einc.authCapital.value = 50000;
	 	// document.einc.numberShares.value = 50000;
   }
   else if (document.einc.compType.value == 2) {
     // Its a limited company
	 	document.einc.memType.value="0001";
	 	document.einc.artType.value="0001";
	 	// document.einc.artSel.disabled=false;
	 	// document.einc.authCapital.value  = 1000;
	 	// document.einc.numberShares.value = 1000;
   }
	 companyNameProc(document.einc.compName);
 }

 function checkCompanyType() {
   /*********************************************************
	<option value="0001">Private Limited Company (LTD)</option>
	<option value="0002">Public Limited Company (PLC)</option>
	**********************************************************/
   if (document.einc.compType.value == 1) {
     // Its a Plc
	 document.einc.memType.value="0002";
	 document.einc.artType.value="0005";
	 document.einc.artSel.disabled="true";
	 document.einc.artSel[2].selected=true;
   }
 }

 function doArtType() {
   if (document.einc.artSel.value == "") {
     alert("Can't choose a blank option");
	 document.einc.artSel[0].selected = "true";
	 document.einc.artSel[0].value = "0001";
	 document.einc.artType.value = "0001";
	 document.einc.artSel.focus();
	 return false;
   }
   document.einc.artType.value=document.einc.artSel.value; 
 }

 function doArtType() {
   if (document.einc.artSel.value == "") {
     alert("Can't choose a blank option");
	 document.einc.artSel[0].selected = "true";
	 document.einc.artSel[0].value = "0001";
	 document.einc.artType.value = "0001";
	 document.einc.artSel.focus();
	 return false;
   }
   document.einc.artType.value=document.einc.artSel.value; 
 }

 function getNextDirectorSheet() {
	if (document.einc.foreign_nominee.value == ""){ 
   	document.einc.stylesheet.value="appoint_natural_add.xsl";
	}
	else{
   	document.einc.stylesheet.value="";
	}
 }		

 function isEUCountry(myCountry){
	EUCountries=/^(Austria|Belgium|Bulgaria|Cyprus|Czech Republic|Denmark|Estonia|Finland|France|Germany|Greece|Hungary|Ireland|Italy|Latvia|Lithuania|Luxembourg|Malta|Netherlands|Poland|Portugal|Romania|Slovakia|Slovenia|Spain|Sweden)$/;

	if (myCountry.search(EUCountries)!=-1) 
		return true;
	return false;
 }	

 function getTaxCode(myCountry, vatNo){
	if (myCountry == "United Kingdom" || myCountry == "")
      return "T1";
  else{
			// EU with code is t4 - no code is t1
      if (isEUCountry(myCountry)){
        if (isFilled(vatNo)==false)
          return "T1";
        else
          return "T4";
      }
      else
        return "T2";
    }
 }

 function isFilled(checkField) {
   // if (checkField.value == "" || checkField.value == null || checkField.value == 0) 
   if (checkField.value == "" || checkField.value == null) 
     return false;
   else return true;
 }
 
 function isEmailValid(elemName) {
   var temp   = elemName;
   var atSym  = temp.value.indexOf('@');
   var period = temp.value.lastIndexOf('.');
   var space  = temp.value.indexOf(' ');
   var len    = temp.value.length - 1;

   if ((atSym < 1) || (period <= atSym+1) || (period == len ) || (space  != -1)) {  
     return false;  
   }
   return true;
 }
	
 function doCoSearch (pName) {
   if (pName=="") {
     alert ("You must enter a company name before pressing 'company lookup'.");
     return;
   }
	
	 // remove limited or plc from the search
	 var noLtdString = pName.replace(/ LIMITED/i, "");
	 var noPlcString = noLtdString.replace(/ PLC/i, "");

   url = "/servlet/com.armadillo.online?service=einc&function=cosearch&coname=" + noPlcString;
  
   window.open (url, "", "resizable=yes,scrollbars=yes,dependent=yes,width=600,height=300,left=200,screenX=200,top=150,screenY=150");
 }

 function checkSuffix(myValue){
	// Trim out spaces
  var lowerValue = myValue.value.replace(" ", "");
  var trimValue = lowerValue.toUpperCase();
  var trimLength=lowerValue.length;

	if ((document.einc.compType.value == 2) && (trimValue.indexOf("LIMITED",trimLength-7 ) < 0)
		&& (trimValue.indexOf("LTD",trimLength-3 ) < 0)
    && (trimValue.indexOf("LTD.",trimLength-4 ) < 0)
	){
  	alert ("As you have selected a 'Limited' company type, your company name must end with the word 'LIMITED'");
		return false;
	}
  if ((document.einc.compType.value == 1) && (trimValue.indexOf("PLC",trimLength-3) < 0 )){
    alert ("As you have selected a 'Public Limited' company type, your company name must end with the word 'PLC'");
		return false;
	}
	return true;
 }		

 function checkSuffixNoType(myValue){
	// Trim out spaces
  var lowerValue = myValue.value.replace(" ", "");
  var trimValue = lowerValue.toUpperCase();
  var trimLength=lowerValue.length;

	if ((trimValue.indexOf("LIMITED",trimLength-7 ) < 0) 
	 && (trimValue.indexOf("LTD",trimLength-3 ) < 0) 
	 && (trimValue.indexOf("LTD.",trimLength-4 ) < 0) 
  	 && (trimValue.indexOf("PLC",trimLength-3)  < 0 ) 
	 && (trimValue.indexOf("LLP",trimLength-3) < 0 )){
    alert ("Your company name must end with the word 'LIMITED', 'LTD', 'LTD.', 'PLC' or 'LLP'");
		return false;
	}
	return true;
 }		

 function getCompType(myValue){
  // Trim out spaces
	coType=0;
  var lowerValue = myValue.value.replace(" ", "");
  var trimValue = lowerValue.toUpperCase();
  var trimLength=lowerValue.length;


  	if (trimValue.indexOf("LIMITED",trimLength-7 ) > 0) 
		coType=2;
	if (trimValue.indexOf("LTD",trimLength-3 ) > 0)
    	coType=2;
  	if (trimValue.indexOf("LTD.",trimLength-4 ) > 0)
    	coType=2;
	if (trimValue.indexOf("PLC",trimLength-3) > 0 )
    	coType=1;
	if (trimValue.indexOf("LLP",trimLength-3) > 0 )
    	coType=3;
	return coType;
 }	

 function companyNameProc(myValue) {
	
  // Trim out spaces
  var lowerValue = myValue.value.replace(" ", "");
  var trimValue = lowerValue.toUpperCase();
  var trimLength=lowerValue.length;

	doUpperCase(myValue);
	checkSuffix(myValue);

  }

	function companyNameProc2(myValue) {

	  // Trim out spaces
  	var lowerValue = myValue.value.replace(" ", "");
  	var trimValue = lowerValue.toUpperCase();
  	var trimLength=lowerValue.length;

    doUpperCase(myValue);

  	if ((document.einc.compType.value == 1) && (trimValue.indexOf("PLC",trimLength-3) < 0 )){
    	alert ("As you have selected a 'public limited' Company Type, your company name needs to end with the word 'PLC'");

    	return false;
   	}
  }

  function doUpperCase (myValue) {
    document.einc.compName.value = trim(document.einc.compName.value.toUpperCase());
  }	

 //]]></xsl:comment>
</xsl:template>

<xsl:template name="basic_form">
 <xsl:comment>START OF BASIC FORM</xsl:comment>
 <xsl:variable name="SID"><xsl:value-of select="*/@session"/></xsl:variable>
  
 <input type="hidden" name="session" value="{$SID}"/>
 <input type="hidden" name="memType" value="0001"/>
 <input type="hidden" name="artType" value="0001"/>
		
 <tr><td><br/></td></tr>
 <tr>
  <td colspan="2" class="subhead">Basic Data</td>
 </tr>
 <tr>
  <td colspan="2" align="center" class="texthead">
   <xsl:if test="boolean(/horus/row/showchange)">
    <h4><span class="link1">Company <xsl:value-of select="/horus/row/showchange"/> 
	has been submitted for incorporation</span></h4>
   </xsl:if>
  </td>
 </tr>
 <tr>
  <td class="texthead">Company Name</td>
  <td><input name="compName" type="text" size="50"/></td>
 </tr>
 <tr>
  <td/>
  <td>
   <input class="eincInput" type="button" value="lookup company" onClick="if (compName.value!='') doCoSearch(compName); else alert('No company name entered.')" title="Enter a full or partial business name to bring up a list of matches"/>
  </td>
 </tr>
 <tr>
  <td class="texthead">Re-enter Company Name</td>
  <td><input name="compNameCheck" type="text" size="50"/></td>
 </tr>
 <tr><td><br/></td></tr>
 <tr>
  <td class="texthead">Company Type</td>
  <td>
   <select class="eincInput" name="compType" size="1" onChange="doCompanyType()">
	<option value="2">Private company limited by shares (LTD)</option>
	<option value="1">Public limited company (PLC)</option>
	<!--
	<option value="3">Private company limited by guarantee without share capital</option>
	<option value="4">Private company limited by shares exempt under section 30</option>
	<option value="5">Private company limited by guarantee exempt under section 30</option>
	<option value="6">Private unlimited company with share capital</option>
	<option value="7">Private unlimited company without share capital</option>
	-->
   </select>
  </td>
 </tr>
 <tr><td><br/></td></tr>
 <!--
 <tr>
  <td class="texthead">Memorandum</td>
  <td>
   <select class="eincInput" name="memType" size="1">
	<option value="0001">Private Limited Company (LTD)</option>
	<option value="0002">Public Limited Company (PLC)</option>
   </select>
  </td>
 </tr>
 -->
 <tr>
  <td class="texthead">Articles</td>
  <td>
   <select class="eincInput" name="artSel" size="1" onChange="doArtType()">
	<option value="0001">Private Limited Company (LTD)</option>
	<option value="0002">Single Member Company</option>
	<option value=""></option>
	<!--
	<option value="0005">Public Limited Company (PLC)</option>
    <option value="0003">Private Limited Company with Pre-exemption Clause</option>
	<option value="0004">Single Member Company with Pre-exemption Clause</option>
	<option value="0006">Public Limited Company with Pre-exemption Clause</option>
	-->
   </select>
  </td>
 </tr>
 <tr><td><br/></td></tr>
 <xsl:for-each select="/horus/row[defaulttype='capital']">
  <!-- May be included later 
  <tr>
   <td class="texthead">Total Shares Taken</td>
   <td><input name="totalShares" type="text" size="10" value="{totalshares}"/></td>
  </tr>
  <tr>
   <td class="texthead">Share Class</td>
   <td><input name="shareClass" type="text" size="10" value="{shareclass}"/></td>
  </tr>
  <tr>
   <td class="texthead">Share Currency</td>
   <td><input name="shareCurrency" type="text" size="10" value="{sharecurrency}"/></td>
  </tr>
  -->
  <tr>
   <td class="texthead">Authorised Capital</td>
   <td>
    <input name="authCapital" type="text" size="10" value="{authcapital}"/>
	&#xA0;
	<input name="authCapital2" type="text" size="10" value="{authcapital}"/>
	&#xA0;
	<span class="texthead">Confirmation</span>
   </td>
  </tr>
  <tr>
   <td class="texthead">No. of Shares</td>
   <td>
	<input name="numberShares" type="text" size="10" value="{numbershares}"/>
	&#xA0;
	<input name="numberShares2" type="text" size="10" value="{numbershares}"/>
	&#xA0;
	<span class="texthead">Confirmation</span>
   </td>
  </tr>
  <tr>
   <td class="texthead">Value per Share</td>
   <td>
	<input name="shareValue" type="text" size="10" value="{sharevalue}"/>
	&#xA0;
	<input name="shareValue2" type="text" size="10" value="{sharevalue}"/>
	&#xA0;
	<span class="texthead">Confirmation</span>
   </td>
  </tr>
 </xsl:for-each>
 <tr><td><br/></td></tr>
 <tr>
  <td class="texthead">Delivery</td>
  <td>
   <select class="eincInput" name="formid">
	<option value="EINC">Normal delivery</option>
	<option value="SDEINC">Same day delivery</option>
   </select>
  </td>
 </tr>
</xsl:template>

<xsl:template name="basic_form_rejection">
 <tr><td><br/></td></tr>
 <tr>
  <td class="texthead">Companies House Rejection Reference</td>
  <td><input name="rejectRef" type="text" size="8"/></td>
 </tr>
</xsl:template>

<xsl:template name="registered_office">
 <tr>
  <td colspan="2" class="subhead">Registered Office</td>
 </tr>
 <xsl:for-each select="/horus/row[defaulttype='regoffice']">
  <tr>
   <td class="texthead">Address</td>
   <td><input name="regAddr1" type="text" size="40" value="{addressline1}"/></td>
  </tr>
  <tr>
   <td></td>
   <td><input name="regAddr2" type="text" size="40" value="{addressline2}"/></td>
  </tr>
  <tr>
   <td></td>
   <td><input name="regAddr3" type="text" size="40" value="{addressline3}"/></td>
  </tr>
  <tr>
   <td class="texthead">Town</td>
   <td><input name="regTown" type="text" size="40" value="{posttown}"/></td>
  </tr>
  <tr>
   <td class="texthead">Postcode</td>
   <td><input name="regPostcode" type="text" size="10" value="{postcode}"/></td>
  </tr>
  <tr>
   <td class="texthead">County</td>
   <td><input name="regCounty" type="text" size="40" value="{county}"/></td>
  </tr>
  <tr>
   <td class="texthead">Country</td>
   <td>
    <xsl:call-template name="country">
     <xsl:with-param name="NAME">regCountry</xsl:with-param>
     <xsl:with-param name="COUNTRY"><xsl:value-of select="country"/></xsl:with-param>
	 <xsl:with-param name="DISABLED">yes</xsl:with-param>
    </xsl:call-template>
   </td>
  </tr>
 </xsl:for-each>
</xsl:template>

<xsl:template name="eincfull_top">
 <xsl:param name="EXCLUDE"/>
 
 <script language="JavaScript">
  <xsl:comment><![CDATA[
  function doPDF(docno) {
    document.einc_top.action = "/servlet/com.armadillo.efiling_2010.eincPDF";
    document.einc_top.docno.value=docno;
    document.einc_top.submit ();
  }
	function doPDF_LLP(docno) {
		document.einc.action = "/servlet/com.armadillo.efiling_2010.eincPDF_LLP";
    document.einc.docno.value=docno;
    document.einc.fopstylesheet.value="eincPDF_LLP.xsl";
		document.einc.submit();
  }

  
  //]]></xsl:comment>
 </script>
 
 <form name="einc_top" method="post" action="eincPDF">
  <input type="hidden" name="service" value="einc"/>
  <input type="hidden" name="docno" value="{/horus/row/docno}"/>
  <input type="hidden" name="fopstylesheet" value="eincPDF.xsl"/>
 </form>
 
 <table cellspacing="0" align="center" cellpadding="2" width="98%" border="0">
  <tr>
   <td width="80%" class="topborder" style="border-left:0;border-right:0">
    <span class="tophead">
	 <xsl:value-of select="/horus/row/docno"/>
	 <xsl:text> - </xsl:text>
	 <xsl:value-of select="/horus/row/compname"/>
	</span>
   </td>
   <td align="right" class="topborder" style="border-left:0;border-right:0">
    <xsl:if test="$EXCLUDE!='EDIT' and $EXCLUDE!='ALL'"> 
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=eincfull_edit&amp;docno={/horus/row/docno}" title="Edit this Incorporation">
	 <img border="0" src="/rmef/images/edit.gif"/>
    </a>
	<xsl:text> </xsl:text>
	</xsl:if>
	<xsl:if test="$EXCLUDE!='PEOPLE' and $EXCLUDE!='ALL'">
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=appoint&amp;docno={/horus/row/docno}" title="Officers &amp; Shareholders">
	 <img border="0" src="/rmef/images/people.gif"/>
    </a>
	<xsl:text> </xsl:text>
	</xsl:if>
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=eincfull_delete&amp;docno={/horus/row/docno}" onclick="return confirm('Are you sure you want to delete this incorporation?')" title="Delete this Incorporation">
	 <img border="0" src="/rmef/images/delete.gif"/>
    </a>
	<xsl:text> </xsl:text>
	<a href="javascript:doPDF({/horus/row/docno})" title="View the PDF">
	 <img border="0" src="/rmef/images/pdf.gif"/>
    </a>
	<xsl:text> </xsl:text>
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=workflow" title="Workflow">
	 <img border="0" src="/rmef/images/pdf.gif"/>
    </a>
   </td>
  </tr>
  <tr>
   <td colspan="2" class="toptext">
    <img border="0" src="/rmef/images/address.gif" alt="Registered Office"/><xsl:text> </xsl:text>
	<xsl:value-of select="/horus/row/reg_addressline1"/>,
    <xsl:if test="/horus/row/reg_addressline2">
     <xsl:value-of select="/horus/row/reg_addressline2"/>,
    </xsl:if>
	<xsl:if test="/horus/row/reg_addressline3">
     <xsl:value-of select="/horus/row/reg_addressline3"/>,
    </xsl:if>
    <xsl:if test="/horus/row/reg_posttown">
     <xsl:value-of select="/horus/row/reg_posttown"/>,
    </xsl:if>
    <xsl:if test="/horus/row/reg_county">
     <xsl:value-of select="/horus/row/reg_county"/>,
    </xsl:if>
    <xsl:value-of select="/horus/row/reg_postcode"/>,
	<xsl:value-of select="/horus/row/reg_country"/>
   </td>
  </tr>
  <tr>
   <td colspan="2" class="toptext">
    <img border="0" src="/rmef/images/contact.gif" alt="Contact"/><xsl:text> </xsl:text>
	<xsl:value-of select="/horus/row/con_name"/>
   </td>
  </tr>
  <tr>
   <td colspan="2" class="topborder" style="border-left:0;border-right:0">
    <span class="toptext">
     <img border="0" src="/rmef/images/telephone.gif" alt="Contact Telphone Number"/><xsl:text> </xsl:text>
	 <xsl:value-of select="/horus/row/con_telephone"/>&#160;&#160;
	 <img border="0" src="/rmef/images/email.gif" alt="Contact Email Address"/><xsl:text> </xsl:text>
	 <a class="toplink" href="mailto:{/horus/row/con_email}"><xsl:value-of select="/horus/row/con_email"/></a>
	</span>
   </td>
  </tr>
 </table>
</xsl:template>

<xsl:template name="eincfull_top_condensed">
 <xsl:param name="EXCLUDE"/>
 <xsl:param name="SUPPORT_TEXT"/>
 
 <script language="JavaScript">
  <xsl:comment><![CDATA[
  function doPDF(docno) {
    document.einc_top.action = "/servlet/com.armadillo.efiling_2010.eincPDF_2";
    document.einc_top.docno.value=docno;
    document.einc_top.submit();
  }
	function doPDF_LLP(docno) {
		document.einc.action = "/servlet/com.armadillo.efiling_2010.eincPDF_LLP";
    document.einc.docno.value=docno;
    document.einc.fopstylesheet.value="eincPDF_LLP.xsl";
		document.einc.submit();
  }
  
  //]]></xsl:comment>
 </script>
 
 <form name="einc_top" method="post" action="eincPDF">
  <input type="hidden" name="service" value="einc"/>
  <input type="hidden" name="docno" value="{/horus/row/docno}"/>
  <input type="hidden" name="fopstylesheet" value="eincPDF.xsl"/>
 </form>
 
 <table cellspacing="0" align="center" cellpadding="2" width="98%" border="0">
  <tr>
   <td width="75%" class="topborder" style="border-left:0;border-right:0">
    <span class="tophead">
	 		<xsl:value-of select="/horus/row/docno"/>
	 		<xsl:if test="boolean(/horus/row/docno)">
	 			<xsl:text> - </xsl:text>
			</xsl:if>
	 			<xsl:text>&#160;</xsl:text>
	 		<xsl:value-of select="/horus/row/compname"/>
	 		<xsl:text> </xsl:text>
	</span>
   </td>
   <td align="right" class="topborder" style="border-left:0;border-right:0">
    <xsl:if test="$EXCLUDE!='EDIT' and $EXCLUDE!='ALL'"> 
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=eincfull_edit&amp;docno={/horus/row/docno}&amp;account={/horus/row/account}" title="Edit this Incorporation">
	 <img border="0" src="/rmef/images/edit.gif"/>
    </a>
	<xsl:text> </xsl:text>
	</xsl:if>
	<xsl:if test="$EXCLUDE!='PEOPLE' and $EXCLUDE!='ALL'">
	<xsl:choose>
		<xsl:when test="/horus/row/comptype = '1' or /horus/row/comptype = '2'">
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=appoint&amp;docno={/horus/row/docno}" title="Officers &amp; Shareholders">
	 <img border="0" src="/rmef/images/people.gif"/>
    </a>
		</xsl:when>
		<xsl:when test="/horus/row/comptype = '3'">
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=member&amp;docno={/horus/row/docno}" title="Officers &amp; Shareholders">
	 <img border="0" src="/rmef/images/people.gif"/>
    </a>
		</xsl:when>
		<xsl:otherwise>
	 <img border="0" src="/rmef/images/cross.gif"/>
		</xsl:otherwise>
	 </xsl:choose>
	<xsl:text> </xsl:text>
	</xsl:if>
	<xsl:if test="$EXCLUDE!='ALL'">
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=eincfull_delete&amp;docno={/horus/row/docno}" onclick="return confirm('Are you sure you want to delete this Incorporation?')" title="Delete this Incorporation">
	 <img border="0" src="/rmef/images/delete.gif"/>
    </a>
	<!--
	<xsl:text> </xsl:text>
	<xsl:choose>
		<xsl:when test="/horus/row/comptype = '1' or /horus/row/comptype = '2'">
			<a href="javascript:doPDF({/horus/row/docno})" title="View the PDF file">
	 		<img border="0" src="/rmef/images/pdf.gif"/>
    	</a>
		</xsl:when>
		<xsl:when test="/horus/row/comptype = '3'">
			<a href="javascript:doPDF_LLP({/horus/row/docno})" title="View the PDF file">
	 			<img border="0" src="/rmef/images/pdf.gif"/>
    	</a>
		</xsl:when>
  </xsl:choose>
	-->
	<xsl:text> </xsl:text>
	</xsl:if>
	<a href="/servlet/com.armadillo.online?service=einc&amp;function=workflow" title="Workflow Home"><img border="0" src="/rmef/images/address.gif" alt="Workflow Home"/></a>
	<xsl:text> </xsl:text>


			<!-- BEGIN ProvideSupport.com Custom Images Chat Button Code -->
      <div id="ciFXQ2" style="z-index:100;position:absolute"></div><div id="scFXQ2" style="display:inline"></div><div id="sdFXQ2" style="display:none"></div>
      <script type="text/javascript">
        <xsl:comment><![CDATA[        
					var seFXQ2=document.createElement("script");seFXQ2.type="text/javascript";var seFXQ2s=(location.protocol.indexOf("https")==0?"https":"http")+"://image.providesupport.com/js/0xwrlulm7zomo09eb4gq0vx0dj/safe-standard.js?ps_h=FXQ2&ps_t="+new Date().getTime()+"&online-image=http%3A//www.rmonline.com/helpico.jpg&offline-image=http%3A//www.rmonline.com/helpico.jpg";setTimeout("seFXQ2.src=seFXQ2s;document.getElementById('sdFXQ2').appendChild(seFXQ2)",1)
        //]]></xsl:comment>

      </script>
      <noscript><div style="display:inline"><a href="http://www.providesupport.com?messenger=0xwrlulm7zomo09eb4gq0vx0dj">Online Chat</a></div></noscript>
      <!-- END ProvideSupport.com Custom Images Chat Button Code -->
	
	</td>
  </tr>
  <tr>
   <td colspan="2" class="toptext"><xsl:value-of select="$SUPPORT_TEXT"/></td>	
	</tr>
	<!-- 	
  <tr>
   <td colspan="2" class="toptext">
    <img border="0" src="/rmef/images/address.gif" alt="Registered Office"/><xsl:text> </xsl:text>
	<xsl:value-of select="/horus/row/reg_addressline1"/>,
    <xsl:if test="/horus/row/reg_addressline2">
     <xsl:value-of select="/horus/row/reg_addressline2"/>,
    </xsl:if>
	<xsl:if test="/horus/row/reg_addressline3">
     <xsl:value-of select="/horus/row/reg_addressline3"/>,
    </xsl:if>
    <xsl:if test="/horus/row/reg_posttown">
     <xsl:value-of select="/horus/row/reg_posttown"/>,
    </xsl:if>
    <xsl:if test="/horus/row/reg_county">
     <xsl:value-of select="/horus/row/reg_county"/>,
    </xsl:if>
    <xsl:value-of select="/horus/row/reg_postcode"/>,
	<xsl:value-of select="/horus/row/reg_country"/>
   </td>
  </tr>
  <tr>
   <td colspan="2" class="toptext">
    <img border="0" src="/rmef/images/contact.gif" alt="Contact"/><xsl:text> </xsl:text>
	<xsl:value-of select="/horus/row/con_name"/>
   </td>
  </tr>
  <tr>
   <td colspan="2" class="topborder" style="border-left:0;border-right:0">
    <span class="toptext">
     <img border="0" src="/rmef/images/telephone.gif" alt="Contact Telphone Number"/><xsl:text> </xsl:text>
	 <xsl:value-of select="/horus/row/con_telephone"/>&#160;&#160;
	 <img border="0" src="/rmef/images/email.gif" alt="Contact Email Address"/><xsl:text> </xsl:text>
	 <a class="toplink" href="mailto:{/horus/row/con_email}"><xsl:value-of select="/horus/row/con_email"/></a>
	</span>
   </td>
  </tr>
	-->
 </table>
</xsl:template>

<xsl:template name="country">
 <xsl:param name="NAME"/>
 <xsl:param name="COUNTRY"/>
 <xsl:param name="DISABLED"/>
 <xsl:param name="ONCHANGE"/>
 
 <select class="eincInput" name="{$NAME}" id="{$NAME}">
  <xsl:if test="$DISABLED='yes'"><xsl:attribute name="disabled">yes</xsl:attribute></xsl:if>
  <xsl:if test="string-length($ONCHANGE) != 0"><xsl:attribute name="onchange"><xsl:value-of select="$ONCHANGE"/></xsl:attribute><xsl:attribute name="onclick"><xsl:value-of select="$ONCHANGE"/></xsl:attribute></xsl:if>
  <option value="Afghanistan">Afghanistan</option>
  <option value="Aland Islands">Aland Islands</option>
  <option value="Albania">Albania</option>
  <option value="Algeria">Algeria</option>
  <option value="American Samoa">American Samoa</option>
  <option value="Andorra">Andorra</option>
  <option value="Angola">Angola</option>
  <option value="Anguilla">Anguilla</option>
  <option value="Antarctica">Antarctica</option>
  <option value="Antigua And Barbuda">Antigua And Barbuda</option>
  <option value="Argentina">Argentina</option>
  <option value="Armenia">Armenia</option>
  <option value="Aruba">Aruba</option>
  <option value="Australia">Australia</option>
  <option value="Austria">Austria</option>
  <option value="Azerbaijan">Azerbaijan</option>
  <option value="Bahamas">Bahamas</option>
  <option value="Bahrain">Bahrain</option>
  <option value="Bangladesh">Bangladesh</option>
  <option value="Barbados">Barbados</option>
  <option value="Belarus">Belarus</option>
  <option value="Belgium">Belgium</option>
  <option value="Belize">Belize</option>
  <option value="Benin">Benin</option>
  <option value="Bermuda">Bermuda</option>
  <option value="Bhutan">Bhutan</option>
  <option value="Bolivia">Bolivia</option>
  <option value="Bosnia And Herzegovina">Bosnia And Herzegovina</option>
  <option value="Botswana">Botswana</option>
  <option value="Bouvet Island">Bouvet Island</option>
  <option value="Brazil">Brazil</option>
  <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
  <option value="British Virgin Islands">British Virgin Islands</option>
  <option value="Brunei Darussalam">Brunei Darussalam</option>
  <option value="Bulgaria">Bulgaria</option>
  <option value="Burkina Faso">Burkina Faso</option>
  <option value="Burundi">Burundi</option>
  <option value="Cambodia">Cambodia</option>
  <option value="Cameroon">Cameroon</option>
  <option value="Canada">Canada</option>
  <option value="Cape Verde">Cape Verde</option>
  <option value="Cayman Islands">Cayman Islands</option>
  <option value="Central African Republic">Central African Republic</option>
  <option value="Chad">Chad</option>
  <option value="Chile">Chile</option>
  <option value="China">China</option>
  <option value="Christmas Island">Christmas Island</option>
  <option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
  <option value="Colombia">Colombia</option>
  <option value="Comoros">Comoros</option>
  <option value="Congo">Congo</option>
  <option value="Congo, The Democratic Republic Of The">Congo, The Democratic Republic Of The</option>
  <option value="Cook Islands">Cook Islands</option>
  <option value="Costa Rica">Costa Rica</option>
  <option value="Cote D'ivoire">Cote D'ivoire</option>
  <option value="Croatia">Croatia</option>
  <option value="Cuba">Cuba</option>
  <option value="Cyprus">Cyprus</option>
  <option value="Czech Republic">Czech Republic</option>
  <option value="Denmark">Denmark</option>
  <option value="Djibouti">Djibouti</option>
  <option value="Dominica">Dominica</option>
  <option value="Dominican Republic">Dominican Republic</option>
  <option value="Ecuador">Ecuador</option>
  <option value="Egypt">Egypt</option>
  <option value="El Salvador">El Salvador</option>
  <option value="Equatorial Guinea">Equatorial Guinea</option>
  <option value="Eritrea">Eritrea</option>
  <option value="Estonia">Estonia</option>
  <option value="Ethiopia">Ethiopia</option>
  <option value="Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
  <option value="Faroe Islands">Faroe Islands</option>
  <option value="Fiji">Fiji</option>
  <option value="Finland">Finland</option>
  <option value="France">France</option>
  <option value="French Guiana">French Guiana</option>
  <option value="French Polynesia">French Polynesia</option>
  <option value="French Southern Territories">French Southern Territories</option>
  <option value="Gabon">Gabon</option>
  <option value="Gambia">Gambia</option>
  <option value="Georgia">Georgia</option>
  <option value="Germany">Germany</option>
  <option value="Ghana">Ghana</option>
  <option value="Gibraltar">Gibraltar</option>
  <option value="Greece">Greece</option>
  <option value="Greenland">Greenland</option>
  <option value="Grenada">Grenada</option>
  <option value="Guadeloupe">Guadeloupe</option>
  <option value="Guam">Guam</option>
  <option value="Guatemala">Guatemala</option>
  <option value="Guernsey">Guernsey</option>
  <option value="Guinea">Guinea</option>
  <option value="Guinea-Bissau">Guinea-Bissau</option>
  <option value="Guyana">Guyana</option>
  <option value="Haiti">Haiti</option>
  <option value="Heard Island And Mcdonald Islands">Heard Island And Mcdonald Islands</option>
  <option value="Holy See (Vatican City State)">Holy See (Vatican City State)</option>
  <option value="Honduras">Honduras</option>
  <option value="Hong Kong">Hong Kong</option>
  <option value="Hungary">Hungary</option>
  <option value="Iceland">Iceland</option>
  <option value="India">India</option>
  <option value="Indonesia">Indonesia</option>
  <option value="Iran, Islamic Republic Of">Iran, Islamic Republic Of</option>
  <option value="Iraq">Iraq</option>
  <option value="Ireland">Ireland</option>
  <option value="Isle Of Man">Isle Of Man</option>
  <option value="Israel">Israel</option>
  <option value="Italy">Italy</option>
  <option value="Jamaica">Jamaica</option>
  <option value="Japan">Japan</option>
  <option value="Jersey">Jersey</option>
  <option value="Jordan">Jordan</option>
  <option value="Kazakhstan">Kazakhstan</option>
  <option value="Kenya">Kenya</option>
  <option value="Kiribati">Kiribati</option>
  <option value="Korea, Democratic People's Republic Of">Korea, Democratic People's Republic Of</option>
  <option value="Korea, Republic Of">Korea, Republic Of</option>
  <option value="Kuwait">Kuwait</option>
  <option value="Kyrgyzstan">Kyrgyzstan</option>
  <option value="Lao People's Democratic Republic">Lao People's Democratic Republic</option>
  <option value="Latvia">Latvia</option>
  <option value="Lebanon">Lebanon</option>
  <option value="Lesotho">Lesotho</option>
  <option value="Liberia">Liberia</option>
  <option value="Libyan Arab Jamahiriya">Libyan Arab Jamahiriya</option>
  <option value="Liechtenstein">Liechtenstein</option>
  <option value="Lithuania">Lithuania</option>
  <option value="Luxembourg">Luxembourg</option>
  <option value="Macao">Macao</option>
  <option value="Macedonia, The Former Yugoslav Republic Of">Macedonia, The Former Yugoslav Republic Of</option>
  <option value="Madagascar">Madagascar</option>
  <option value="Malawi">Malawi</option>
  <option value="Malaysia">Malaysia</option>
  <option value="Maldives">Maldives</option>
  <option value="Mali">Mali</option>
  <option value="Malta">Malta</option>
  <option value="Marshall Islands">Marshall Islands</option>
  <option value="Martinique">Martinique</option>
  <option value="Mauritania">Mauritania</option>
  <option value="Mauritius">Mauritius</option>
  <option value="Mayotte">Mayotte</option>
  <option value="Mexico">Mexico</option>
  <option value="Micronesia, Federated States Of">Micronesia, Federated States Of</option>
  <option value="Moldova, Republic Of">Moldova, Republic Of</option>
  <option value="Monaco">Monaco</option>
  <option value="Mongolia">Mongolia</option>
  <option value="Montenegro">Montenegro</option>
  <option value="Montserrat">Montserrat</option>
  <option value="Morocco">Morocco</option>
  <option value="Mozambique">Mozambique</option>
  <option value="Myanmar">Myanmar</option>
  <option value="Namibia">Namibia</option>
  <option value="Nauru">Nauru</option>
  <option value="Nepal">Nepal</option>
  <option value="Netherlands">Netherlands</option>
  <option value="Netherlands Antilles">Netherlands Antilles</option>
  <option value="New Caledonia">New Caledonia</option>
  <option value="New Zealand">New Zealand</option>
  <option value="Nicaragua">Nicaragua</option>
  <option value="Niger">Niger</option>
  <option value="Nigeria">Nigeria</option>
  <option value="Niue">Niue</option>
  <option value="Norfolk Island">Norfolk Island</option>
  <option value="Northern Mariana Islands">Northern Mariana Islands</option>
  <option value="Norway">Norway</option>
  <option value="Oman">Oman</option>
  <option value="Pakistan">Pakistan</option>
  <option value="Palau">Palau</option>
  <option value="Palestinian Territory, Occupied">Palestinian Territory, Occupied</option>
  <option value="Panama">Panama</option>
  <option value="Papua New Guinea">Papua New Guinea</option>
  <option value="Paraguay">Paraguay</option>
  <option value="Peru">Peru</option>
  <option value="Philippines">Philippines</option>
  <option value="Pitcairn">Pitcairn</option>
  <option value="Poland">Poland</option>
  <option value="Portugal">Portugal</option>
  <option value="Puerto Rico">Puerto Rico</option>
  <option value="Qatar">Qatar</option>
  <option value="Reunion">Reunion</option>
  <option value="Romania">Romania</option>
  <option value="Russian Federation">Russian Federation</option>
  <option value="Rwanda">Rwanda</option>
  <option value="Saint Helena">Saint Helena</option>
  <option value="Saint Kitts And Nevis">Saint Kitts And Nevis</option>
  <option value="Saint Lucia">Saint Lucia</option>
  <option value="Saint Pierre And Miquelon">Saint Pierre And Miquelon</option>
  <option value="Saint Vincent And The Grenadines">Saint Vincent And The Grenadines</option>
  <option value="Samoa">Samoa</option>
  <option value="San Marino">San Marino</option>
  <option value="Sao Tome And Principe">Sao Tome And Principe</option>
  <option value="Saudi Arabia">Saudi Arabia</option>
  <option value="Senegal">Senegal</option>
  <option value="Serbia">Serbia</option>
  <option value="Seychelles">Seychelles</option>
  <option value="Sierra leone">Sierra leone</option>
  <option value="Singapore">Singapore</option>
  <option value="Slovakia">Slovakia</option>
  <option value="Slovenia">Slovenia</option>
  <option value="Solomon Islands">Solomon Islands</option>
  <option value="Somalia">Somalia</option>
  <option value="South Africa">South Africa</option>
  <option value="South Georgia And The South Sandwich Islands">South Georgia And The South Sandwich Islands</option>
  <option value="Spain">Spain</option>
  <option value="Sri Lanka">Sri Lanka</option>
  <option value="Sudan">Sudan</option>
  <option value="Suriname">Suriname</option>
  <option value="Svalbard And Jan Mayen">Svalbard And Jan Mayen</option>
  <option value="Swaziland">Swaziland</option>
  <option value="Sweden">Sweden</option>
  <option value="Switzerland">Switzerland</option>
  <option value="Syrian Arab Republic">Syrian Arab Republic</option>
  <option value="Taiwan, Province Of China">Taiwan, Province Of China</option>
  <option value="Tajikistan">Tajikistan</option>
  <option value="Tanzania, United Republic Of">Tanzania, United Republic Of</option>
  <option value="Thailand">Thailand</option>
  <option value="Timor-Leste">Timor-Leste</option>
  <option value="Togo">Togo</option>
  <option value="Tokelau">Tokelau</option>
  <option value="Tonga">Tonga</option>
  <option value="Trinidad And Tobago">Trinidad And Tobago</option>
  <option value="Tunisia">Tunisia</option>
  <option value="Turkey">Turkey</option>
  <option value="Turkmenistan">Turkmenistan</option>
  <option value="Turks And Caicos Islands">Turks And Caicos Islands</option>
  <option value="Tuvalu">Tuvalu</option>
  <option value="Uganda">Uganda</option>
  <option value="Ukraine">Ukraine</option>
  <option value="United Arab Emirates">United Arab Emirates</option>
  <option selected="selected" value="United Kingdom">United Kingdom</option>
  <option value="United States">United States</option>
  <option value="United States Minor Outlying Islands">United States Minor Outlying Islands</option>
  <option value="Uruguay">Uruguay</option>
  <option value="Uzbekistan">Uzbekistan</option>
  <option value="Vanuatu">Vanuatu</option>
  <option value="Venezuela">Venezuela</option>
  <option value="Viet Nam">Viet Nam</option>
  <option value="Virgin Islands, British">Virgin Islands, British</option>
  <option value="Virgin Islands, U.S.">Virgin Islands, U.S.</option>
  <option value="Wallis And Futuna">Wallis And Futuna</option>
  <option value="Western Sahara">Western Sahara</option>
  <option value="Yemen">Yemen</option>
  <option value="Zambia">Zambia</option>
  <option value="Zimbabwe">Zimbabwe</option>
 </select>
 
 <script language="javascript">
  var sel = '<xsl:value-of select="$NAME"/>';
  var val = '<xsl:value-of select="$COUNTRY"/>';
  
  for (var i = 0; i &lt; document.getElementById(sel).length; i++) {
    if (document.getElementById(sel).options[i].value == val)
	  document.getElementById(sel).options[i].selected=true;
  }	
 </script>
</xsl:template>

<xsl:template name="nationality">
 <xsl:param name="NAME"/>
 <xsl:param name="VALUE"/>
 
 <select class="eincInput" name="{$NAME}" id="{$NAME}" onchange="showHideOther('{$NAME}_other',this)">
  <option value="Afghan">Afghan</option>
  <option value="Albanian">Albanian</option>
  <option value="Algerian">Algerian</option>
  <option value="American">American</option>
  <option value="Andorran">Andorran</option>
  <option value="Angolan">Angolan</option>
  <option value="Antiguans, Barbudans">Antiguans, Barbudans</option>
  <option value="Argentine">Argentine</option>
  <option value="Armenian">Armenian</option>
  <option value="Australian">Australian</option>
  <option value="Austrian">Austrian</option>
  <option value="Azerbaijani">Azerbaijani</option>
  <option value="Bahamian">Bahamian</option>
  <option value="Bahraini">Bahraini</option>
  <option value="Bangladeshi">Bangladeshi</option>
  <option value="Barbadian">Barbadian</option>
  <option value="Belarusian">Belarusian</option>
  <option value="Belgian">Belgian</option>
  <option value="Belizean">Belizean</option>
  <option value="Beninese">Beninese</option>
  <option value="Bhutanese">Bhutanese</option>
  <option value="Bolivian">Bolivian</option>
  <option value="Bosnian, Herzegovinian">Bosnian, Herzegovinian</option>
  <option value="Brazilian">Brazilian</option>
  <option value="British">British</option>
  <option value="Bruneian">Bruneian</option>
  <option value="Bulgarian">Bulgarian</option>
  <option value="Burkinabe">Burkinabe</option>
  <option value="Burmese">Burmese</option>
  <option value="Burundian">Burundian</option>
  <option value="Cambodian">Cambodian</option>
  <option value="Cameroonian">Cameroonian</option>
  <option value="Canadian">Canadian</option>
  <option value="Cape Verdian">Cape Verdian</option>
  <option value="Central African">Central African</option>
  <option value="Chadian">Chadian</option>
  <option value="Chilean">Chilean</option>
  <option value="Chinese">Chinese</option>
  <option value="Colombian">Colombian</option>
  <option value="Comoran">Comoran</option>
  <option value="Congolese">Congolese</option>  
  <option value="Costa Rican">Costa Rican</option>
  <option value="Croat">Croat</option>
  <option value="Cuban">Cuban</option>
  <option value="Cypriot">Cypriot</option>
  <option value="Czech">Czech</option>
  <option value="Dane">Dane</option>
  <option value="Djibouti">Djibouti</option>
  <option value="Dominican">Dominican</option>
  <option value="Dominican">Dominican</option>
  <option value="Dutch">Dutch</option>
  <option value="East Timorese">East Timorese</option>
  <option value="Ecuadorean">Ecuadorean</option>
  <option value="Egyptian">Egyptian</option>
  <option value="Emirian">Emirian</option>
  <option value="Equatorial Guinean">Equatorial Guinean</option>
  <option value="Eritrean">Eritrean</option>
  <option value="Estonian">Estonian</option>
  <option value="Ethiopian">Ethiopian</option>
  <option value="Fijian">Fijian</option>
  <option value="Filipino">Filipino</option>
  <option value="Finn">Finn</option>
  <option value="French">French</option>  
  <option value="Gabonese">Gabonese</option>
  <option value="Gambian">Gambian</option>
  <option value="Georgian">Georgian</option>
  <option value="German">German</option>
  <option value="Ghanaian">Ghanaian</option>
  <option value="Greek">Greek</option>
  <option value="Grenadian">Grenadian</option>
  <option value="Guatemalan">Guatemalan</option>
  <option value="Guinea-Bissauan">Guinea-Bissauan</option>
  <option value="Guinean">Guinean</option>
  <option value="Guyanese">Guyanese</option>
  <option value="Haitian">Haitian</option>
  <option value="Honduran">Honduran</option>
  <option value="Hungarian">Hungarian</option>
  <option value="Icelander">Icelander</option>
  <option value="I-Kiribati">I-Kiribati</option>
  <option value="Indian">Indian</option>
  <option value="Indonesian">Indonesian</option>  
  <option value="Iranian">Iranian</option>
  <option value="Iraqi">Iraqi</option>
  <option value="Irish">Irish</option>
  <option value="Israeli">Israeli</option>
  <option value="Italian">Italian</option>
  <option value="Ivorian">Ivorian</option>
  <option value="Jamaican">Jamaican</option>
  <option value="Japanese">Japanese</option>
  <option value="Jordanian">Jordanian</option>
  <option value="Kazakhstani">Kazakhstani</option>
  <option value="Kenyan">Kenyan</option>
  <option value="Kittian and Nevisian">Kittian and Nevisian</option>
  <option value="Kuwaiti">Kuwaiti</option>
  <option value="Kyrgyz">Kyrgyz</option>
  <option value="Lao or Laotian">Lao or Laotian</option>
  <option value="Latvian">Latvian</option>
  <option value="Lebanese">Lebanese</option>
  <option value="Liberian">Liberian</option>
  <option value="Libyan">Libyan</option>  
  <option value="Liechtensteiner">Liechtensteiner</option>
  <option value="Lithuanian">Lithuanian</option>
  <option value="Luxembourger">Luxembourger</option>
  <option value="Macedonian">Macedonian</option>
  <option value="Malagasy">Malagasy</option>
  <option value="Malawian">Malawian</option>
  <option value="Malaysian">Malaysian</option>
  <option value="Maldivan">Maldivan</option>
  <option value="Malian">Malian</option>
  <option value="Maltese">Maltese</option>
  <option value="Marshallese">Marshallese</option>
  <option value="Mauritanian">Mauritanian</option>
  <option value="Mauritian">Mauritian</option>
  <option value="Mexican">Mexican</option>
  <option value="Micronesian">Micronesian</option>
  <option value="Moldovan">Moldovan</option>
  <option value="Monegasque">Monegasque</option>
  <option value="Mongolian">Mongolian</option>
  <option value="Moroccan">Moroccan</option>
  <option value="Mosotho">Mosotho</option>
  <option value="Motswana">Motswana</option>
  <option value="Mozambican">Mozambican</option>
  <option value="Namibian">Namibian</option>
  <option value="Nauruan">Nauruan</option>
  <option value="Nepalese">Nepalese</option>
  <option value="New Zealander">New Zealander</option>
  <option value="Nicaraguan">Nicaraguan</option>
  <option value="Nigerian">Nigerian</option>
  <option value="Nigerien">Nigerien</option>
  <option value="Ni-Vanuatu">Ni-Vanuatu</option>
  <option value="North Korean">North Korean</option>
  <option value="Norwegian">Norwegian</option>
  <option value="Omani">Omani</option>
  <option value="Pakistani">Pakistani</option>
  <option value="Palauan">Palauan</option>
  <option value="Panamanian">Panamanian</option>
  <option value="Papua New Guinean">Papua New Guinean</option>
  <option value="Paraguayan">Paraguayan</option>
  <option value="Peruvian">Peruvian</option>
  <option value="Polish">Polish</option>
  <option value="Portuguese">Portuguese</option>
  <option value="Qatari">Qatari</option>
  <option value="Romanian">Romanian</option>
  <option value="Russian">Russian</option>
  <option value="Rwandan">Rwandan</option>
  <option value="Saint Lucian">Saint Lucian</option>
  <option value="Salvadoran">Salvadoran</option>
  <option value="Sammarinese">Sammarinese</option>
  <option value="Samoan">Samoan</option>
  <option value="Sao Tomean">Sao Tomean</option>
  <option value="Saudi">Saudi</option>
  <option value="Senegalese">Senegalese</option>
  <option value="Serbian">Serbian</option>
  <option value="Seychellois">Seychellois</option>
  <option value="Sierra Leonean">Sierra Leonean</option>
  <option value="Singaporean">Singaporean</option>
  <option value="Slovak">Slovak</option>
  <option value="Slovene">Slovene</option>
  <option value="Solomon Islander">Solomon Islander</option>
  <option value="Somali">Somali</option>
  <option value="South African">South African</option>
  <option value="South Korean">South Korean</option>
  <option value="Spaniard">Spaniard</option>
  <option value="Sri Lankan">Sri Lankan</option>
  <option value="Sudanese">Sudanese</option>
  <option value="Surinamer">Surinamer</option>
  <option value="Swazi">Swazi</option>
  <option value="Swede">Swede</option>
  <option value="Swiss">Swiss</option>
  <option value="Syrian">Syrian</option>
  <option value="Taiwanese">Taiwanese</option>
  <option value="Tajik">Tajik</option>
  <option value="Tanzanian">Tanzanian</option>
  <option value="Thai">Thai</option>
  <option value="Togolese">Togolese</option>
  <option value="Tongan">Tongan</option>
  <option value="Trinidadian">Trinidadian</option>
  <option value="Tunisian">Tunisian</option>
  <option value="Turk">Turk</option>
  <option value="Turkmen(s)">Turkmen(s)</option>
  <option value="Tuvaluan">Tuvaluan</option>
  <option value="Ugandan">Ugandan</option>
  <option value="Ukrainian">Ukrainian</option>
  <option value="Uruguayan">Uruguayan</option>
  <option value="Uzbek">Uzbek</option>
  <option value="Venezuelan">Venezuelan</option>
  <option value="Vietnamese">Vietnamese</option>
  <option value="Yemeni">Yemeni</option>
  <option value="Zambian">Zambian</option>
  <option value="Zimbabwean">Zimbabwean</option>
  <option value="0">Other</option>
 </select>
 
 <xsl:call-template name="selection_box">
  <xsl:with-param name="NAME"><xsl:value-of select="$NAME"/></xsl:with-param>
  <xsl:with-param name="VALUE"><xsl:value-of select="$VALUE"/></xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template name="title">
 <xsl:param name="NAME"/>
 <xsl:param name="VALUE"/>
 
 <select class="eincInput" name="{$NAME}" id="{$NAME}" onchange="showHideOther('{$NAME}_other',this)" style="width:130px;">
  <option selected="selected" value=""></option>
  <option value="Mr">Mr</option>
  <option value="Mrs">Mrs</option>
  <option value="Miss">Miss</option>
  <option value="Ms">Ms</option>
  <option value="Dr">Dr</option>
  <option value="Sir">Sir</option>
  <option value="0">Other</option>
 </select>
 
 <xsl:call-template name="selection_box">
  <xsl:with-param name="NAME"><xsl:value-of select="$NAME"/></xsl:with-param>
  <xsl:with-param name="VALUE"><xsl:value-of select="$VALUE"/></xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template name="honours">
 <xsl:param name="NAME"/>
 <xsl:param name="VALUE"/>
 
 <select class="eincInput" name="{$NAME}" id="{$NAME}" onchange="showHideOther('{$NAME}_other',this)" style="width:130px;">
  <option selected="selected" value=""></option>
  <option value="Lord">Lord</option>
  <option value="Lady">Lady</option>
  <option value="Viscount">Viscount</option>
  <option value="Earl">Earl</option>
  <option value="Dame">Dame</option>
  <option value="Marquess">Marquess</option>
  <option value="Duke">Duke</option>
  <option value="Duchess">Duchess</option>
  <option value="Baroness">Baroness</option>
  <option value="Baron">Baron</option>
  <option value="0">Other</option>
 </select>
 
 <xsl:call-template name="selection_box">
  <xsl:with-param name="NAME"><xsl:value-of select="$NAME"/></xsl:with-param>
  <xsl:with-param name="VALUE"><xsl:value-of select="$VALUE"/></xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template name="occupation">
 <xsl:param name="NAME"/>
 <xsl:param name="VALUE"/>
 
 <select class="eincInput" name="{$NAME}" id="{$NAME}" onchange="showHideOther('{$NAME}_other',this)" style="width:130px;">
  <option selected="selected" value=""></option>
  <option value="Director">Director</option>
  <option value="Accountant">Accountant</option>
  <option value="Solicitor">Solicitor</option>
  <option value="Chartered Secretary">Chartered Secretary</option>
  <option value="Manager">Manager</option>
  <option value="Consultant">Consultant</option>
  <option value="IT Specialist">IT Specialist</option>
  <option value="0">Other</option>
 </select>
 
 <xsl:call-template name="selection_box">
  <xsl:with-param name="NAME"><xsl:value-of select="$NAME"/></xsl:with-param>
  <xsl:with-param name="VALUE"><xsl:value-of select="$VALUE"/></xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template name="selection_box">
  <xsl:param name="NAME"/>
  <xsl:param name="VALUE"/>
  
  <script>
    var sel = '<xsl:value-of select="$NAME"/>';
    var val = '<xsl:value-of select="$VALUE"/>';
	
	<xsl:comment><![CDATA[
	var found = "";
  
    for (var i = 0; i < document.getElementById(sel).length; i++) {
      if (document.getElementById(sel).options[i].value == val) {
	    document.getElementById(sel).options[i].selected=true;
		found = "yes";
	  }
    }
		   
	if (val!="" && found=="") {
	  document.writeln ("<input name=\"" + sel + "_other\" maxlength=\"30\" id=\"" + sel + "_other\" value=\"" + val + "\"/>");
	  for (var i = 0; i < document.getElementById(sel).length; i++) {
        if (document.getElementById(sel).options[i].value == "0")
	      document.getElementById(sel).options[i].selected=true;
	  }
	}
	else
	  document.writeln ("<input name=\"" + sel + "_other\" maxlength=\"30\" id=\"" + sel + "_other\" style=\"width:200px;display:none\"/>");
    //]]></xsl:comment>
  </script>
</xsl:template>

<xsl:template name="dob">
 <select id="dob_dd" class="eincInput" name="dob_dd">
  <option value="01">01</option> <option value="02">02</option>
  <option value="03">03</option> <option value="04">04</option>
  <option value="05">05</option> <option value="06">06</option>
  <option value="07">07</option> <option value="08">08</option>
  <option value="09">09</option> <option value="10">10</option>
  <option value="11">11</option> <option value="12">12</option>
  <option value="13">13</option> <option value="14">14</option>
  <option value="15">15</option> <option value="16">16</option>
  <option value="17">17</option> <option value="18">18</option>
  <option value="19">19</option> <option value="20">20</option>
  <option value="21">21</option> <option value="22">22</option>
  <option value="23">23</option> <option value="24">24</option>
  <option value="25">25</option> <option value="26">26</option>
  <option value="27">27</option> <option value="28">28</option>
  <option value="29">29</option> <option value="30">30</option>
  <option value="31">31</option>
 </select>&#xa0;
 <select id="dob_mm" class="eincInput" name="dob_mm">
  <option value="01">January</option> 
  <option value="02">February</option>
  <option value="03">March</option> 
  <option value="04">April</option>
  <option value="05">May</option> 
  <option value="06">June</option>
  <option value="07">July</option> 
  <option value="08">August</option>
  <option value="09">September</option> 
  <option value="10">October</option>
  <option value="11">November</option> 
  <option value="12">December</option>
 </select>&#xa0;
 <script language="JavaScript">
 <xsl:comment><![CDATA[
   var time = new Date();
   var year = time.getYear();
		   
   if (year < 1900) { year = year + 1900; }

   var date = year - 100; 
   var selYear = date;
   var future = year;  

	 var i = 0;

   document.writeln ("<select id=\"dob_yy\" class=\"btn\" name=\"dob_yy\">");
   do {
     date++;
     i++;
     if (i != 51)
			document.write ("<option value=\"" +date+"\">" +date+ "</option>");
     else 
			document.write ("<option selected value=\"" +date+"\">" +date+ " </option>");
   }
   while (date < future)
   document.write ("</select>");
 //]]></xsl:comment>
 </script>
</xsl:template>

<xsl:template name="service_address">

   <tr id="row_service_header">
    <td colspan="2" class="subhead">Service Address Details (this is the address that will appear on public records)</td>
   </tr>
	 <tr id="row_service_text">
      <td colspan="2">
        <p><br/>The service address is the address that will appear on the public record. This does not have to be your usual residential address. If you leave this blank your residential address will appear on the public record<br/><br/></p>
			</td>
	 </tr>	 
		
		<script type="text/javascript">

			var regAddr1 = '<xsl:value-of select="/horus/row/reg_addressline1"/>';
			var regAddr2 = '<xsl:value-of select="/horus/row/reg_addressline2"/>';
			var regAddr3 = '<xsl:value-of select="/horus/row/reg_addressline3"/>';
			var regTown = '<xsl:value-of select="/horus/row/reg_posttown"/>';
			var regCounty = '<xsl:value-of select="/horus/row/reg_county"/>';
			var regPostcode = '<xsl:value-of select="/horus/row/reg_postcode"/>';
			var regCountry = '<xsl:value-of select="/horus/row/reg_country"/>';

			var serviceSavedAddr1 = '<xsl:value-of select="/horus/row/serviceaddressline1"/>';
			var serviceSavedPostcode = '<xsl:value-of select="/horus/row/servicepostcode"/>';



			function populateServiceAddress(indexNumber){

				if (indexNumber == 1)
					blankServiceAddress();
				if (indexNumber == 2)
					regServiceAddress();
				if (indexNumber == 3)
					RMServiceAddress();
			}
			
			function blankServiceAddress(){
				clearServiceAddress();
				showServiceAddress(false);
			}

			function clearServiceAddress(){
				with (document.einc){
    			serviceAddressLine1.value="";
    			serviceAddressLine2.value="";
    			serviceAddressLine3.value="";
    			servicePostTown.value="";
    			servicePostcode.value="";
    			serviceCounty.value="";
      		serviceCountry.value="";
				}
			}

			function ownServiceAddress(){
				blankServiceAddress();
				showServiceAddress(true);
			}

			function showServiceAddressHeader(show){
				with (document.einc){
					showHide('row_service_header',show);
					showHide('row_service_text',show);
					showHide('row_service_address_type', show);
   				showHide('row_service_address_type1',show);
   				showHide('row_service_address_type_other',show);
				}				
			}


			function showServiceAddress(show){
				with (document.einc){
					showHide('row_serviceaddressLine1',show);
					showHide('row_serviceaddressLine2',show);
					showHide('row_serviceaddressLine3',show);
					showHide('row_servicepostTown',show);
   				showHide('row_servicepostcode',show);
   				showHide('row_servicecounty',show);
   				showHide('row_serviceCountry',show);
				}				
			}

			function regServiceAddress(){
				showServiceAddress(false);
				with (document.einc){
					serviceAddressLine1.value=regAddr1;
					serviceAddressLine2.value=regAddr2;
					serviceAddressLine3.value=regAddr3;
					servicePostTown.value=regTown;
					servicePostcode.value=regPostcode;
					serviceCounty.value=regCounty;
      		serviceCountry.value="United Kingdom";
				}
			}

			function RMServiceAddress(){
				showServiceAddress(false);
				with (document.einc){
    			serviceAddressLine1.value="RMCS COMPANY SECRETARIES LIMITED";
    			serviceAddressLine2.value="Invision House";
    			serviceAddressLine3.value="Wilbury Way";
    			servicePostTown.value="Hitchin";
    			servicePostcode.value="SG4 0TW";
    			serviceCounty.value="Hertfordshire";
      		serviceCountry.value="United Kingdom";
				}
			}

			function setServiceOptions(){
				with (document.einc){

					 if (regAddr1 != 'RMCS COMPANY SECRETARIES LIMITED' &amp;&amp;  regPostcode !== 'SG4 0TW')
          	showHide('row_service_address_type1', true);

					// Set the default option for service address type
					// RM service address
					if (serviceSavedAddr1 == 'RMCS COMPANY SECRETARIES LIMITED' &amp;&amp;  serviceSavedPostcode == 'SG4 0TW')
						service_address_type[3].checked = true;
					// registered office
					else if (serviceSavedAddr1 == regAddr1 &amp;&amp;  serviceSavedPostcode == regPostcode)
          	einc.service_address_type[0].checked = true;
					// blank
					else if (serviceSavedAddr1 == '' &amp;&amp;  serviceSavedPostcode == '')
          	service_address_type[2].checked = true;
					else{
          	service_address_type[1].checked = true;
						showServiceAddress(true);
					}
				}	
			}

			function setPopulatedServiceOptions(){
				with (document.einc){

					if (regAddr1 != 'RMCS COMPANY SECRETARIES LIMITED' &amp;&amp;  regPostcode !== 'SG4 0TW')
          				showHide('row_service_address_type1', true);

					// Set the default option for service address type
					// RM service address
					if (serviceSavedAddr1 == 'RMCS COMPANY SECRETARIES LIMITED' &amp;&amp;  serviceSavedPostcode == 'SG4 0TW')
					{
						service_address_type[3].checked = true;
					}
					// registered office
					else if (serviceSavedAddr1 == regAddr1 &amp;&amp;  serviceSavedPostcode == regPostcode){
          				einc.service_address_type[0].checked = true;
					}
					// blank
					else if (serviceSavedAddr1 == '' &amp;&amp;  serviceSavedPostcode == ''){
          				service_address_type[2].checked = true;
					}
					else{
          				service_address_type[1].checked = true;
						showServiceAddress(true);
					}
				}	
			}
			function setPreviousServiceOptions(){
				with (document.einc){
					if (document.getElementById("serviceAddressLine1").value == 'RMCS COMPANY SECRETARIES LIMITED'){
						showServiceAddress(false);
						service_address_type[3].checked = true;
					}
					else{
						if (document.getElementById("serviceAddressLine1").value == ''){
							service_address_type[2].checked = true;
							showServiceAddress(false);
						}
						else{
          					service_address_type[1].checked = true;
							showServiceAddress(true);
						}
					}
				}

			}
			
  	</script>

	 <tr id="row_service_address_type">	
		<td class="texthead">Prefill Service Address</td><td/>
	  <td/>
	 </tr>
	 <tr id="row_service_address_type1" style="display:none">
		<td/>
		<td><p class="page-text">
				<input type="radio" name="service_address_type" id="service_address_type" onclick="regServiceAddress()" value="reg">Use registered office as the service address</input>	
		</p></td></tr>
		<tr id="row_service_address_type_other">
		<td/><td><p class="page-text">
				<input type="radio" name="service_address_type" id="service_address_type" onclick="ownServiceAddress()" value="own">Enter your own service address below</input>		
				<br/>
				<input type="radio" name="service_address_type" id="service_address_type" onclick="blankServiceAddress()" value="blank">Show your home address on public records</input>		
				<br/>
				<input type="radio" name="service_address_type" id="service_address_type" onclick="RMServiceAddress()" value="rm">Use our Service Address (extra charges apply)</input>		
				<br/>
			</p>
		</td></tr>
   <tr><td><br/></td></tr>

   <tr id="row_serviceaddressLine1" style="display:none" >
    <td class="texthead">Address </td>
    <td><input class="eincInput" name="serviceAddressLine1" type="text" maxlength="60" id="serviceAddressLine1" value="{/horus/row/serviceaddressline1}" size="40"/></td>
   </tr>
   <tr id="row_serviceaddressLine2" style="display:none">
    <td/>
    <td><input class="eincInput" name="serviceAddressLine2" type="text" maxlength="60" id="serviceAddressLine2" value="{/horus/row/serviceaddressline2}" size="40"/></td>
   </tr>
   <tr id="row_serviceaddressLine3" style="display:none">
    <td/>
    <td><input class="eincInput" name="serviceAddressLine3" type="text" maxlength="60" id="serviceAddressLine3" value="{/horus/row/serviceaddressline3}" size="40"/></td>
   </tr>
   <tr id="row_servicepostTown" style="display:none">
    <td class="texthead">Post Town</td>
    <td><input class="eincInput" name="servicePostTown" type="text" maxlength="30" id="servicePostTown" value="{/horus/row/serviceposttown}" size="30"/></td>
   </tr>
   <tr id="row_servicepostcode" style="display:none">
    <td class="texthead">Postcode</td>
    <td><input class="eincInput" name="servicePostcode" type="text" maxlength="15" id="servicePostcode" value="{/horus/row/servicepostcode}" size="10" style="text-transform:uppercase;"/></td>
   </tr>
   <tr id="row_servicecounty" style="display:none">
    <td class="texthead">County</td>
    <td><input class="eincInput" name="serviceCounty" type="text" maxlength="30" id="serviceCounty" value="{/horus/row/servicecounty}" size="30"/></td>
   </tr>

   <tr id="row_serviceCountry" style="display:none">
   <td class="texthead">Country</td>
    <td>
     <xsl:call-template name="country">
      <xsl:with-param name="NAME">serviceCountry</xsl:with-param>
      <xsl:with-param name="COUNTRY">United Kingdom</xsl:with-param>
    <xsl:with-param name="DISABLED">no</xsl:with-param>
     </xsl:call-template>
    </td>
   </tr>
   <tr><td><br/></td></tr>

	 <script type="text/javascript">

		setServiceOptions();

	 </script>	

</xsl:template>

</xsl:stylesheet>
			  
