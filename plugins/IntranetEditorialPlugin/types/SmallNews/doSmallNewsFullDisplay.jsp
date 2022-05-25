<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %><%
SmallNews pub = (SmallNews)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

Boolean haveAside = 
        (Util.notEmpty(pub.getTitreListeDeContacts()) && (Util.notEmpty(pub.getContactsAgents()) || Util.notEmpty(pub.getContactsUniteOrga()) || Util.notEmpty(pub.getContacts()) || Util.notEmpty(pub.getComplementContacts()))) ||
        (Util.notEmpty(pub.getTitreListeDeDocuments()) && Util.notEmpty(pub.getListeDeDocuments())) ||              
        (Util.notEmpty(pub.getTitreListeDeLiens()) && (Util.notEmpty(pub.getLienInterne()) || Util.notEmpty(pub.getLienLibre()))) ||        
        (Util.notEmpty(pub.getTitreTexteDeLencadre()) && Util.notEmpty(pub.getTexteEncart()));

String colLenght = haveAside ? "8" : "12";

request.setAttribute("fullIsHidden", true);


%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="fulldisplay SmallNew">

    <article class="row-fluid">
        <section class="col-md-<%= colLenght %>">
            <h1 class="main-title"><%= pub.getTitle() %> <jalios:edit data="<%= pub %>"/> </h1>   
            
            <%-- Date --%>
            <p class="date">Mis à jour le <jalios:date date="<%= pub.getMdate() %>" format='<%= "full" %>'/></p>
            
            <%-- Mots Clés --%>
            <% TreeSet<Category> motsClesSet = pub.getMotscles(loggedMember); %>
            <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
                <div class="search-result-meta search-result-categories">
                  <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
                  <% String type =  pub.getClass().getCanonicalName(); %>
                  <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
                </div>
            </jalios:if>
            
            <jalios:if predicate="<%= Util.notEmpty(pub.getAbstract()) %>">
              <div class="resume"><jalios:wiki><%= pub.getAbstract() %></jalios:wiki></div>
            </jalios:if>
             
            <jalios:if predicate="<%= Util.notEmpty(pub.getIllustration()) %>">             
	            <figure class="pull-left">
	               <jalios:thumbnail path="<%= pub.getIllustration() %>" width="350" height="500"/>
	               <figcaption>
	                 <jalios:truncate length="60"><%= pub.getLegendeIllustration() %></jalios:truncate> 
	                 <jalios:if predicate="<%= Util.notEmpty(pub.getCopyrightIllustration()) %>">
	                     - © <%= pub.getCopyrightIllustration() %>
	                 </jalios:if>
	               </figcaption>
	            </figure>
            </jalios:if>
            
            <jalios:wysiwyg><%= pub.getContenu() %></jalios:wysiwyg>
            
            <div class="clear"></div>       
        </section>
        
        <jalios:if predicate="<%= haveAside %>">
            <aside class="col-md-4">                
                <%@ include file='/plugins/IntranetEditorialPlugin/jsp/aside/encadre.jspf' %>     
            </aside>
        </jalios:if>
        
    </article>
    <div class="clear"></div>   
</div>