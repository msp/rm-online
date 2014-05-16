<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:include href="tmp_mainform.xsl"/>
<xsl:include href="http://localhost/ccards/common/includes/newimages2.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="main">
    <xsl:with-param name="title">Online Accounts and Annual Returns</xsl:with-param>
    <xsl:with-param name="onload">imagelist</xsl:with-param>
	<xsl:with-param name="sidemenu">images</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="body">
  <xsl:call-template name="newimages"/>
</xsl:template>
</xsl:stylesheet>
