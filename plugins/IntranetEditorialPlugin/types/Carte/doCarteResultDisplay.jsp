<%@ include file='/jcore/doInitPage.jspf' %><%

Carte obj = (Carte)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String displayURLparams = (String)request.getAttribute("displayURLparams");

%><%@ include file='/front/doFullDisplay.jspf' %>

<jalios:thumbnail css="pull-left" path="<%= obj.getVignette() %>" />

<div><%= obj.getTitle(userLang) %></div>

<div>
	<jalios:link data='<%= obj %>' params='<%= displayURLparams %>'>
	  	<jalios:dataicon data="<%= obj %>" />
	  	<%= glp("jcmsplugin.intranetEditorial.carte.telecharger") %> 
	</jalios:link>
	(<jalios:filesize doc="<%= obj %>"/>)
</div>

<jalios:if predicate="<%= Util.notEmpty(obj.getLienAtlas()) %>">
	<div>
		<a href="<%= obj.getLienAtlas() %>" target="_blank">
	  		<jalios:icon src="webpage" />
	  		<%= glp("jcmsplugin.intranetEditorial.carte.atlas") %>
		</a>
	</div>
</jalios:if>

<div class="clear"></div>