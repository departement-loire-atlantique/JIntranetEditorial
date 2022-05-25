<%@page import="com.jalios.jcms.taglib.menu.MenuInfo"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<% 
	MenuInfo<Category> menuInfo = (MenuInfo<Category>) request.getAttribute(MenuInfo.MENU_INFO_ATTR); 
	Category publicationSectionCat = channel.getCategory("$plugin.planet.section.publication.cat"); 
%>
<jalios:submenu id="<%= menuInfo.getId() %>" label="<%= menuInfo.getLabel() %>" link="<%= menuInfo.getLink() %>" depthLevel="<%= menuInfo.getDepthLevel() %>" maxDepthLevel="<%= menuInfo.getMaxDepthLevel() %>" active="<%= menuInfo.isActive() %>" parentId="<%= menuInfo.getParent() != null ? menuInfo.getParent().getId() : null %>" htmlAttributes="<%= menuInfo.getHtmlAttributes() %>">
  <%
  for (MenuInfo<Category> child : menuInfo.getChildren()) {    
    if (child.isTreeNode()) {
      request.setAttribute(MenuInfo.MENU_INFO_ATTR, child);
      %><jalios:include jsp="jcore/menu/doIterateSubMenu.jsp" /><%
      request.setAttribute(MenuInfo.MENU_INFO_ATTR, menuInfo);
    } else {
    	Set<Publication> pubCat =  child.getNode().getAllPublicationSet();
  	  	Set<Publication> pubCatSection = publicationSectionCat != null ? publicationSectionCat.getAllPublicationSet():null;   			     	   	  
  	  	Publication pub = (Publication) Util.getFirst(Util.interSet(pubCat, pubCatSection));
    	%><jalios:menuitem id="<%= child.getId() %>" label="<%= child.getLabel() %>" link="<%= pub==null? child.getLink() : pub.getDisplayUrl(userLocale) %>" depthLevel="<%= child.getDepthLevel() %>" active="<%= child.isActive() %>" parentId="<%= child.getParent() != null ? child.getParent().getId() : null %>" htmlAttributes="<%= child.getHtmlAttributes() %>" /><%
    }
  }
  %>
</jalios:submenu>