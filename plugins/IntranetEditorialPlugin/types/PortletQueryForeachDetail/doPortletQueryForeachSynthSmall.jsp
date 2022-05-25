<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
PortletQueryForeachDetail box = (PortletQueryForeachDetail) portlet; 
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<div class="pqf-synth_small">
	<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
	
	<div class="synth_small-data">
		<!-- Date -->
		<jalios:if predicate="<%= Util.notEmpty(box.getShowDate()) %>">
			<div class="synth_small-data-date">
				<% Date itemDate = itPub.getDate(box.getShowDate()); %>
   				<%@ include file="/jcore/doItemBoxDate.jspf" %>  	
			</div>
		</jalios:if>
		
		<!-- Image -->		
		<jalios:thumbnail path="<%= itPub.getDataImage() %>" width="220" height="220" alt="" css="synth_small-data-image"></jalios:thumbnail>			
		
		<!-- Titre -->
		<jalios:if predicate="<%= box.getShowTitle() %>">
			<div class='synth_small-data-title'>
	         	<jalios:link data='<%= itPub %>' params='<%= displayURLparams %>' css='noTooltipCard carousel-meta-data'><h3><%= itPub.getTitle(userLang) %></h3></jalios:link>
	        </div>
        </jalios:if>
        
         <!-- Résumé -->
         <jalios:if predicate="<%= box.getShowAbstract() %>">
			<div class='synth_small-data-resume'>
				<jalios:wiki><%= itPub.getAbstract() %></jalios:wiki>
	        </div>
        </jalios:if>
        
       	<div class="clear"></div>
    </div>
      
	<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
</div>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>