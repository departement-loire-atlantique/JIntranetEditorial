<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ page import="fr.cg44.plugin.intranetvisualidentity.util.IntranetUtil" %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY);  
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="fullDisplay pqf-ficheMetier <%= box.getCssClasses() %>">

<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
    
    <% FicheMetier itObj = (FicheMetier) itPub; %>
    <% String categoryPoste = itObj.getCategorieDemploi(loggedMember).toString().substring(1, itObj.getCategorieDemploi(loggedMember).toString().length() -1 ); %>
   
    <section class="elt-ficheMetier result ficheMetier clear">       
        <div>
	       <h2 class="list-title"> <jalios:link data="<%= itObj %>" />  <span class="editIcon"> <jalios:edit data="<%= itPub %>" popup="true"/> </span>	 </h2>  
	       <div class="clear" /> </div>
	       <span class="surlignageJaune"><%= categoryPoste  %></span>

           <div class="info">            
	           	<%=IntranetUtil.tronqueChaine(HtmlUtil.html2text(itObj.getMissions()), 40) %>
	        </div>		           

	   </div>                                  
    </section>     
            
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>