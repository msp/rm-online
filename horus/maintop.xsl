<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="maintop">
  <xsl:param name="sidemenu"/>
  <xsl:variable name="SID"><xsl:value-of select="/horus/@session"/></xsl:variable>
    
  <tr align="center" bgcolor="#CCCCCC"> 
    <td height="20" background="/ccards/common/images/lgrey.gif">
      <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><b>&#xA0;
		<xsl:choose>
		  <xsl:when test="$sidemenu='search' or not(boolean(/horus/row/service))">
		    <span class="link0">Search Options</span>
		  </xsl:when>
		  <xsl:otherwise>
		    <a title="Search Options" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=search&amp;session={$SID}">
		      <span class="link1">Search Options</span>
		    </a>
		  </xsl:otherwise>
		</xsl:choose>
	  &#xA0;</b></font>
	</td>
    <td width="1" background="/ccards/common/images/lgrey.gif">
	  <img src="/ccards/common/images/black.gif" width="1" height="10"/>
	</td>
	<td background="/ccards/common/images/lgrey.gif">
	  <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><b>&#xA0;
		<xsl:choose>
	      <xsl:when test="$sidemenu='search' or $sidemenu='busmatch' or not(boolean(/horus/row/reference))">
		    <span class="link0">Search Results</span>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:choose>
			  <xsl:when test="boolean(/horus/row/country)">
		        <a title="Search Results" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=intcomatch_results&amp;requestType=search&amp;companyName={/horus/row/search}&amp;reasonCode={/horus/row/reasoncode}&amp;region={/horus/row/region}&amp;country={/horus/row/country}&amp;session={$SID}">
		          <span class="link1">Search Results</span>
		        </a>
			  </xsl:when>
			  <xsl:when test="boolean(/horus/row/surname)">
		        <a title="Search Results" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=dirmatch_results&amp;session={$SID}">
		          <span class="link1">Search Results</span>
		        </a>
			  </xsl:when>
			  <xsl:otherwise>
			    <a title="Search Results" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=busmatch_results&amp;session={$SID}">
		          <span class="link1">Search Results</span>
		        </a>
			  </xsl:otherwise>
			</xsl:choose>
		  </xsl:otherwise>
		</xsl:choose>
	  &#xA0;</b></font>
	</td>
    <td width="1" background="/ccards/common/images/lgrey.gif">
	  <img src="/ccards/common/images/black.gif" width="1" height="10"/>
	</td>
	<td background="/ccards/common/images/lgrey.gif">
	  <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><b>&#xA0;
		<xsl:choose>
	      <xsl:when test="$sidemenu='search' or $sidemenu='busmatch' or $sidemenu='cobasic' or not(boolean(/horus/row/reference))">
		    <span class="link0">Business Services</span>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:choose>
		      <xsl:when test="boolean(/horus/row/country)">
		        <a title="Search Results" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=intcobasic&amp;requestType=product&amp;companyID={/horus/row/reference}&amp;companyName={/horus/row/requestname}&amp;session={$SID}">
		          <span class="link1">Business Services</span>
		        </a>
			  </xsl:when>
			  <xsl:when test="boolean(/horus/row/surname) and /horus/row/report='O01'">
		        <a title="Search Results" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=dirbasic&amp;surname={/horus/row/surname}&amp;forename={/horus/row/forename}&amp;line_one={/horus/row/line_one}&amp;line_two={/horus/row/line_two}&amp;town={/horus/row/town}&amp;county={/horus/row/county}&amp;postcode={/horus/row/postcode}&amp;date_of_birth={/horus/row/date_of_birth}&amp;reference={/horus/row/reference}&amp;session={$SID}">
		          <span class="link1">Director Services</span>
		        </a>
			  </xsl:when>
			  <xsl:when test="boolean(/horus/row/company_report/general_information)">
		        <a title="Business Services" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=cobasic&amp;reference={/horus/row/reference}&amp;session={$SID}">
		          <span class="link1">Business Services</span>
		        </a>
			  </xsl:when>
			  <xsl:otherwise>
		        <a title="Business Services" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=cobasic&amp;reference={/horus/row/reference}&amp;session={$SID}">
		          <span class="link1">Business Services</span>
		        </a>
			  </xsl:otherwise>
			</xsl:choose>
		  </xsl:otherwise>
		</xsl:choose>
	  &#xA0;</b></font>
	</td>
    <td width="1" background="/ccards/common/images/lgrey.gif">
	  <img src="/ccards/common/images/black.gif" width="1" height="10"/>
	</td>
	<td background="/ccards/common/images/lgrey.gif">
	  <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><b>&#xA0;
		<xsl:choose>
	      <xsl:when test="$sidemenu='search' or $sidemenu='busmatch' or $sidemenu='cobasic' or $sidemenu='images' or not(boolean(/horus/row/imagerequest))">
		    <span class="link0">Images</span>
		  </xsl:when>
		  <xsl:when test="starts-with(/horus/row/report,'IE')">
		    <a title="Images" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=ie_cobasic&amp;session={$SID}&amp;reference={/horus/row/reference}&amp;ie_company={substring-after(/horus/row/reference, 0)}&amp;requestname={/horus/row/requestname}">
	          <span class="link1">Images</span>
	        </a>
		  </xsl:when>
		  <xsl:otherwise>
		    <a title="Images" class="link1" href="{/horus/row/baseurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=images&amp;session={$SID}&amp;reptype={/horus/row/report}&amp;requestname={/horus/row/requestname}&amp;reference={/horus/row/reference}&amp;Request=FilingHistory&amp;CompanyNumber={/horus/row/reference}">
		      <span class="link1">Images</span>
		    </a>
		  </xsl:otherwise>
		</xsl:choose>
		&#xA0;</b></font>
	  </td>
      <td background="/ccards/common/images/lgrey.gif">&#xA0;</td>
    </tr>
    <tr> 
      <td height="1" colspan="12" bgcolor="#850041" background="/ccards/common/images/850041.gif">
	    <img src="/ccards/common/images/trans.gif" width="100%" height="1"/>
	  </td>
    </tr>

</xsl:template>
</xsl:stylesheet>
