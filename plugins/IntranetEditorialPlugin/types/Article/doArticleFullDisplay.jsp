<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %><%
Article pub = (Article)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

Boolean haveAside = Util.notEmpty(pub.getListeDePortletHaut()) || 
		(Util.notEmpty(pub.getTitreListeDeContacts()) && (Util.notEmpty(pub.getContactsAgents()) || Util.notEmpty(pub.getContactsUniteOrga()) || Util.notEmpty(pub.getContacts()) || Util.notEmpty(pub.getComplementContacts()))) ||
		(Util.notEmpty(pub.getTitreListeDeDocuments()) && Util.notEmpty(pub.getListeDeDocuments())) ||				
		(Util.notEmpty(pub.getTitreListeDeLiens()) && (Util.notEmpty(pub.getLienInterne()) || Util.notEmpty(pub.getLienLibre()))) ||		
		(Util.notEmpty(pub.getTitreTexteDeLencadre()) && Util.notEmpty(pub.getTexteEncart())) ||
		Util.notEmpty(pub.getListeDePortletBas());

String colLenght = haveAside ? "8" : "12";

if(haveAside) {
	request.setAttribute("fullIsHidden", true);
}


%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="fulldisplay Article">

	<article class="row-fluid">
		<section class="col-md-<%= colLenght %>">
			<h1 class="main-title"><%= pub.getTitle() %></h1>
			
			<%-- Date --%>
			<p class="date">Mis à jour le <jalios:date date="<%= pub.getMdate() %>" format='<%= "full" %>'/></p>
			
			<%-- Mots Clés --%>
			<% TreeSet<Category> motsClesSet = pub.getMotsCles(loggedMember); %>
		    <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
			    <div class="search-result-meta search-result-categories">
	              <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
	              <% String type =  pub.getClass().getCanonicalName(); %>
	              <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
	            </div>
            </jalios:if>
			
			<jalios:if predicate="<%= Util.notEmpty(pub.getAbstract()) %>">
			  <div class="resume"><jalios:wysiwyg><%= pub.getAbstract() %></jalios:wysiwyg></div>
			</jalios:if>
			
			<jalios:if predicate="<%= Util.notEmpty(pub.getPicture()) %>">		
				<figure class="pull-left container-img">
				   <jalios:thumbnail path="<%= pub.getPicture() %>" width="350" height="500"/>
				   <figcaption>
				     <%= pub.getLegendeIllustration() %>
				     <jalios:if predicate="<%= Util.notEmpty(pub.getCopyrightIllustration()) %>">
				         - © <%= pub.getCopyrightIllustration() %>
				     </jalios:if>
				   </figcaption>
				</figure>
			</jalios:if>
			
			<jalios:wysiwyg><%= pub.getContent() %></jalios:wysiwyg>
			
			<div class="clear"></div>		
		</section>
		
		<jalios:if predicate="<%= haveAside %>">
			<aside class="col-md-4">
			     
			    <jalios:if predicate="<%= Util.notEmpty(pub.getListeDePortletHaut()) %>">
				    <div class="portlet-haut">
				      <jalios:foreach name="itPortlet" array="<%= pub.getListeDePortletHaut() %>" type="PortalElement">
				         <jalios:include id="<%= itPortlet.getId() %>" />
				      </jalios:foreach>
				    </div>
			    </jalios:if>
	
				<%@ include file='/plugins/IntranetEditorialPlugin/jsp/aside/encadre.jspf' %>
				
				<jalios:if predicate="<%= Util.notEmpty(pub.getListeDePortletBas()) %>">
                    <div class="portlet-bas">
                      <jalios:foreach name="itPortlet" array="<%= pub.getListeDePortletBas() %>" type="PortalElement">
                         <jalios:include id="<%= itPortlet.getId() %>" />
                      </jalios:foreach>
                    </div>
                </jalios:if>
                			
			</aside>
		</jalios:if>
		
	</article>
	<div class="clear"></div>	
</div>