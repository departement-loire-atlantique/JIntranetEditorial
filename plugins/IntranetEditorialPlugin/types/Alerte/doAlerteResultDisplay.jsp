<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Alerte obj = (Alerte)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>


<div class="queryDisplay Alerte depeches <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">

    <%-- Picto selon type d'incident --%>
	<div class="icon">
		<jalios:icon src="glyph:icomoon-warning2" htmlAttributes="style='font-size:20px;'"/>	
        <!-- <img src="plugins/IntranetEditorialPlugin/images/numerique/Alerte_petit.png" alt="" />-->	   	   
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