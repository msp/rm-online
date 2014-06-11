<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template name="busprofile">
<xsl:variable name="SID"><xsl:value-of select="/horus/@session"/></xsl:variable>

<!-- table width="100%" bgcolor="#c7e0ff" style="height:100%" -->
<div style="background-color:c7e0ff; height:600;">
<table width="100%">
  <tr><td align="center" colspan="3"><font size="3"><b>Business Profile</b></font></td></tr>
  <tr>
	<td colspan="3">
	  <img border="0" height="10" src="/comgate/images/spacer.gif" width="3"/>
	</td>
  </tr>
  <tr>
    <td class="display-label" width="100px">Reg No.</td>
	<td class="display-label" width="2px">:</td>
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/cro_number"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/cro_number"/>
	</td>
  </tr>
  <tr>
    <td class="display-label" width="100px">Name</td>
	<td class="display-label" width="2px">:</td>
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/name"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/name"/>
	</td>
  </tr>
  <tr>
	<td class="display-label">Registered Office</td>
	<td class="display-label">:</td> 
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/ro_address/line_one"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/ro_address/line_one"/>
	</td>
  </tr>
  <tr>
    <td/>
	<td/>
    <td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/ro_address/line_two"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/ro_address/line_two"/>
	</td>
  </tr>
  <tr>
	<td/>
	<td/>
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/ro_address/line_three"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/ro_address/line_three"/>
	</td>
  </tr>
  <tr>
	<td/>
	<td/>
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/ro_address/line_four"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/ro_address/line_four"/>
	</td>
  </tr>
  <tr>
    <td class="display-label">Post Code</td>
	<td class="display-label">:</td>
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/ro_address/postcode"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/ro_address/postcode"/>
	</td>
  </tr>
  <tr>
	<td class="display-label">Incorporated</td>
	<td class="display-label">:</td>
	<td>
	  <xsl:value-of select="/horus/access_control/companies_house_data/incorporation_date"/>
	  <xsl:value-of select="/horus/company_report/companies_house_data/incorporation_date"/>
	</td>
  </tr>
  <tr>
	<td class="display-label">Latest Accounts</td>
	<td class="display-label">:</td>
	  <td>
		<xsl:if test="/horus/access_control/companies_house_data/acc_made_up_date[. = '?']">
		  <xsl:text>Not Filed</xsl:text>
		</xsl:if>
		<xsl:if test="/horus/access_control/companies_house_data/acc_made_up_date[. != '?']">
		  <xsl:value-of select="/horus/access_control/companies_house_data/acc_made_up_date"/>
		</xsl:if>
		<xsl:if test="/horus/company_report/companies_house_data/acc_made_up_date[. = '?']">
		  <xsl:text>Not Filed</xsl:text>
		</xsl:if>
		<xsl:if test="/horus/company_report/companies_house_data/acc_made_up_date[. != '?']">
		  <xsl:value-of select="/horus/company_report/companies_house_data/acc_made_up_date"/>
		</xsl:if>
	  </td>
	</tr>
    <tr>
	  <td class="display-label">Annual Returns</td>
	  <td class="display-label">:</td>
	  <td>
	    <xsl:if test="/horus/access_control/companies_house_data/ret_made_up_date[. = '?']">
	      <xsl:text>Not Filed</xsl:text>
	    </xsl:if>
	    <xsl:if test="/horus/access_control/companies_house_data/ret_made_up_date[. != '?']">
 	      <xsl:value-of select="/horus/access_control/companies_house_data/ret_made_up_date"/>
	    </xsl:if>
		<xsl:if test="/horus/company_report/companies_house_data/ret_made_up_date[. = '?']">
	      <xsl:text>Not Filed</xsl:text>
	    </xsl:if>
	    <xsl:if test="/horus/company_report/companies_house_data/ret_made_up_date[. != '?']">
 	      <xsl:value-of select="/horus/company_report/companies_house_data/ret_made_up_date"/>
	    </xsl:if>
	  </td>
	</tr>
	<tr>
	  <td class="display-label">Account Type</td>
	  <td class="display-label">:</td>
	  <td>
	    <xsl:choose>
	      <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 0]">Not Available</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 1]">Full Accounts</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 2]">Small Company</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 3]">Medium Company</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 4]">Group Accounts</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 5]">Dormant</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 6]">Interim</xsl:when>
		  <xsl:when test="/horus/company_report/companies_house_data/accounts_type[. = 7]">Initial</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 0]">Not Available</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 1]">Full Accounts</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 2]">Small Company</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 3]">Medium Company</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 4]">Group Accounts</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 5]">Dormant</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 6]">Interim</xsl:when>
		  <xsl:when test="/horus/access_control/companies_house_data/accounts_type[. = 7]">Initial</xsl:when>
		  <xsl:otherwise>UNKNOWN TYPE</xsl:otherwise>
		</xsl:choose>
	  </td>
	</tr>
	<!--
	<xsl:if test="starts-with(/horus/access_control/companies_house_data/cro_number,'IR') and /horus/access_control/report_status != 0">
	  <tr><td><br /></td></tr>
	  <tr>
	    <td colspan="4" class="display-label">
		  The date of the latest filed accounts for Republic of Ireland companies is not supplied by Dublin Registry
	    </td>
	  </tr>
	</xsl:if>
	<xsl:if test="starts-with(/horus/company_report/companies_house_data/cro_number,'IR') and /horus/company_report/report_status != 0">
	  <tr><td><br /></td></tr>
	  <tr>
	    <td colspan="4" class="display-label">
		  The date of the latest filed accounts for Republic of Ireland companies is not supplied by Dublin Registry
	    </td>
	  </tr>
	</xsl:if>
	-->

	<tr valign="bottom">
		<td colspan="4" align="center">
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
<!-- BEGIN ProvideSupport.com Graphics Chat Button Code -->
        <div id="ciArRy" style="z-index:100;position:absolute"></div>
        <div id="scArRy" style="display:inline; text-align:center"></div>
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
	</div>	

</xsl:template>
</xsl:stylesheet>
