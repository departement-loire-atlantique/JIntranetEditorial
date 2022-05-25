<%@ include file='/jcore/doInitPage.jspf' %><%

PublicationCG obj = (PublicationCG)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String displayURLparams = (String)request.getAttribute("displayURLparams");

%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="fullDisplay publicationCG">
	
	<div class="row-fluid clearfix">
		<%-- Partie gauche --%>
		<div class="col-md-12 col-lg-8 left-pubCG">
			<h1><%= obj.getTitle() %><jalios:edit data="<%= obj %>" /></h1>
		
		    <jalios:if predicate="<%= Util.notEmpty(obj.getVignette()) %>">
			    <div class="illustration pull-left">
			       <jalios:thumbnail path="<%= obj.getVignette() %>" width="300" height="200" />
				</div>
			</jalios:if>
			
			<%-- Info sur le doc --%>
			<div class="info">
			    <%--Taille et date --%>
			    <div class="taille-date" style="display: inline-block;">
			      <div><%= obj.getTaillePhysiqueDuDocumentEnCm() %>, <%= obj.getNombreDePages() %> <%= glp("jcmsplugin.intranetEditorial.pubcg.page") %></div>
			      <div>Publié en <%= obj.getDateDePublication() %></div>
			    </div>
			    
			    <%-- Télécharger le doc --%>
			    <div class="bold telecharger-doc">
			        <%
			         FileDocument doc = new FileDocument();
			         doc.setFilename(obj.getFilename());
			         doc.setContentType(obj.getContentType());
			        %>	
			        <div style="display: inline-block;">
						<jalios:dataicon data="<%= doc %>" />
						<a href='<%= obj.getFilename() %>' target="_blank">
						  	<span class="margin-lib"><%= glp("jcmsplugin.intranetEditorial.pubcg.telecharger") %></span> 
						</a>
						(<jalios:filesize doc="<%= obj %>"/>)							
					</div>							
				</div>
				<%-- Feuilleter le doc --%>		
				<% if (Util.notEmpty(obj.getFeuilleterLeDocument())) { %>		
				<div class="bold">
					<div style="display: inline-block;">
						<img src="plugins/IntranetVisualIdentityPlugin/images/icon/oeil_vert.png" alt=""/> 
						<span class="margin-lib"> <a href="<%= obj.getFeuilleterLeDocument() %>"><%= glp("jcmsplugin.intranetEditorial.pubcg.feuilleter") %></a> </span> 
					</div>
				</div>	
				<%} %>			
			</div>
					
			<div class="clear"></div>
			
			<%-- Résumé --%>
			<jalios:if predicate="<%= Util.notEmpty(obj.getAbstract()) %>">
				<div>
					<jalios:wiki><%= obj.getAbstract() %></jalios:wiki>
				</div>
			</jalios:if>
			
			<%-- Info version papier --%>
			<p>
			<img src="plugins/IntranetVisualIdentityPlugin/images/icon/exclamation_fond_noir.png" /> <span class="bold"><%= glp("jcmsplugin.intranetEditorial.pubcg.papier") %></span>
			</p>
		</div>
		
		
		<%-- Partie droite : Contacts --%>
		<div class="col-md-12 col-lg-4 right-pubCG">			
			<section class="flat-color flatColorSkin">
		        <div class='skinHeader'>
		            <%-- Affichage du titre --%>
		            <h1>Contacts<jalios:edit id="<%= obj.getId() %>" /> </h1>        
		        </div>  
		        <div class="skinContent">
		           <div class="pqf-contacts">
		           
		             <%-- MEMBRES --%>
                      <jalios:if predicate="<%= Util.notEmpty(obj.getContactAgent() ) %>">
                          <jalios:foreach name="itMember" array="<%= obj.getContactAgent() %>" type="Member">
                             <jalios:if predicate="<%= Util.notEmpty(itMember) %>">
                                <%@ include file="../../types/Contacts/doContactItemBoxListItem.jspf" %>
                             </jalios:if> 
                          </jalios:foreach>
                      </jalios:if>
                      
                      
                      <%-- GROUPES --%>
                      <jalios:if predicate="<%= Util.notEmpty(obj.getContactUniteOrganisationnelle()) %>">
                          <jalios:foreach name="itGroup" array="<%= obj.getContactUniteOrganisationnelle() %>" type="Group">
                             <jalios:if predicate="<%= Util.notEmpty(itGroup) %>">                                                
                                <%@ include file="../../types/Contacts/doContactItemGroupBoxListItem.jspf" %>                                                                           
                             </jalios:if> 
                          </jalios:foreach>
                      </jalios:if>
		           
		           
		              <%-- MEMBRES PAPIER --%>
		              <jalios:if predicate="<%= Util.notEmpty(obj.getContactPourVersionPapierAgent()) %>">
		                  <jalios:foreach name="itMember" array="<%= obj.getContactPourVersionPapierAgent() %>" type="Member">
		                     <jalios:if predicate="<%= Util.notEmpty(itMember) %>">
		                        <%@ include file="../../types/Contacts/doContactItemBoxListItem.jspf" %>
		                     </jalios:if> 
		                  </jalios:foreach>
		              </jalios:if>
		              
		              
		              <%-- GROUPES PAPIER --%>
		              <jalios:if predicate="<%= Util.notEmpty(obj.getContactPourVersionPapierUniteOrg()) %>">
		                  <jalios:foreach name="itGroup" array="<%= obj.getContactPourVersionPapierUniteOrg() %>" type="Group">
		                     <jalios:if predicate="<%= Util.notEmpty(itGroup) %>">                                                
		                        <%@ include file="../../types/Contacts/doContactItemGroupBoxListItem.jspf" %>                                                                           
		                     </jalios:if> 
		                  </jalios:foreach>
		              </jalios:if>
		              
		              
		            </div>
		        </div>      
		    </section>    			
		</div>
		
				
	</div>
	
</div>