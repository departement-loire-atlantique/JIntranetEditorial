<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% PortletSearch box = (PortletSearch) portlet;  %>
<%
String searchDisplayId = box.getDisplayPortal() != null ? box.getDisplayPortal().getId() : currentCategory.getId();
String searchLink;
if ("mixed".equals(box.getTemplate(TypeTemplateEntry.USAGE_DISPLAY_FULL))) { // FIXME: [Template] A little bit ugly
  searchLink = JcmsUtil.getDisplayUrl(box, userLocale);
} else if (box.getAdvancedSearchPortlet() != null) {
  searchLink = JcmsUtil.getDisplayUrl(box.getAdvancedSearchPortlet(), userLocale);
} else {
  searchLink = ResourceHelper.getSearch() + "?id=" + searchDisplayId; 
}

// Improvement JCMS-4252 : propagate current portlet refinement configuration in advanced search link (workspace, cids)
if ("Current".equals(box.getRefineQueries())) { searchLink +="&amp;cids="+currentCategory.getId();  } 
if ("Portal".equals(box.getRefineQueries())) { searchLink +="&amp;cids="+portalCategory.getId(); } 
if ("CurrentWS".equals(box.getRefineQueries())) { searchLink +="&amp;wrkspc="+workspace.getId(); }

String textInputId = "PortletLightSearchText_" + box.getId();
boolean isInstantSearch = box.getInstantSearch();

%><%@ include file='/types/PortletSearch/doQueryHandler.jsp' %>
<div class="portletLightSearch hidden-print">

<%--  --%>
<% Category searchCat =  Util.getFirst(box.getCategories()); %>

  <% String placeholder = Util.getString(box.getTitleText(userLang), glp("ui.com.placeholder.search")); %>
  <form action="<%= searchCat != null ? searchCat.getDisplayUrl(userLocale) : ( box.getQueryPortlet() != null ? JcmsUtil.getDisplayUrl() : ResourceHelper.getQuery() ) %>" method="get" name="search" class="noSingleSubmitButton">
  
    <jalios:field name='text' resource="field-light">
      <% if (isInstantSearch) { %>
      <input class="form-control typeahead" type="text" size="20"  name="text" data-jalios-ajax-refresh-url="/jcore/autocomplete/acsearch.jsp?portletId=<%= box.getId() %>" placeholder="<%= placeholder %>" value="<%= encodeForHTMLAttribute(getUntrustedStringParameter("text", "")) %>" />
      <% } else { %>
      <input class="form-control search" type="text" name="text" size="20" placeholder="<%= placeholder %>" value="<%= encodeForHTMLAttribute(getUntrustedStringParameter("text", "")) %>"/>
      <% } %>      
      <span class="input-group-btn">
        <button class="btn btn-default" value="true" name="opSearch" type="submit"><jalios:icon src="search"/></button>
        <a href="<%= searchLink %>" class="btn btn-default"><jalios:icon src="plus"/></a>
      </span>               
    </jalios:field> 
    <%= formHandler.getHiddenParams() %>
    <%@ include file='/types/PortletSearch/doHiddenParams.jsp' %>
  </form>
</div>