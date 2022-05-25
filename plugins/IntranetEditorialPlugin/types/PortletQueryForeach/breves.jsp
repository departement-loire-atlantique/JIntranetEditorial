<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
  PortletQueryForeach box = (PortletQueryForeach) portlet;
  jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_QUERY); 
%>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<section class="fullDisplay pqf-breves <%= box.getCssClasses() %>">


<%-- <jalios:if predicate="<%= Util.notEmpty(box.getDisplayTitle()) %>"> --%>
<%--     <h1><%= box.getDisplayTitle() %></h1> --%>
<%-- </jalios:if> --%>


<jalios:if predicate="<%= Util.isEmpty(collection) %>">
    <p><%= glp("jcmsplugin.intranetvisualidentity.service.no-result") %></p>
</jalios:if>

<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>    
    
    <% SmallNews obj = (SmallNews) itPub; %>
    
    <div class='elt-breve clear <%= loggedMember.hasRead(itPub) && itPub.isTracked() ? "hasRead" : "" %>'>    
        <jalios:link data="<%= obj %>">
            <div class="decoration pull-left">
	            <div class="illustration pull-left">
	                <jalios:thumbnail path="<%= obj.getIllustration() %>" width="75" height="200" />
	            </div>
	            <div class="picto pull-left">
	               <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeBreve(loggedMember)) %>">
	                 <img src="<%= ((Category)Util.getFirst(obj.getTypeDeBreve(loggedMember))).getDataIcon() %>" alt="" />
	               </jalios:if>
	            </div>
            </div>
        </jalios:link> 
        
        <div class="corps">
            <div class="date">
                <jalios:date date="<%= obj.getMdate() %>" format="dd/MM/yyyy" />
            </div>
             <jalios:link data="<%= obj %>">
	            <div class="title-breve">
	                <jalios:link data="<%= obj %>"/>
	                <span class="editIcon"> <jalios:edit data="<%= itPub %>" popup="true"/> </span>	
	            </div>
	         </jalios:link>
        </div>                     
    </div>     
            
<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>

</section>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>