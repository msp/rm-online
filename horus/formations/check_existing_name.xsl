<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gh="http://www.govtalk.gov.uk/schemas/govtalk/govtalkheader"
  xmlns:ns="http://xmlgw.companieshouse.gov.uk/v1-0/schema"
  xmlns:url="http://www.jclark.com/xt/java/java.net.URLEncoder">
<xsl:output method="html"/>

<xsl:template name="check_existing_name">
 <xsl:param name="COMPANY_NAME"/>
 <xsl:param name="SEARCH_DATA_NAME"/>
 <xsl:param name="REGISTERED"/>

<script language="JavaScript">

  <xsl:comment><![CDATA[

  function setCheckName(myStatus) {
		myObj= document.getElementById("checkName");
		myObj.value = myStatus;
  }

  function getCheckName() {
		myObj= document.getElementById("checkName");
		return myObj.value;
  }

	//]]></xsl:comment>
</script>

	<input type="hidden" name="checkName" id="checkName"/>

	<xsl:variable name="trimSearchData">
		<xsl:if test="contains($SEARCH_DATA_NAME, 'LIMITED')">
			<xsl:value-of select="substring($SEARCH_DATA_NAME,1,number(string-length($SEARCH_DATA_NAME))-8))"/>
		</xsl:if>
		<xsl:if test="contains($SEARCH_DATA_NAME, 'LLP') or contains($SEARCH_DATA_NAME, 'PLC') or contains($SEARCH_DATA_NAME, 'LTD')">
			<xsl:value-of select="substring($SEARCH_DATA_NAME,1,number(string-length($SEARCH_DATA_NAME))-4))"/>
		</xsl:if>
	</xsl:variable>
	
	<xsl:for-each select="//ns:NameSearch/ns:CoSearchItem[ns:CompanyName]">
		<p>
			<xsl:variable name="trimCompanyName">
			<xsl:if test="contains(ns:CompanyName,'LIMITED')">
				<xsl:value-of select="substring(ns:CompanyName,1 ,number(string-length(ns:CompanyName))-8))"/>
			</xsl:if>
			<xsl:if test="contains(ns:CompanyName, 'LLP') or contains(ns:CompanyName, 'PLC') or contains(ns:CompanyName, 'LTD')">
				<xsl:value-of select="substring(ns:CompanyName,1 ,number(string-length(ns:CompanyName))-4))"/>
			</xsl:if>
			</xsl:variable>
	
			<xsl:if test="$trimSearchData = $trimCompanyName">

				<script language="JavaScript">
  				setCheckName("existing");
				</script>
				<p>Unfortunately <xsl:value-of select="$SEARCH_DATA_NAME"/> has already been registered at Companies House.
				<a href="javascript:doCoSearch('{$SEARCH_DATA_NAME}')"> Click here</a> for full details
				</p>  
				<p>Please check the availability of an alternative company name using the search facility below.</p>
			</xsl:if>
		</p>
	</xsl:for-each>	
			

	

		<div id="showExist" name ="showExist" display="inline">
	<xsl:variable name="trimCompanyName">
		<xsl:if test="contains($COMPANY_NAME, 'LIMITED')">
			<xsl:value-of select="substring($COMPANY_NAME,1,number(string-length($COMPANY_NAME))-8))"/>
		</xsl:if>
		<xsl:if test="contains($COMPANY_NAME, 'LLP') or contains($COMPANY_NAME, 'PLC') or contains($COMPANY_NAME, 'LTD')">
			<xsl:value-of select="substring($COMPANY_NAME,1,number(string-length($COMPANY_NAME))-4))"/>
		</xsl:if>
	</xsl:variable>

	<xsl:if test="$trimSearchData = $trimCompanyName">
		<p>Unfortunately <xsl:value-of select="$COMPANY_NAME"/> has already been registered at Companies House.
		<a href="javascript:doCoSearch('{//ns:NameSearch/ns:CoSearchItem/ns:CompanyName}')"> Click here</a> for full details
		</p>  
		<p>Please check the availability of an alternative company name using the search facility below.</p>
	</xsl:if>

	<xsl:if test="$trimSearchData != $trimCompanyName">
	
	
		<p>The name <xsl:value-of select="$SEARCH_DATA_NAME"/> is similar to an existing live company (or companies) and may be rejected by Companies House unless you are authorised to act on behalf of the following: 
		</p>  
			
			<xsl:for-each select="//ns:NameSearch/ns:CoSearchItem[ns:CompanyName]">
				<p>
					<xsl:value-of select="ns:CompanyName"/><xsl:text>  - </xsl:text> <a href="javascript:doCoSearch('{ns:CompanyName}')"> ...click for more detail?</a>
				</p>
			</xsl:for-each>	

			<xsl:if test="$REGISTERED = 'TRUE'">
				<p>If you are authorised to act on behalf of (any of) the above company/companies and would like to proceed,  
				<a href="/servlet/com.armadillo.online?service=einc&amp;function=cosearch_ch_registered&amp;Request=NameSearch&amp;SearchRows=1&amp;agent=rm001&amp;stylesheet=initial_new_registered.xsl&amp;compType={/horus/row/comptype}&amp;SearchData={/horus/row/searchdata}">click here.</a> 
				(note that you will need to provide documents proving you are eligible to act on behalf of the company)</p>
			</xsl:if>
			<xsl:if test="$REGISTERED = 'NAMECHANGE'">
				<p>If you are authorised to act on behalf of (any of) the above company/companies and would like to proceed,  
				<a href="/servlet/com.armadillo.online?service=einc&amp;function=namechange_match&amp;Request=NameAvailableSearch&amp;SearchRows=0&amp;docno={/horus/row/docno}&amp;compType={/horus/row/comptype}&amp;SearchData={/horus/row/searchdata}">click here.</a> 
				(note that you will need to provide documents proving you are eligible to act on behalf of the company)</p>
			</xsl:if>
			<xsl:if test="$REGISTERED != 'TRUE' and $REGISTERED! = 'NAMECHANGE'">
				<p>If you are authorised to act on behalf of (any of) the above company/companies and would like to proceed, <a href="/servlet/com.armadillo.online?service=einc&amp;function=cosearch_ch&amp;Request=NameSearch&amp;SearchRows=1&amp;agent=rm001&amp;stylesheet=initial_match.xsl&amp;compType={/horus/row/comptype}&amp;SearchData={$SEARCH_DATA_NAME}">click here.</a> (note that you will need to provide documents proving you are eligible to act on behalf of the company)</p>
			</xsl:if>
			
			<p>Alternatively, please check the availability of an different company name using the search facility below.</p>
			<xsl:call-template name="sensitive_name_check"><xsl:with-param name="COMPANY_NAME"><xsl:value-of select="$SEARCH_DATA_NAME"/></xsl:with-param></xsl:call-template>
	</xsl:if>

		</div>
	<script language="JavaScript">
    showHide("showExist", getCheckName() != 'existing');
	</script>
			
</xsl:template>
</xsl:stylesheet>
			  
