<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="maintop_custom.xsl"/>

<xsl:template name="main">
<xsl:param name="title"/>
<xsl:param name="onload"/>
<xsl:param name="sidemenu"/>
<xsl:variable name="SID"><xsl:value-of select="/horus/@session"/></xsl:variable>

<html>
  <head>
	<title>Company Information</title>
	
	<!--  Images require some special processes -->
  <xsl:if test="$onload='imagelist'">
    <link rel="stylesheet" href="/jquery/ui/1.10.2/themes/smoothness/jquery-ui.css" />

    <style type="text/css">

      .ui-tabs-nav li {
        margin-top: 0.6em;
        font-size: 70%;
      }
      .ui-tabs-nav li.ui-tabs-selected,
      .ui-tabs-nav li.ui-state-active {
        margin-top: 0em;
        font-size: 90%;
      }
      .ui-tabs td  {
        vertical-align:top;
        font:9pt Arial,Helvetica,sans-serif !important;
      }
      .ui-tabs th  {
        vertical-align:top;
        font:11pt Arial,Helvetica,sans-serif !important;
      }
			.righter {
				text-align: right;
			}

    </style>

    <script type="text/javascript" src="/5/jquery-1.9.1.min.js"> <xsl:text> </xsl:text> </script>
    <script src="/jquery/ui/1.10.2/jquery-ui.js">  <xsl:text> </xsl:text> </script>
    <script type="text/javascript" charset="UTF-8" src="/5/imagetab_cards.js"> <xsl:text> </xsl:text> </script>

  </xsl:if>

	<link rel="stylesheet" type="text/css" href="/ccards/common/styles/text.css"/>
	<meta name="keywords" content="Company Information,company formations, trade mark registrations,armadillo,financial analysis,Credit Checks,Reports,search,company search,Online,database,rmonline,annual reports,rmtm,rmcs,rmic,data,rmgroup,trademark search,accounts,business intelligence,limited company formations,investigation,corporation,research,press release,incorporation,registration,offshore,trust,registrars,accountants,solicitors,company law,raymond morris,rm group,public limited company,international companies,ltd,inc,enterprise,organization,organisation,legal services,firm,partnership,trade,profession,private limited,companies house,documents,annual report,latest accounts,cs1,cs2,cs3,due diligence search,insolvency practitioners,corporate recovery,leasing,mortgage,conveyance,audit,secretarial,registered office,annual returns,domain name,web site design,acquisition,corporate finance,friendly society,overseas data,patents,patent, microfiche,library services,lis,cig,federation"/>
    <meta name="description" content="aRMadillo the most comprehensive Company Information, Company Formation and Trade Mark Registration tool. Company information, reports,directors information,Credit Checks,report and accounts and formations,rm"/>
  </head>

  <body bgcolor="#FFFFFF" text="#333333">
    <!-- START OF THE TOP OF THE PAGE -->
	
    <!-- END OF THE TOP OF THE PAGE -->
	
	<table align="center" width="602" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td bgcolor="#850041" width="1" background="/ccards/common/images/850041.gif">
		  <img src="/ccards/common/images/trans.gif" width="1" height="100%"/>
		</td>
        <td> 
					<!--
          <table align="center" width="600" height="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#999999" style="height:100%;">
					-->
          <table align="center" width="600" border="0" cellspacing="0" cellpadding="0" bordercolor="#999999" style="height:100%;">
            <tr> 
              <td height="1" colspan="12" bgcolor="#850041" background="/ccards/common/images/850041.gif">
			    <img src="/ccards/common/images/trans.gif" width="100%" height="1"/>
			  </td>
            </tr>
            <tr valign="top"> 
              <td height="80" colspan="12" bgcolor="#99FFFF">
			    <a name="#"><img src="http://www.rmonline.com/ccards/common/images/banner.gif" width="600" height="80" border="0"/></a>
			  </td>
            </tr>
            <tr> 
              <td height="1" colspan="12" bgcolor="#850041" background="/ccards/common/images/850041.gif">
			    <img src="/ccards/common/images/trans.gif" width="100%" height="1"/>
		      </td>
            </tr>
            <!-- START TOP LINKS -->
            <xsl:call-template name="maintop">
			  <xsl:with-param name="sidemenu"><xsl:value-of select="$sidemenu"/></xsl:with-param>
			</xsl:call-template>
			<!-- END TOP LINKS -->
			<tr valign="top"> 
              <td colspan="12">
			    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                  <tr> 
                    <td rowspan="5" width="20">&#xA0;</td>
                    <td colspan="5" height="15"></td>
                    <td rowspan="5" width="20">&#xA0;</td>
                  </tr>
                  <tr align="left" valign="top"> 
                    <td colspan="3" rowspan="3">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr valign="middle"> 
                          <td height="20" bgcolor="#CCCCCC" width="5">&#xA0;</td>
                          <td bgcolor="#CCCCCC" colspan="2" align="center" class="texthead">
	                        <xsl:value-of select="$title"/>
	                      </td>
                          <td>&#xA0;</td>
                        </tr>
                        <tr valign="top">
	                      <td rowspan="2" style="border-bottom:1px solid #CCCCCC;border-left:1px solid #CCCCCC">&#xA0;</td>
                          <td rowspan="2" style="border-bottom:1px solid #CCCCCC">&#xA0;</td>
						  <xsl:choose>
						    <xsl:when test="$onload='int'">
							  <td width="100%" rowspan="2" style="border-bottom:1px solid #CCCCCC;border-right:1px solid #CCCCCC">
			                    <xsl:call-template name="body"/>
					          </td>
							</xsl:when>
							<xsl:otherwise>
                              <td width="100%" rowspan="2" align="center" style="border-bottom:1px solid #CCCCCC;border-right:1px solid #CCCCCC">
			                    <xsl:call-template name="body"/>
					          </td>
							</xsl:otherwise>
						  </xsl:choose>
                          <td rowspan="2">&#xA0;</td>
                        </tr>
                      </table>
				    </td>
				  </tr>
				</table>
			  </td>
			</tr> 
      <tr valign="top"> 
        <td colspan="12"> 
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
                    <td width="20" valign="bottom" align="left">&#xA0;</td>
					<td class="greybody" valign="bottom" align="left">
					  <a class="link1" onclick="popup = window.open('/common/samplescd.htm', 'PopupPage', 'height=450,width=640,scrollbars=yes,resizable=yes'); return false" href="/common/samplescd.htm" target="_blank">Samples</a>
					  &#xA0;&#xA0;
                      <a class="link1" onclick="popup = window.open('/common/faqcd.htm', 'PopupPage', 'height=450,width=640,scrollbars=yes,resizable=yes'); return false" href="/common/faqcd.htm" target="_blank">Faq</a>
					  &#xA0;&#xA0;
                      <a class="link1" onclick="popup = window.open('/common/pricescd.htm', 'PopupPage', 'height=450,width=640,scrollbars=yes,resizable=yes'); return false" href="/common/pricescd.htm" target="_blank">Prices</a>
					  &#xA0;&#xA0;
                      <a class="link1" onclick="popup = window.open('/common/onlineterms.htm', 'PopupPage', 'height=450,width=640,scrollbars=yes,resizable=yes'); return false" href="/common/onlineterms.htm" target="_blank">Terms</a>
					  &#xA0;&#xA0;
                      <a class="link1" onclick="popup = window.open('/common/contactcd.htm', 'PopupPage', 'height=450,width=640,scrollbars=yes,resizable=yes'); return false" target="_blank" href="/common/contactcd.htm">Contact</a>
					</td>
					<td class="greybody" valign="bottom">&#xA0;</td>
                  </tr>
                  <tr> 
                    <td align="left" valign="bottom" width="20" rowspan="2"></td>
                    <td align="left" valign="bottom" class="greybody">
					  &#169; 1997-2001 RM&#174; Online Ltd.
					</td>
                    <td valign="bottom" rowspan="2" class="greybody">
					    <img src="/ccards/common/images/rmlogo.gif" width="28" height="24" border="0" alt="RM&#174; Online Ltd"/>
					</td>
                  </tr>
                  <tr> 
                    <td align="right" valign="bottom" class="greybody">
				      RM&#174; Online. is a member of the RM&#174; Group of companies.
					</td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
        <td bgcolor="#850041" width="1" background="/ccards/common/images/850041.gif">
		</td>
      </tr>
	  <tr> 
        <td height="1" colspan="12" bgcolor="#850041" background="/ccards/common/images/850041.gif">
          <img src="/ccards/common/images/trans.gif" width="100%" height="1"/>
        </td>
      </tr>
    </table>
	
	<!-- START OF THE BOTTOM OF THE PAGE -->
	
	<!-- END OF THE BOTTOM OF THE PAGE -->
	
    <map name="Map">
	  <area shape="poly" coords="-1,60" href="#"/>
	  <area shape="rect" coords="38,9,117,36" href="/" alt="click here for the aRMadillo Home Page" title="click here for the aRMadillo Home Page"/>
	  <area shape="rect" coords="3,35,244,75" href="/" alt="click here for the aRMadillo Home Page" title="click here for the aRMadillo Home Page"/>
	</map>
  </body>
</html>

</xsl:template>
</xsl:stylesheet>
