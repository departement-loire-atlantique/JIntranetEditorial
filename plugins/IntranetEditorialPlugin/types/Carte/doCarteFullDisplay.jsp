<%@ include file='/jcore/doInitPage.jspf' %><%

Carte obj = (Carte)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String displayURLparams = (String)request.getAttribute("displayURLparams");

%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="fullDisplay carte">
	
	<div class="row-fluid clearfix">
		<%-- Partie gauche --%>
		<div class="col-md-12 left-pubCG">
			<h1><%= obj.getTitle() %><jalios:edit data="<%= obj %>" /></h1>
		
		    <jalios:if predicate="<%= Util.notEmpty(obj.getVignette()) %>">
			    <div class="illustration pull-left">
			       <jalios:thumbnail path="<%= obj.getVignette() %>" width="300" height="200" />
				</div>
			</jalios:if>
			
			<%-- Info sur le doc --%>
			<div class="info">
			    <%-- date --%>
			    <div class="taille-date">
			      <div>Dernière mise à jour : <jalios:date date="<%= obj.getMdate() %>" format="dd MMMM yyyy" /> </div>
			    </div>
			    
			    <%-- Télécharger le doc --%>
			    <div class="bold telecharger-doc">					
					<jalios:dataicon data="<%= obj %>" />
					<a href='<%= obj.getFilename() %>' target="_blank">
					  	<span class="margin-lib"><%= glp("jcmsplugin.intranetEditorial.carte.telecharger") %></span> 
					</a>
					(<jalios:filesize doc="<%= obj %>"/>)	
						
					<a href="<%= obj.getFilename() %>" class="telecharger-icon" target="_blank">
                      <jalios:thumbnail path='plugins/IntranetVisualIdentityPlugin/images/icon/telecharger.png' width='24' height='24' alt='<%= "Télécharger "+ obj.getTitle() %>' />
                    </a>					
				</div>
				
				<%-- Feuilleter le doc --%>	
				<jalios:if predicate="<%= Util.notEmpty(obj.getLienAtlas()) %>">			
				    <div class="bold"><img src="plugins/IntranetVisualIdentityPlugin/images/icon/oeil_vert.png" alt=""/> <span class="margin-lib"> <a href="<%= obj.getLienAtlas() %>" target="_blank"><%= glp("jcmsplugin.intranetEditorial.carte.atlas") %></a> </span>  </div>				
			    </jalios:if>
			</div>
					
			<div class="clear"></div>
			
			<%-- Résumé --%>
			<jalios:if predicate="<%= Util.notEmpty(obj.getAbstract()) %>">	
				<div>
					<jalios:wiki><%= obj.getAbstract() %></jalios:wiki>
				</div>
			</jalios:if>
			
			
		</div>
								
	</div>
	
</div>