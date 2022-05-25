<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY);  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="fullDisplay pqf-contenuLibre <%= box.getCssClasses() %>">


<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
    
<%--     <% ContenuLibre obj = (ContenuLibre) itPub; %> --%>
    
    <div class="elt-contenuLibre">
        <jalios:edit data="<%= itPub %>"/>
        <jalios:wysiwyg><%= itPub.getAbstract() %></jalios:wysiwyg>
                         
    </div>     
            
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>