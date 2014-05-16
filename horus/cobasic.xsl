<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:include href="mainform_custom.xsl"/>
<xsl:include href="cobasic_custom.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="main">
	<xsl:with-param name="title">Business services</xsl:with-param>
    <xsl:with-param name="onload"></xsl:with-param>
	<xsl:with-param name="sidemenu">cobasic</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="body">

  <xsl:call-template name="cobasic"/>

</xsl:template>
</xsl:stylesheet>  
