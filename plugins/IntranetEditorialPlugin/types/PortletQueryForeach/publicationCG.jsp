<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet; %>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>


<div class="pqf-simple-list-vignette pqf-list-documentCG">
  <ul class="item-box-list item-box-simple-list-vignette">
    <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
      <li class="item-simple-list-vignette <%= loggedMember.hasRead(itPub) && itPub.isTracked() ? "hasRead" : "" %>">   


        <div class="icon">                    
          <jalios:if predicate="<%= Util.notEmpty(itPub.getDataImage()) %>">
           <jalios:link data="<%= itPub %>" params="<%= displayURLparams %>" >
              <jalios:thumbnail path="<%= itPub.getDataImage() %>" width="150" height="220" alt=""></jalios:thumbnail>           
           </jalios:link>
          </jalios:if>            
        </div>
        
        <div class="info">
          <div class="titre">                           
             <jalios:link data="<%= itPub %>" params="<%= displayURLparams %>"/>       
             <span class="editIcon"> <jalios:edit data="<%= itPub %>" popup="true"/> </span>                 
          </div>

          <p class="sub-info">
              <%-- Date --%>
              <% Date itemDate = itPub.getPdate(); %>
              <% FileDocument fileDoc = (FileDocument) itPub; %>
              <jalios:date format="MMMM yyyy" date="<%= itemDate %>" /> - <jalios:filesize doc="<%= fileDoc %>" />
          </p>
            
        </div>
        <div class="clear"></div>
      </li>
    <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
  </ul>
</div>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>