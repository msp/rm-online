<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:include href="http://localhost/ccards/rm008/includes/mainform.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="main">
	<xsl:with-param name="title">Search Results</xsl:with-param>
	<xsl:with-param name="onload"></xsl:with-param>
	<xsl:with-param name="sidemenu">busmatch</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="body">
  <xsl:variable name="SID"><xsl:value-of select="/horus/@session"/></xsl:variable>
  
  <xsl:if test="boolean(/horus/row/company)">
    <table width="100%">
	  <tr>
	    <td colspan="3">
		  <p class="page-text">The following UK Companies match the criteria that 
		  you entered. Click the Reg No for free basic data and a choice of instant 
		  reports.</p>
		</td>
	  </tr>
	  <tr>
	    <td>
		  <img border="0" height="10" src="/ccards/common/images/spacer.gif" width="3"/>
	    </td>
	  </tr>
	  <tr>
	    <td width="65" class="col-label">Reg No.</td>
		<td class="col-label">Name and Address</td>
		<td class="col-label">Status</td>
	  </tr>
	  <xsl:for-each select="/horus/row[company]">
	    <tr>
		  <td class="search-results">
		    <a method="post" class="link1">
			  <xsl:if test="not(starts-with(company,'B')) and not(starts-with(company,'NB'))">
			    <xsl:attribute name="href"><xsl:value-of select="/horus/row/baseurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=cobasic&amp;session=<xsl:value-of select="$SID"/>&amp;reference=<xsl:value-of select="company"/></xsl:attribute>
			  </xsl:if>
		      <xsl:value-of select="company"/>
		    </a>
		  </td>
		  <td class="search-results"><xsl:value-of select="name"/></td>
		  <td nowrap="yes" class="search-results">
				<xsl:if test="liquidationdate != '?'">Company in Liquidation</xsl:if>
				<xsl:if test="administrationdate != '?'">Company in Administration</xsl:if>
			</td>
	    </tr>
		<tr>
          <td/>
	      <td class="search-results2">
            <xsl:value-of select="addressline1"/>
	        <xsl:if test="addressline2!=''">,
		      <xsl:value-of select="addressline2"/>
            </xsl:if>
	        <xsl:if test="addressline3!=''">,
		      <xsl:value-of select="addressline3"/>
            </xsl:if>
	        <xsl:if test="addressline4!=''">,
		      <xsl:value-of select="addressline4"/>
            </xsl:if>
	        <xsl:if test="addressline4 != postcode">,
              <xsl:value-of select="postcode"/>
            </xsl:if>
	      </td>
        </tr>
	  </xsl:for-each>
	    <tr><td><br /></td></tr>
	    <tr><td colspan="2">No further matches found.</td></tr>
		<tr><td><br /></td></tr>
	  
	  <tr><td><br /></td></tr>
	</table>
  </xsl:if>
	
  <xsl:if test="not(boolean(/horus/row/company))">
	<table width="100%">
	  <tr>
	    <td width="70" class="col-label">Id</td>
		<td class="col-label">Name and Adress</td>
		<td class="col-label">Status</td>
	  </tr>
	  <tr><td colspan="2"><h4> No Matches found!!</h4></td></tr>
	</table>
    <p>We were unable to find a match on the database for your specified company 
	   name. We suggest you try again using a <b>shorter</b> search string. 
    </p>
    <p/>
  </xsl:if>
  
</xsl:template>
</xsl:stylesheet>
