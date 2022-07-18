<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% InterventionPlanifiee obj = (InterventionPlanifiee)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%

 Category incidentMajeurCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.depeche.incident.majeur");

 PortletWYSIWYG portletFormule = (PortletWYSIWYG) channel.getPublication("$id.jcmsplugin.intraneteditorial.depeche.formule.portlet");
 
%>

<div class="fullDisplay Incident <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
 
 
    
<h1 class="main-title">
    <%= obj.getTitle() %> 
    <span style="margin-left: 25px">
        <jalios:icon src="glyph:icomoon-wrench" htmlAttributes="style='font-size:40px;'"/>
    </span>  
</h1>

<jalios:if predicate="<%= Util.notEmpty(obj.getApplicationsConcernees()) %>">
    <p>
        <%= glp("jcmsplugin.intranetEditorial.numerique.concernes.lbl") %> : <%= obj.getApplicationsConcernees()  %>
    </p>
</jalios:if>

<p>
    <%= glp("jcmsplugin.intranetEditorial.numerique.destinataires.lbl") %> : <%= obj.getDestinataire() %>
</p>


<%-- Date intervention --%>
<p>Intervention prévue du <jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getDateDeDebut() %>" /> au <jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getDateDeFin() %>" /></p>


<jalios:wiki><%= obj.getDescription() %></jalios:wiki>
    
<jalios:wysiwyg><%= portletFormule.getWysiwyg() %></jalios:wysiwyg>



</div>