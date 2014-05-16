<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:include href="http://localhost/ccards/rm008/includes/mainform.xsl"/>
<!--
<xsl:include href="http://localhost/ccards/common/includes/service_pay.xsl"/>
-->
<xsl:include href="http://localhost/ccards/common/includes/service_pay_sage.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="main">
	<xsl:with-param name="title">Secure Service Payment</xsl:with-param>
	<xsl:with-param name="onload"></xsl:with-param>
	<xsl:with-param name="sidemenu">service_pay</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="body">
  
  <xsl:call-template name="service_pay"/>

</xsl:template>
</xsl:stylesheet>
