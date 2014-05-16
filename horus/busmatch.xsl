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
  
  <xsl:if test="boolean(/horus/search/business)">
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
	  <xsl:for-each select="/horus/search/business">
	    <tr>
		  <td class="search-results">
		    <a method="post" class="link1">
			  <xsl:if test="starts-with(id,'B') or starts-with(id,'NB')">
		        <xsl:attribute name="href"><xsl:value-of select="/horus/row/baseurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=nolibasic&amp;session=<xsl:value-of select="$SID"/>&amp;reference=<xsl:value-of select="id"/></xsl:attribute>
			  </xsl:if>
			  <xsl:if test="not(starts-with(id,'B')) and not(starts-with(id,'NB'))">
			    <xsl:attribute name="href"><xsl:value-of select="/horus/row/baseurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=cobasic&amp;session=<xsl:value-of select="$SID"/>&amp;reference=<xsl:value-of select="id"/></xsl:attribute>
			  </xsl:if>
		      <xsl:value-of select="id"/>
		    </a>
		  </td>
		  <td class="search-results"><xsl:value-of select="name"/></td>
		  <td nowrap="yes" class="search-results"><xsl:value-of select="business_status"/></td>
	    </tr>
		<tr>
          <td/>
	      <td class="search-results2">
            <xsl:value-of select="address/line_one"/>
	        <xsl:if test="address/line_two!=''">,
		      <xsl:value-of select="address/line_two"/>
            </xsl:if>
	        <xsl:if test="address/town!=''">,
		      <xsl:value-of select="address/town"/>
            </xsl:if>
	        <xsl:if test="address/postcode!=address/county">,
              <xsl:value-of select="address/postcode"/>
            </xsl:if>
	      </td>
        </tr>
	  </xsl:for-each>
	  <xsl:if test="not(boolean(/horus/search/next_search))">
	    <tr><td><br /></td></tr>
	    <tr><td colspan="2">No further matches found.</td></tr>
		<tr><td><br /></td></tr>
	  </xsl:if>
	  
	  <xsl:if test="not(boolean(/horus/search/next_search)) and boolean(horus/row/previous)">
	    <tr>
  		  <td colspan="2"><a class="link1" href="javascript:history.back()" method="post">Prev Page</a></td>
  	    </tr>
		<tr><td><br /></td></tr>
	  </xsl:if>
	  
	  <xsl:if test="/horus/search/next_search/donext[.='Y']">
	    <tr><td><br /></td></tr>
	    <tr>
  		  <xsl:if test="/horus/search/next_search/page[.>1]">
		    <td><a class="link1" href="javascript:history.back()" method="post">Prev Page</a></td>
		  </xsl:if>
		  <td>
		    <a class="link1" method="post">
		      <xsl:attribute name="href"><xsl:value-of select="/horus/row/baseurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=next_busmatch&amp;session=<xsl:value-of select="$SID"/>&amp;purpose_of_search=X<xsl:value-of select="/horus/search/next_search/page"/></xsl:attribute>
			  Next Page
		    </a>
		  </td>
  	    </tr>
	  </xsl:if>
	  <tr><td><br /></td></tr>
	</table>
  </xsl:if>
	
  <xsl:if test="not(boolean(/horus/search/business))">
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
