<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY);  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="fullDisplay pqf-contacts">


<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
    <% Contacts obj = (Contacts) itPub; %>    
    <%@ include file="../Contacts/doContactsList.jspf" %>      
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>