<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY);  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="pqf-fiche-formation">
    <ul class="item-box-list item-box-simple-list">

		<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
		    
		    <li class="item-list item-simple-list">  
		    
			    <% FicheFormation obj = (FicheFormation) itPub; %>	
			    <% String categoryDomaine =  Util.isEmpty(obj.getDomainesDeFormation(loggedMember)) ? "" : obj.getDomainesDeFormation(loggedMember).toString().substring(1, obj.getDomainesDeFormation(loggedMember).toString().length() -1 ); %>		    
			    <div class="elt-formation">			        
			        <div class="titre">
			          <jalios:link data="<%= itPub %>" /> <jalios:edit data="<%= itPub %>"/>
			        </div>
			        <div class="info">
			           Domaine : <%= categoryDomaine %>
			        </div>
			    </div>
		    
		    </li>   
		            
		<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
		
    </ul>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>