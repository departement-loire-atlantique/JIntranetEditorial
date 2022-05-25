<%@ include file='/jcore/doInitPage.jspf' %><%

PublicationCG obj = (PublicationCG)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String displayURLparams = (String)request.getAttribute("displayURLparams");

%><%@ include file='/front/doFullDisplay.jspf' %>

<jalios:thumbnail css="pull-left" path="<%= obj.getVignette() %>" />

<h1><jalios:link data="<%= obj %>" /> <jalios:edit data="<%= obj %>" /></h1>

<section style="overflow: auto;">

<div>
	<jalios:link data='<%= obj %>' params='<%= displayURLparams %>'>
	  	<jalios:dataicon data="<%= obj %>" />
	  	<%= glp("jcmsplugin.intranetEditorial.carte.telecharger") %> 
	</jalios:link>
	(<jalios:filesize doc="<%= obj %>"/>)
</div>

<jalios:if predicate="<%= Util.notEmpty(obj.getAbstract()) %>">	
	<div>
		Résumé:
		<jalios:wiki><%= obj.getAbstract() %></jalios:wiki>
	</div>
</jalios:if>

<p>
	Contact du contenu: 
	<jalios:foreach name="itMbr" type="Member" array="<%= obj.getContactAgent() %>">
		<jalios:link data="<%= itMbr %>" />
	</jalios:foreach>
	<jalios:foreach name="itGroup" type="Group" array="<%= obj.getContactUniteOrganisationnelle() %>">
		<%= itGroup %>
	</jalios:foreach>
</p>

<p>
	Demander une version papier de ce document: 
	<jalios:foreach name="itMbr" type="Member" array="<%= obj.getContactPourVersionPapierAgent() %>">
		<jalios:link data="<%= itMbr %>" />
	</jalios:foreach>
	<jalios:foreach name="itGroup" type="Group" array="<%= obj.getContactPourVersionPapierUniteOrg() %>">
		<%= itGroup %>
	</jalios:foreach>
</p>

<div class="clear"></div>

</section>