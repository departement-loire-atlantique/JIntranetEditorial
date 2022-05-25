<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%
%>
<%-- Ce fichier est appelé via une portlet JSP (pour afficher le bon Skin) 
La portlet JSP est elle-même appelée par les gabarits FullDisplay
des types "FicheMetier" et "FicheFormation"

--%>

<%
Publication pub = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<jalios:select>
	<jalios:if predicate='<%= pub instanceof generated.FicheFormation %>'>
		<%
		FicheFormation obj = (FicheFormation)pub;
		%>
		<%@ include file="../../jsp/satelliteMobilite/parcoursDeFormationAssocies.jspf" %>
	</jalios:if>
	
	<jalios:if predicate='<%= pub instanceof generated.FicheMetier %>'>
		<%
		FicheMetier obj = (FicheMetier)pub;
		%>
		<%@ include file="../../jsp/satelliteMobilite/parcoursDeFormationAssocies.jspf" %>
	</jalios:if>
</jalios:select>



