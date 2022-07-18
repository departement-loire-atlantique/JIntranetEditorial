<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Incident obj = (Incident)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%
Category incidentMajeurCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.depeche.incident.majeur");
%>

<div class="queryDisplay Incident depeches <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">

    <%-- Picto selon type d'incident --%>
	<div class="icon">	
	   <jalios:select>   
		   <jalios:if predicate="<%= JcmsUtil.isSameId(obj.getFirstTypeDincident(loggedMember), incidentMajeurCat) %>">
		   	<jalios:icon src="glyph:icomoon-weather-lightning" htmlAttributes="style='font-size:22px;'"/>
	           <!-- <img src="plugins/IntranetEditorialPlugin/images/numerique/Orage_petit.png" alt="majeur" />-->
	       </jalios:if>
	       <jalios:default>
	       <jalios:icon src="glyph:icomoon-weather-cloud-sun" htmlAttributes="style='font-size:20px;'"/>
	           <!-- <img src="plugins/IntranetEditorialPlugin/images/numerique/Nuageux_petit.png" alt="normal" />-->
	       </jalios:default>	   
	   </jalios:select>	   	   
	</div>
	
	
	<%-- Titre et date --%>
	<div class="info">	
	   <%-- Titre --%>
	   <span class="title-depeche">
	       <jalios:link data="<%= obj %>" /> 
	   </span>
	   
	   <%-- Date et heure de dernière modif --%>
	   <span class="sub-info">	      
	       - [<jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getMdate() %>" />]
	   </span>
	   
	   <jalios:edit data="<%= obj %>" />
	   
	</div>
	
	<div class="clear"></div>

</div>