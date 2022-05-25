<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY);  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="fullDisplay pqf-avp <%= box.getCssClasses() %>">

<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
    
    <% AVPImport itObj = (AVPImport) itPub; %>
    <% String categoryPoste = itObj.getCategorieDemploi(loggedMember).toString().substring(1, itObj.getCategorieDemploi(loggedMember).toString().length() -1 ); %>
   
    <section class="elt-avp result AVP clear">       
        <div>
	       <h2 class="list-title"><jalios:link data="<%= itObj %>" params="<%= displayURLparams %>"><%=itObj.getLibellePoste() %></jalios:link><span class="editIcon"> <jalios:edit data="<%= itPub %>" popup="true"/> </span>	</h2>	       
	       <span class="surlignageJaune"><%= itObj.getVille() %> - <%= categoryPoste  %> <%=Util.notEmpty(itObj.getVacantOuPropose(loggedMember)) ? " - " + Util.getFirst(itObj.getVacantOuPropose(loggedMember)) : "" %></span>
	       <div class="info" style="margin-left : 12px;">       
	            <div><%= glp("jcmsplugin.intranetEditorial.avp.depot") %> : <jalios:date date="<%= itObj.getDateLimiteDeDepot() %>" format='<%= "dd MMMM yyyy" %>' /> </div>             
	            <div style="margin-bottom:10px;">
	            	<span class="lib">
	            	<jalios:if predicate="<%= Util.notEmpty(itObj.getDelegation(loggedMember)) %>">
	            		<%= Util.getFirst(itObj.getDelegation(loggedMember)) %>
	            	</jalios:if>
	            	<jalios:if predicate="<%= Util.notEmpty(itObj.getDirection()) %>">
	            		/ <%= itObj.getDirection() %>
	            	</jalios:if>
	            	<jalios:if predicate="<%= Util.notEmpty(itObj.getService()) %>">
	            		/ <%= itObj.getService() %>
	            	</jalios:if>	
	            
	             	</span>
	             </div>           
	            <%-- Mots Clés --%>
	            <% TreeSet<Category> motsClesSet = itObj.getMotscles(loggedMember); %>
	            <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
	                <div class="search-result-meta search-result-categories">
	                  <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
	                  <% String type =  itObj.getClass().getCanonicalName(); %>
                  <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
	                </div>
	            </jalios:if>
	       </div>	       	       
	   </div>                                  
    </section>     
            
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>