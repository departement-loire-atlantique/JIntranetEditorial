<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet; %>
<%
jcmsContext.addJavaScript("js/lib/bootstrap/carousel.js");
jcmsContext.addJavaScript("plugins/IntranetVisualIdentityPlugin/js/doCarousel.js");
%>


<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>


<div class="pqf-carrousel">

  <div class="carousel-with-arrows-container">
  
    <div id="actualite-carousel" class='carousel slide <%= collection.size() >= 1 ? "onlyOne" : "" %>'>
       
        <div class="carousel-inner">   
            
            
            <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
                <% boolean isActive = qfeIdx == box.getSkipFirstResults(); %>
	            
	            <div class="<%= isActive ? "active" : "" %> item">           
	                
	                <div class="embed-responsive embed-responsive-3by2">
	                   <img class="embed-responsive-item embed-responsive-item-fix" src="<%= itPub.getDataImage() %>" alt=""/>
	                </div>
	                
	                <div class="encart">
	                
	                   <div class="info-item">
	                       <jalios:link data="<%= itPub %>">
	                           <div class='title <%= Util.notEmpty(itPub.getAbstract()) ? "title-vide" : ""  %>'> <%= itPub.getTitle() %> </div>
	                        </jalios:link>
	                        <jalios:link data="<%= itPub %>">
	                           <div class="description"><jalios:wysiwyg><%= itPub.getAbstract() %></jalios:wysiwyg></div>
	                       </jalios:link>
	                   </div>
	                   
	                </div>
	                
	            </div>

	            
            <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
            
        </div>
    
          
    </div>
  
    
  </div>
  
</div>

<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>