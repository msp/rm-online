<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="busprofile_custom.xsl"/>
<xsl:include href="http://localhost/ccards/common/includes/vat.xsl"/>

<xsl:template name="cobasic">
  <xsl:variable name="SID"><xsl:value-of select="/horus/@session"/></xsl:variable>
  <xsl:variable name="clientID"><xsl:value-of select="substring-before(/horus/access_control/@session,',')"/></xsl:variable>
  
  <xsl:if test="not(boolean(/horus/row/reference))">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
	  <td>
	    <p class="page-text"><br/>
		Due to a restart of our server your request could not be made. Please return
		to the 
		<a title="Search Options" class="link1">
		  <xsl:attribute name="href"><xsl:value-of select="/horus/row/baseurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=search&amp;session=<xsl:value-of select="$SID"/></xsl:attribute>
		  Search Options
		</a> and start again. 
		</p>
	  </td>
	</tr>
  </table>
  <br/>
  </xsl:if>
  <xsl:if test="boolean(/horus/row/reference)">
  <xsl:if test="/horus/access_control/access_type='F'">
    <br /><br />
    <h3>Notice: Online information on foreign companies is not held.</h3>
	<br /><br /><br /><br />
  </xsl:if>
  
  <xsl:if test="/horus/access_control/access_type!='F'">
    <table width="100%" >
	  <tr>
	    <td colspan="2"><p class="page-text"></p></td>
	  </tr>
	  <tr>
	    <td>
		  <img border="0" height="10" src="/ccards/common/images/spacer.gif" width="2"/>
	    </td>
	  </tr>
	  <tr>
	    <td valign="top">
		  <xsl:call-template name="busprofile"/>
		</td>
		<td valign="top">
		  <!-- table width="100%" bgcolor="#c7e0ff" border="0" -->
			<div style="height:600;">
		  <table width="100%" bgcolor="#FFFFFF" style="height:600;">
		    <tr><td align="center" valign="top" colspan="3" class="success" bgcolor="c7e0ff" style="height:25px; border:1"><font size="3"><b>Services available for this company</b></font></td></tr>
				<tr>
	          <td colspan="2" bgcolor="#FFFFFF" style="height:1px;">
		        <img border="0" height="2" src="/ccards/common/images/spacer.gif" width="3"/>
	          </td>
	      </tr>
				<!--
				<tr>
	          <td colspan="2" bgcolor="#FFFFFF">
		        <img border="0" height="10" src="/ccards/common/images/spacer.gif" width="3"/>
	          </td>
	      </tr>
		    <tr><td border="0" bgcolor="#FFFFFF" colspan="3"></td></tr>
				-->
			<xsl:if test="/horus/access_control/report_status = 3 and /horus/access_control/dissolved = 'N' and /horus/access_control/naf_type = 0">
			<tr>
			  <td colspan="2">
			    There is currently no report available for this company. If you
				wish to order a report please contact our Helpdesk on +44 (0) 207 729 1234
			  </td>
			</tr>
			</xsl:if>

			<!-- Companies House Images -->
	    <xsl:for-each select="/horus/row[report='LIM']">
	    <tr >
      	<td colspan="3" bgcolor="#c7e0ff">
						<xsl:if test="not(starts-with(/horus/access_control/companies_house_data/cro_number, 'I'))"> 
					  <a class="link1">
			        <xsl:attribute name="href"><xsl:value-of select="/horus/row/baseurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=images&amp;reptype=<xsl:value-of select="report"/>&amp;requestname=<xsl:value-of select="/horus/access_control/companies_house_data/name"/>&amp;reference=<xsl:value-of select="/horus/access_control/companies_house_data/cro_number"/>&amp;Request=FilingHistory&amp;CompanyNumber=<xsl:value-of select="/horus/access_control/companies_house_data/cro_number"/>&amp;stylesheet=images_tmp.xsl</xsl:attribute>
							<font size="2"> 
							<xsl:value-of select="description"/>
							</font>	
            </a> 
						<p>Choose from all the official documents available at Companies House. Accounts, annual return, registered office, directors, shareholders, Memorandum and Articles of Association, mortgage register, certificates and more.</p>
					  
						<font size="5" color="red">
						<div style="float:left; width:15%;">
					  <xsl:if test="boolean(/horus/row[campaignreport='LIM'])">
					    <xsl:for-each select="/horus/row[campaignreport='LIM']">
					    &#163;<xsl:value-of select="format-number(number(campaignprice),'##0.00')"/> 
						<i class="col-label">Discounted Price</i>
						</xsl:for-each>
					  </xsl:if>
					  <xsl:if test="not(boolean(/horus/row[campaignreport='LIM']))">
								<xsl:if test="price=0.5">50p</xsl:if>
								<xsl:if test="not(price=0.5)">
					    	&#163;
								<xsl:value-of select="format-number(number(price),'##0.00')"/> 
								</xsl:if>
					  </xsl:if>
						</div>
						</font>
		        </xsl:if>
						<div style="text-align: right">
					  <input type="button" value="Sample" class="link1" href="/common/image.tif" onClick="popup = window.open('/common/image.pdf', 'PopupPage', 'height=450,width=500,scrollbars=yes,resizable=yes'); return false" target="_blank"/>
						</div>
						<br/>

				</td>
			</tr>
			</xsl:for-each>
				<tr>
	          <td colspan="2" bgcolor="#FFFFFF" style="height:1px;">
		        <img border="0" height="1px" src="/ccards/common/images/spacer.gif" width="3"/>
	          </td>
	      </tr>
			
	    <tr bgcolor="#c7e0ff">
      <td bgcolor="#c7e0ff" colspan="3">
			<font size="3"><b>Reports</b></font><br/>
	    <xsl:for-each select="/horus/row[report='L07']">
		    	<xsl:if test="/horus/access_control/report_status = 0">
					  <a class="link1" href="{/horus/row/secureurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=login&amp;reptype={report}&amp;requestname={/horus/access_control/companies_house_data/name}&amp;reference={/horus/access_control/companies_house_data/cro_number}">
							<font size="2"> 
                        <xsl:value-of select="description"/>
							</font>
                      </a> 
						<p>Contains credit rating, analysts report, Companies House filings list, directors and shareholders in detail, activities, outstanding mortgage register,four years accounting extracts,ratios and industry sector average/comparison, adverse appointments and filings. <br/><i>Anti-money laundering compliant.</i></p>
						<font size="3" color="red"> 
						<div style="float:left; width:15%;">
					  <xsl:if test="boolean(/horus/row[campaignreport='L07'])">
					    <xsl:for-each select="/horus/row[campaignreport='L07']">
					      &#163;<xsl:value-of select="format-number(number(campaignprice),'##0.00')"/> 
					      <i class="col-label">Discounted Price</i>
					    </xsl:for-each>
					  </xsl:if>
					  <xsl:if test="not(boolean(/horus/row[campaignreport='L07']))">
					    &#163;<xsl:value-of select="format-number(number(price),'##0.00')"/> 
					  </xsl:if>
						</div>
						</font>
		     	</xsl:if>
					<xsl:if test="/horus/access_control/report_status = 1 and /horus/access_control/dissolved = 'N'">
					  <a class="link1" href="{/horus/row/secureurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=login&amp;reptype={report}&amp;requestname={/horus/access_control/companies_house_data/name}&amp;reference={/horus/access_control/companies_house_data/cro_number}&amp;old=LFL">
							<font size="2"> 
                        View Old <xsl:value-of select="description"/>
							</font>
                      </a> 
						<p>Contains credit rating, analysts report, Companies House filings list, directors and shareholders in detail, activities, outstanding mortgage register,four years accounting extracts,ratios and industry sector average comparison, adverse appointments and filings. <br/><i>Anti-money laundering compliant.</i></p>
						<font size="3" color="red"> 
						<div style="float:left; width:15%;">
					  <xsl:if test="boolean(/horus/row[campaignreport='L07'])">
					  	<xsl:for-each select="/horus/row[campaignreport='L07']">
					  	  &#163;<xsl:value-of select="format-number(number(campaignprice),'##0.00')"/> 
						  	<i class="col-label">Discounted Price</i>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="not(boolean(/horus/row[campaignreport='L07']))">
					   	&#163;<xsl:value-of select="format-number(number(price),'##0.00')"/> 
					 	</xsl:if>
						</div>
						</font>
		     </xsl:if>
						<div style="text-align: right">
				      <xsl:if test="/horus/access_control/report_status = 0">
            <input type="button" value="Sample" class="link1" href="/common/frcas3sam1.htm" onClick="popup = window.open('/common/frcas3sam1.htm', 'PopupPage', 'height=450,width=500,scrollbars=yes,resizable=yes'); return false" target="_blank"/>
                </xsl:if>
          <xsl:if test="/horus/access_control/report_status = 1 and /horus/access_control/dissolved = 'N'">
            <input type="button" value="Sample" class="link1" href="/common/frcas3sam1.htm" onClick="popup = window.open('/common/frcas3sam1.htm', 'PopupPage', 'height=450,width=500,scrollbars=yes,resizable=yes'); return false" target="_blank" />
                </xsl:if>
						</div>
			
			</xsl:for-each>
			


	    <xsl:for-each select="/horus/row[report='L11']">
					<br/>
					<br/>
		      <xsl:if test="/horus/access_control/report_status = 0">
					  <a class="link1">
			            <xsl:attribute name="href"><xsl:value-of select="/horus/row/secureurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=login&amp;reptype=<xsl:value-of select="report"/>&amp;requestname=<xsl:value-of select="/horus/access_control/companies_house_data/name"/>&amp;reference=<xsl:value-of select="/horus/access_control/companies_house_data/cro_number"/></xsl:attribute>
							<font size="2"> 
                        <xsl:value-of select="description"/>
							</font>
                      </a> 
						<p>Credit rating, directors, activities, four years accounting extracts,ratios and industry sector average/comparison and 'vital signs'.
						<br/><i>Anti-money laundering compliant.</i></p>
						<font size="3" color="red"> 
						<div style="float:left; width:15%;">	
					  <xsl:if test="boolean(/horus/row[campaignreport='L11'])">
					    <xsl:for-each select="/horus/row[campaignreport='L11']">
					    &#163;<xsl:value-of select="format-number(number(campaignprice),'##0.00')"/> 
						<i class="col-label">Discounted Price</i>
						</xsl:for-each>
					  </xsl:if>
					  <xsl:if test="not(boolean(/horus/row[campaignreport='L11']))">
					    &#163;<xsl:value-of select="format-number(number(price),'##0.00')"/> 
					  </xsl:if>
						</div>
						</font>
		    	</xsl:if>
					<xsl:if test="/horus/access_control/report_status = 1 and /horus/access_control/dissolved = 'N'">
					  <a class="link1">
			            <xsl:attribute name="href"><xsl:value-of select="/horus/row/secureurl"/>/servlet/com.armadillo.online?service=<xsl:value-of select="/horus/row/service"/>&amp;function=login&amp;reptype=<xsl:value-of select="report"/>&amp;requestname=<xsl:value-of select="/horus/access_control/companies_house_data/name"/>&amp;reference=<xsl:value-of select="/horus/access_control/companies_house_data/cro_number"/>&amp;old=LSN</xsl:attribute>
							<font size="2"> 
                        View Old <xsl:value-of select="description"/>
							</font>
                      </a> 
						<p>Credit rating, directors, activities, four years accounting extracts,ratios and industry sector average/comparison and 'vital signs'.
						<br/><i>Anti-money laundering compliant.</i></p>
						<font size="3" color="red"> 
						<div style="float:left; width:15%;">	
					  <xsl:if test="boolean(/horus/row[campaignreport='L11'])">
					    <xsl:for-each select="/horus/row[campaignreport='L11']">
					    &#163;<xsl:value-of select="format-number(number(campaignprice),'##0.00')"/> 
						<i class="col-label">Discounted Price</i>
						</xsl:for-each>
					  </xsl:if>
					  <xsl:if test="not(boolean(/horus/row[campaignreport='L11']))">
					    &#163;<xsl:value-of select="format-number(number(price),'##0.00')"/> 
					  </xsl:if>
						</div>
						</font>
		      </xsl:if>
					<div style="text-align: right">
		      <xsl:if test="/horus/access_control/report_status = 0">
					  <input type="button" value="Sample" class="link1" href="/common/frcpsam1.htm" onClick="popup = window.open('/common/frcpsam1.htm', 'PopupPage', 'height=450,width=500,scrollbars=yes,resizable=yes'); return false" target="_blank"/>
		      </xsl:if>
					<xsl:if test="/horus/access_control/report_status = 1 and /horus/access_control/dissolved = 'N'">
					  <input type="button" value="Sample" class="link1" href="/common/frcpsam1.htm" onClick="popup = window.open('/common/frcpsam1.htm', 'PopupPage', 'height=450,width=500,scrollbars=yes,resizable=yes'); return false" target="_blank"/>
		            </xsl:if>
					
					</div>
			</xsl:for-each>

			
			<xsl:if test="not(starts-with(/horus/access_control/companies_house_data/cro_number, 'I')) and (boolean(/horus/row[report='CHA']))">
					<br/>
	        <xsl:for-each select="/horus/row[starts-with(report,'CHA')]">
			    <a class="link1" href="{/horus/row/secureurl}/servlet/com.armadillo.online?service={/horus/row/service}&amp;function=login&amp;reptype={report}&amp;requestname={/horus/access_control/companies_house_data/name}&amp;reference={/horus/access_control/companies_house_data/cro_number}">
							<font size="2"> 
				  <xsl:value-of select="description"/>
							</font>
          </a>
						<p>Credit rating, Company secretary and directors names, addresses,nationality, date of birth, occupation and access to list of current and previous directorships.</p>
						<font size="3" color="red"> 
						<div style="float:left; width:15%;">	
                &#163;<xsl:value-of select="format-number(number(price),'##0.00')"/> 
						</div>
						</font>
						
						<div style="text-align: right">
							<input type="button" value="Sample" class="link1" href="/common/ch_appoint.htm" onClick="popup = window.open('/common/ch_appoint.htm', 'PopupPage', 'height=450,width=500,scrollbars=yes,resizable=yes'); return false" target="_blank"/>
						<br/>
						<br/>
						<font color="grey" size="2">(All listed prices exclude VAT)</font>
						</div>
						
			</xsl:for-each>
			</xsl:if>

			

			</td> 
			</tr>				

			<xsl:if test="starts-with(/horus/access_control/companies_house_data/cro_number, 'I')"> 
			<xsl:if test="boolean(/horus/row[report='IE1']) or boolean(/horus/row[report='IE2'])">
			<tr bgcolor="#c7e0ff">
			  <td>
				<a class="link1" href="{/horus/row/secureurl}/servlet/com.armadillo.online?service={horus/row/service}&amp;function=ie_cobasic&amp;ie_company={substring-after(/horus/access_control/companies_house_data/cro_number,'IR')}&amp;reference={/horus/access_control/companies_house_data/cro_number}&amp;requestname={/horus/access_control/companies_house_data/name}">
				  Irish Companies House Documents (click for list and prices)
                </a>
			  </td>
			  <td></td>
			</tr>
			</xsl:if>
			</xsl:if>

		  </table>
			</div>

		</td>
	  </tr>
	  <tr>
	    <td class="page-text-bold" colspan="2">
		  <xsl:if test="/horus/access_control/irish_message = 'Y'">
		    The date of the latest filed accounts for Republic of Ireland companies 
			is not supplied by Dublin Registry.
		  </xsl:if>
		  <xsl:choose>
		    <xsl:when test="/horus/access_control/message_number = 1">
			  This report was generated from basic information filed at Companies House
			</xsl:when>
			<xsl:when test="/horus/access_control/message_number = 2">
			  Please note that this company is dissolved and as such no longer exists as a legal entity
			</xsl:when>
			<xsl:when test="/horus/access_control/message_number = 3 or /horus/access_control/message_number = 4">
			  An analysis of this company is currently being prepared. Please try again in 3 - 5 days
			</xsl:when>
			<xsl:when test="/horus/access_control/message_number = 5">
			  This company has filed new documents. Our analysts are presently preparing 
			  a new report. The new report will be available in 3 - 5 days time. 
			  This new report may contain more up-to-date accounts information
			</xsl:when>
			<xsl:when test="/horus/access_control/message_number = 6 or /horus/access_control/message_number = 7">
			  This company has filed new accounts. Our analysts are presently preparing 
			  a new report. The new report will be available in 3 - 5 days time. 
			  If you choose to view one of the old reports listed above then a 
			  new report will be emailed to you when it becomes available and you 
			  will only be charged for one report.
			</xsl:when>
			<xsl:when test="/horus/access_control/message_number = 8">
			  The Report on this Company is currently being verified. To recieve this report please contact our helpdesk on 020 7729 1234.
			</xsl:when>
			<xsl:when test="/horus/access_control/message_number = 9 or /horus/access_control/message_number = 10">
			  There is currently no report for this company
			</xsl:when>
		  </xsl:choose>
		</td>
	  </tr>

	</table>
  </xsl:if>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>  
