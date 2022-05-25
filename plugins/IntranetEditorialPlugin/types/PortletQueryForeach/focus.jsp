<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY);  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="fullDisplay pqf-focus <%= box.getCssClasses() %>">


<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
    
    <% Focus obj = (Focus) itPub; %>
    <% Category colorCat = (Category) (obj.getCouleurDeFond(loggedMember).first()); %>
    <div class="elt-focus <%= Util.notEmpty(obj.getIllustration()) ? "illustration-focus" : "" %>" style="background-color: <%= colorCat.getColor() %>;">    
        <% String focusLink = Util.notEmpty(obj.getLienInterne())? obj.getLienInterne().getDisplayUrl(userLocale) : obj.getLienExterne(); %>
        <a href="<%= focusLink %>" <%= Util.notEmpty(obj.getLienExterne()) ? "target=_'blank'" : "" %> title="<%= obj.getDescriptionDuLien()%>">
            <div class='elt-container '>
                <jalios:if predicate="<%= Util.notEmpty(obj.getIllustration()) %>">
	                <div class="illustration pull-left">
	                    <img src="<%= obj.getIllustration() %>" alt"" />                    
	                </div>
                </jalios:if>
                
                <div class="titre">
                    <span class='<%= obj.getTitre1Gras() ? "titre-gras" : "" %>'><%= obj.getTitre1() %></span> <span class='<%= obj.getTitre2Gras() ? "titre-gras" : "" %>'><%= obj.getTitre2() %></span>
                </div>
    
            </div>
        </a>                     
    </div>     
            
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>