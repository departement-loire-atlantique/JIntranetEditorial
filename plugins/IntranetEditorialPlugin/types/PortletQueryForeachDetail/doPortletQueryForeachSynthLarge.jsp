<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
PortletQueryForeachDetail box = (PortletQueryForeachDetail) portlet; 
%>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<div class="pqf-synth_large">
	<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
		
	<div class="synth_large-data">		
		<!-- Date -->
		<jalios:if predicate="<%= Util.notEmpty(box.getShowDate()) %>">
			<div class="synth_large-data-date">
				<% Date itemDate = itPub.getDate(box.getShowDate()); %>
   				<%@ include file="/jcore/doItemBoxDate.jspf" %>  	
			</div>
		</jalios:if>
		
		<!-- Image -->
		<div class="synth_large-data-image">			
			<jalios:thumbnail path="<%= itPub.getDataImage() %>" width="1000" height="800" alt=""></jalios:thumbnail>			
		</div>
		
		<!-- Titre -->
		<jalios:if predicate="<%= box.getShowTitle() %>">
			<div class='synth_large-data-title'>
	         	<jalios:link data='<%= itPub %>' params='<%= displayURLparams %>' css='noTooltipCard carousel-meta-data'><h3><%= itPub.getTitle(userLang) %></h3></jalios:link>
	        </div>
	    </jalios:if>
        
        <!-- Résumé -->
        <jalios:if predicate="<%= box.getShowAbstract() %>">
			<div class='synth_large-data-resume'>
				<jalios:wiki><%= itPub.getAbstract() %></jalios:wiki>
	        </div>
        </jalios:if>
    </div>
        
	<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
</div>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>