<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet; %>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>


<div class="pqf-simple-list pqf-document-vignette">
  <ul class="item-box-list item-box-simple-list">
    <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
      <li class="item-list item-simple-list">   
<!--         <div class="item-icons-large"> -->
<%--          <jalios:edit data="<%= itPub %>" popup="true"/> --%>
<!--        </div> -->              
        <div class="icon">
          <jalios:dataicon data="<%= itPub %>" /> 
        </div>
        <div class="info">
          
          <div class="titre">
              <jalios:link data="<%= itPub %>" params="<%= displayURLparams %>"/>
              <span class="editIcon"> <jalios:edit data="<%= itPub %>" popup="true"/> </span>
          </div>
         
        
          <p class="sub-info">
              <%-- Date --%>
              <jalios:date format="dd/MM/yyyy" date="<%= itPub.getMdate() %>" />
              <jalios:if predicate="<%= itPub instanceof FileDocument  %>">
              - 
              </jalios:if>
              <%-- Poids du document --%>
              <jalios:if predicate="<%= itPub instanceof FileDocument  %>">
                  <% FileDocument doc = (FileDocument) itPub; %>
                  <span class="filesize"><jalios:filesize doc="<%= doc %>" /></span>
              </jalios:if>
          </p>       
        </div>
        
        <div class="clear"></div>
        
        <%-- Vignette --%>
        <jalios:if predicate="<%= itPub instanceof DocumentAvecVignette && Util.notEmpty(itPub.getDataImage()) %>">            
          <div class="document-vignette">
             <jalios:thumbnail css="thumbnail" path="<%= itPub.getDataImage() %>" width="120" height="220"/>
          </div>
        </jalios:if>
               
      </li>
    <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
  </ul>
</div>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>