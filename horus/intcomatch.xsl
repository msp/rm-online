<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:include href="http://localhost/ccards/rm008/includes/mainform.xsl"/>
<xsl:include href="http://localhost/ccards/common/includes/intcomatch.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="main">
	<xsl:with-param name="title">Search Results</xsl:with-param>
	<xsl:with-param name="onload"></xsl:with-param>
	<xsl:with-param name="sidemenu">busmatch</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="body">

  <xsl:call-template name="results"/>

</xsl:template>
</xsl:stylesheet>
