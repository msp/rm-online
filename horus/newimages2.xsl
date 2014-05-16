<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="http://localhost/ccards/common/includes/vat.xsl"/>
<xsl:include href="http://localhost/ccards/common/includes/replace.xsl"/>


<xsl:template name="newimages">
 <xsl:variable name="CONAME">
  <xsl:call-template name="replace-string">
   <xsl:with-param name="text" select="/horus/company_report/companies_house_data/name"/>
   <xsl:with-param name="replace" select="'&amp;'"/>
   <xsl:with-param name="with" select="'%26'"/>
  </xsl:call-template>
 </xsl:variable>

	<table>

    <input id="function"    name="function"     value="login" type="hidden"/>
    <input id="service"     name="service"      value="{/horus/row/service}" type="hidden"/>
    <input id="company"     name="company"      value="{/horus/company_report/companies_house_data/cro_number}" type="hidden"/>
    <input id="companyName" name="companyName"  value="{/horus/company_report/companies_house_data/name}" type="hidden"/>
    <input id="clientRef"   name="clientRef"    value="{/horus/row/clientref}" type="hidden"/>
    <input id="reptype"     name="reptype"      value="{/horus/row/report}" type="hidden"/>
    <input id="requestname" name="requestname"  value="{/horus/row/requestname}" type="hidden"/>
    <input id="reference" 	name="reference"  	value="{identity}" type="hidden"/>
    <input id="imageRequest" 	name="imageRequest" value="REP,IMG,{identity},{type},{date}" type="hidden"/>

    <tr align="center">
        <tr><td class="col-label">Company Number : <xsl:value-of select="/horus/company_report/companies_house_data/cro_number"/></td></tr>
        <tr><td class="col-label">Company Name  : <xsl:value-of select="/horus/company_report/companies_house_data/name"/></td></tr>
    </tr>
    <tr>
      <td><br/>Document types are grouped within tabs - select a different tab to see documents of that type.<br/>
      You can select more than one document, but please note that you will be charged for each document that you select.<br/>

			<br/>Each document costs
    		<xsl:if test="boolean(/horus/row/campaign)">
      		<b>&#163;<xsl:value-of select="format-number(number(/horus/row/campaignprice),'##0.00')"/> (+ VAT @ <xsl:call-template name="show_vat_rate"/>% = &#163;<xsl:value-of select="format-number(number(/horus/row/campaignvat),'##0.00')"/>)</b>
      		<i class="col-label"> Discounted Price</i>
    		</xsl:if>
    		<xsl:if test="not(boolean(/horus/row/campaign))">
      		<b>&#163;<xsl:value-of select="format-number(number(/horus/row/price),'##0.00')"/> (+ VAT @ <xsl:call-template name="show_vat_rate"/>% = &#163;<xsl:value-of select="format-number(number(/horus/row/vat),'##0.00')"/>)</b>
    		</xsl:if>
			.
		</td>
    </tr>
    <tr><td><br/></td></tr>

    <tr valign="footer">
      <td>
        <div id="downloadStatus">
          <br/>
          <br/>
          <center>
            <img src="/5/ajax-loader.gif" height="10" alt="Loading image list"/>
            <br/>
            Retrieving Companies House image list ...
          </center>
        </div>
        <div id="docTab" class="ui-tabs">
          <ul id="tabList1"/>
        </div>
      </td>
    </tr>
  </table>
    
</xsl:template>
</xsl:stylesheet>
