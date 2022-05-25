<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Alerte obj = (Alerte)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%

 Category incidentMajeurCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.depeche.incident.majeur");

 PortletWYSIWYG portletFormule = (PortletWYSIWYG) channel.getPublication("$id.jcmsplugin.intraneteditorial.depeche.formule.portlet");
 
%>

<div class="fullDisplay Incident <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
 
 
    
<h1 class="main-title">
    <%= obj.getTitle() %>
    <span style="margin-left: 25px">
        <jalios:icon src="glyph:icomoon-warning2" htmlAttributes="style='font-size:44px;'"/>
    </span>  
</h1>



<%-- Date intervention --%>
<p>Publié le <jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getCdate() %>" /> </p>


<jalios:wiki><%= obj.getDescription() %></jalios:wiki>
    
<jalios:wysiwyg><%= portletFormule.getWysiwyg() %></jalios:wysiwyg>



</div>