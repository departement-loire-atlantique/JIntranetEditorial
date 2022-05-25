<%@ page contentType="text/html; charset=UTF-8" %><%
%><%--
  @Summary: Focus display page
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Focus obj = (Focus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%

String colorCatString = "transparent";
if(Util.notEmpty(obj.getCouleurDeFond(loggedMember))){
  Category colorCat = (Category) (obj.getCouleurDeFond(loggedMember).first()); 
  colorCatString = colorCat.getColor();
}
%>
<%@ include file='/front/doFullDisplay.jspf' %>
<%
	jcmsContext.addJavaScript("plugins/IntranetVisualIdentityPlugin/js/focus.js");
%>
<section class="fullDisplay pqf-focus">
   
    <div class="elt-focus <%= Util.notEmpty(obj.getIllustration()) ? "illustration-focus" : "" %>" style="background-color: <%= colorCatString  %>;">    
        <% String focusLink = Util.notEmpty(obj.getLienInterne())? obj.getLienInterne().getDisplayUrl(userLocale) : obj.getLienExterne(); %>
        <a href="<%= focusLink %>" <%= Util.notEmpty(obj.getLienExterne()) && !obj.getLienExterne().contains("planet.loire-atlantique.fr") ? "target=_'blank'" : "" %> title="<%= obj.getDescriptionDuLien()%>" class="lien-focus">
            <div class='elt-container '>
                <jalios:if predicate="<%= Util.notEmpty(obj.getIllustration()) %>">
	                <div class="illustration">
	                    <img src="<%= obj.getIllustration() %>" alt"" />                    
	                </div>
                </jalios:if>
                
                <div class="titre">
                    <span class='<%= obj.getTitre1Gras() ? "titre-gras" : "" %>'><%= obj.getTitre1() %></span> <span class='<%= obj.getTitre2Gras() ? "titre-gras" : "" %>'><%= obj.getTitre2() %></span>
                </div>
    
            </div>
        </a>
        <jalios:edit pub="<%=obj%>" css="edit-focus" popup="true"/>
        <div class="show-focus-edit-icon">&nbsp;</div>
       	
    </div>     
           
</section>
