<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fn="http://www.w3.org/2005/xpath-functions">
<xsl:output method="html"/>


<xsl:template name="sensitive_name_check">
	<xsl:param name="COMPANY_NAME"/>
	<xsl:if test="contains($COMPANY_NAME, 'GROUP')">
		<xsl:call-template name="sensitive_word_message"><xsl:with-param name="SENSITIVE_WORD">group</xsl:with-param></xsl:call-template>
	</xsl:if> 
	<xsl:if test="contains($COMPANY_NAME, 'HOLDING')">
		<xsl:call-template name="sensitive_word_message"><xsl:with-param name="SENSITIVE_WORD">holding</xsl:with-param></xsl:call-template>
	</xsl:if> 
	<xsl:if test="contains($COMPANY_NAME, 'INTERNATIONAL')">
		<xsl:call-template name="sensitive_word_message"><xsl:with-param name="SENSITIVE_WORD">international</xsl:with-param></xsl:call-template>
	</xsl:if> 
</xsl:template>

<xsl:template name="sensitive_word_message">
	<xsl:param name="SENSITIVE_WORD"/>
	<p class="pagetext" align="left"><b>Please note </b>the company name you have chosen contains the sensitive word - <b><xsl:value-of select="$SENSITIVE_WORD"/></b> - that may need special clearance from Companies House. If you wish to proceed please do so and one of our staff will contact you with the requirements. Otherwise you may change the name by going <a class="link1" href="javascript:history.back()">back to the search page</a>.</p>
</xsl:template>


<xsl:template name="sensitive_name_variables">
	<xsl:param name="COMPANY_NAME"/>
	<xsl:if test="contains($COMPANY_NAME, 'GROUP')">
		<xsl:call-template name="get_sensitive_word_variables"><xsl:with-param name="SENSITIVE_WORD">group</xsl:with-param></xsl:call-template>
	</xsl:if> 
	<xsl:if test="contains($COMPANY_NAME, 'HOLDING')">
		<xsl:call-template name="get_sensitive_word_variables"><xsl:with-param name="SENSITIVE_WORD">holding</xsl:with-param></xsl:call-template>
	</xsl:if> 
	<xsl:if test="contains($COMPANY_NAME, 'INTERNATIONAL')">
		<xsl:call-template name="get_sensitive_word_variables"><xsl:with-param name="SENSITIVE_WORD">international</xsl:with-param></xsl:call-template>
	</xsl:if> 
</xsl:template>

<xsl:template name="get_sensitive_word_variables">
	<xsl:param name="SENSITIVE_WORD"/>
	<input type="hidden" name="{$SENSITIVE_WORD}" value="{$SENSITIVE_WORD}"/>
</xsl:template>
</xsl:stylesheet>

	
