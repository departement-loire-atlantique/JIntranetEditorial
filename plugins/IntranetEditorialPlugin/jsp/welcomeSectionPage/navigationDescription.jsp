<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%

Category sectionRootCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.root.section.categories");
Boolean isRootSectionCat = JcmsUtil.isSameId(currentCategory.getParent(), sectionRootCat);

Publication pub = (Publication) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String titre = pub == null ? currentCategory.getName() : pub.getTitle();


// Selection de la catégorie parente de la section
Category sectionCat = currentCategory;
while(sectionCat.getParent() != null && !JcmsUtil.isSameId(sectionCat.getParent(), sectionRootCat)){
	sectionCat = sectionCat.getParent();
}

String iconeSource = currentCategory.getIcon();
String color = currentCategory.getColor();
// Sélectionne l'icone et la couleur de la navigation
// Cherche dans les catégories parentes
Category catUse = currentCategory;
while( (Util.isEmpty(iconeSource) || Util.isEmpty(color))  && catUse != null && !JcmsUtil.isSameId(catUse.getParent(), sectionRootCat)){
	catUse = catUse.getParent();
	if( catUse != null && Util.isEmpty(iconeSource)){
		iconeSource = catUse.getIcon();
	}
	if( catUse != null && Util.isEmpty(color)){
		color = catUse.getColor();
	}
}

%>

<div style="border-bottom: 2px solid <%= color %>;">

	<jalios:if predicate="<%= Util.notEmpty(iconeSource) %>">	
		<jalios:select>
			<jalios:if predicate="<%= isRootSectionCat %>">
				<jalios:thumbnail path="<%= iconeSource %>" width="120" />	
			</jalios:if>
			<jalios:default>
				<a href="<%= sectionCat.getDisplayUrl(userLocale) %>"  title="Retour <%= sectionCat %>"><jalios:thumbnail path="<%= iconeSource %>" width="120" /></a>
			</jalios:default>
		</jalios:select>	
		
	</jalios:if>
	
	<h1 style="display: inline-block; vertical-align: middle"><%= titre %></h1>	
	
</div>