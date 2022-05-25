<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%

Category sectionRootCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.root.section.categories");

String imageSource = currentCategory.getImage();
String description = currentCategory.getDescription(userLang);

// Sélectionne l'image et la description de la présentation
// Cherche dans les catégories parentes
Category catUse = currentCategory;
while((Util.isEmpty(imageSource) || Util.isEmpty(description)) && catUse != null && !JcmsUtil.isSameId(catUse.getParent(), sectionRootCat)){
	catUse = catUse.getParent();
	if(catUse != null && Util.isEmpty(imageSource)){
		imageSource = catUse.getImage();
	}
	if(catUse != null && Util.isEmpty(description)){
		description = catUse.getDescription(userLang);
	}
}

%>

<jalios:if predicate="<%= Util.notEmpty(imageSource) || Util.notEmpty(description) %>">
  <div class="container-fluid section-description-container presentation-section" style="margin-top: 20px;">  
	    <jalios:if predicate="<%= Util.notEmpty(imageSource) %>">
	      <div class="image" style="float: left; margin-right: 15px;">	        		
	        <jalios:thumbnail path="<%= imageSource %>" width="640" height="240" />	    
	      </div>
	    </jalios:if>
		<div class="description">
			<%= description %>
			<jalios:edit data="<%= currentCategory %>" />
		</div>
	</div>
</jalios:if>