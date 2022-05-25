<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Incident obj = (Incident)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%

 Category incidentMajeurCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.depeche.incident.majeur");

 PortletWYSIWYG portletFormule = (PortletWYSIWYG) channel.getPublication("$id.jcmsplugin.intraneteditorial.depeche.formule.portlet");

%>

<div class="fullDisplay Incident <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
 
 
    
<h1 class="main-title">
	<%= obj.getTitle() %> - <%= obj.getWFStateLabel(userLang) %> 
	<span style="margin-left: 25px">
		<jalios:select>
			<jalios:if predicate="<%= JcmsUtil.isSameId(obj.getFirstTypeDincident(loggedMember), incidentMajeurCat) %>">
				<jalios:icon src="glyph:icomoon-weather-lightning" htmlAttributes="style='font-size:50px;'"/>
			</jalios:if>
			<jalios:default>
				<jalios:icon src="glyph:icomoon-weather-cloud-sun" htmlAttributes="style='font-size:49px;'"/>
			</jalios:default>  
		</jalios:select>
	</span>  
</h1>

<jalios:if predicate="<%= Util.notEmpty(obj.getApplicationsConcernees()) %>">
	<p>
	    <%= glp("jcmsplugin.intranetEditorial.numerique.concernes.lbl") %> : <%= obj.getApplicationsConcernees() %>
	</p>
</jalios:if>

<p>
    <%= glp("jcmsplugin.intranetEditorial.numerique.destinataires.lbl") %> : <%= obj.getDestinataire() %>
</p>

<jalios:select>
    <%-- Statut en cours --%>
    <jalios:if predicate="<%= obj.getPstatus() == 1  %>">
        <p>Depuis <jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getCdate() %>" /></p>
    </jalios:if>
    <%-- Statut en terminé --%>
    <jalios:if predicate="<%= obj.getPstatus() == 11  %>">
        <p>Du <jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getCdate() %>" /> au <jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getDateDeFin() %>" /></p>
    </jalios:if>
</jalios:select>


<jalios:wiki><%= obj.getDescription() %></jalios:wiki>
    
<jalios:wysiwyg><%= portletFormule.getWysiwyg() %></jalios:wysiwyg>



</div>