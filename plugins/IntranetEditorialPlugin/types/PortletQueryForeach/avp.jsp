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
    
    <% AVP itObj = (AVP) itPub; %>
    <% String categoryPoste = itObj.getCategorieDemploi(loggedMember).toString().substring(1, itObj.getCategorieDemploi(loggedMember).toString().length() -1 ); %>
   
    <section class="elt-avp result AVP clear">       
        <div>
	       <h2 class="list-title"><jalios:link data="<%= itObj %>" params="<%= displayURLparams %>" /> <span class="editIcon"> <jalios:edit data="<%= itPub %>" popup="true"/> </span>	</h2>	       
	       <span class="surlignageJaune"><%= Util.getFirst(itObj.getVille(loggedMember)) %> - <%= categoryPoste  %></span>
	       <div class="info">       
	            <div><%= glp("jcmsplugin.intranetEditorial.avp.depot") %> : <jalios:date date="<%= itObj.getDateLimiteDeDepot() %>" format='<%= "dd MMMM yyyy" %>' /> </div>             
	            <div><span class="lib"><%= Util.getFirst(itObj.getDirectiondelegation(loggedMember)) %> </span></div>           
	            <%-- Mots Clés --%>
	            <% TreeSet<Category> motsClesSet = itObj.getMotscles(loggedMember); %>
	            <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
	                <div class="search-result-meta search-result-categories">
	                  <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
	                  <% String type =  itObj.getClass().getCanonicalName(); %>
                  <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
	                </div>
	            </jalios:if>
	            <jalios:wysiwyg><%= itObj.getMission() %></jalios:wysiwyg>
	       </div>	       	       
	   </div>                                  
    </section>     
            
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>