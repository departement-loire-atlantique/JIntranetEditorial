<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%

PublicationCG obj = (PublicationCG)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String displayURLparams = (String)request.getAttribute("displayURLparams");
String catColor = currentCategory.getAvailableColor();

%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="fullDisplay publicationCG">
	
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
			<div class="info" <%= Util.notEmpty(obj.getVignette()) ? "style='margin-left:330px;'" : ""%>>
			    <%--Taille et date --%>
			    <div class="taille-date" style="display: block;">
			      <div><%= obj.getTaillePhysiqueDuDocumentEnCm() %>, <%= obj.getNombreDePages() %> <%= glp("jcmsplugin.intranetEditorial.pubcg.page") %></div>
			      <div>Publié en <%= obj.getDateDePublication() %></div>
			    </div>
			    
			    <%-- Télécharger le doc --%>
		        <%
			         FileDocument doc = new FileDocument();
			         doc.setFilename(obj.getFilename());
			         doc.setContentType(obj.getContentType());
			        %>
		        
		        <div class="elementInfo">
			        <div class="flex-container">
			        	<div class="icon-flex">                                    
		                       <jalios:dataicon data="<%= doc %>" />
		                </div>
						<div class="info-flex bold">
							<a href="<%= doc.getFilename() %>" class="_blank">
								<%= glp("jcmsplugin.intranetEditorial.pubcg.telecharger") %>
							</a>
								
								(<jalios:filesize doc="<%= obj %>"/>)							
						</div>
						<div class="info-doc-flex">
							<div class="pull-right">
		                        <a href="<%= doc.getFilename() %>" class="_blank">
		                        	<jalios:thumbnail path='plugins/IntranetVisualIdentityPlugin/images/icon/telecharger.png' width='24' height='24' alt='<%= "Télécharger "+ doc.getTitle() %>' />
								</a>
							</div>
						</div>
					</div>
				</div>
				
				<%-- Feuilleter le doc --%>
				<% if (Util.notEmpty(obj.getFeuilleterLeDocument())) { %>
				<div class="elementInfo">
					<div class="icon-flex">
						<img src="plugins/IntranetVisualIdentityPlugin/images/icon/oeil_vert.png" alt=""/>
	                </div>
					<div class="info-flex bold">
						<a href="<%= obj.getFeuilleterLeDocument() %>"><%= glp("jcmsplugin.intranetEditorial.pubcg.feuilleter") %></a> 
					</div>
				</div>
				<%} %>
				
				<%-- Diffusion --%>
				<% if (Util.notEmpty(obj.getDiffusion(loggedMember))) { %>
		            <jalios:foreach collection="<%= obj.getDiffusion(loggedMember) %>" type="Category" name="itCategory" >
		            	<div class="elementInfo">
							<jalios:if predicate="<%= Util.notEmpty(itCategory.getIcon()) %>">
								<div class="icon-flex">
									<img src="<%= itCategory.getIcon() %>" alt="" />
								</div>
							</jalios:if>
			                <div class="info-flex bold">  
			              		<%=itCategory.getName(userLang)%>
			              	</div>
						</div>
		            </jalios:foreach>
            	<% } %>
				<%-- Cible --%>
				<% if (Util.notEmpty(obj.getCible(loggedMember))) { %>
		            <jalios:foreach collection="<%= obj.getCible(loggedMember) %>" type="Category" name="itCategory" >
		            	<div class="elementInfo">
							<jalios:if predicate="<%= Util.notEmpty(itCategory.getIcon()) %>">
								<div class="icon-flex">
									<img src="<%= itCategory.getIcon() %>" alt="" />
								</div>
							</jalios:if>
			                <div class="info-flex bold">  
			              		<%=itCategory.getName(userLang)%>
			              	</div>
						</div>
		            </jalios:foreach>
            	<% } %>
								
			</div>
					
			<div class="clear"></div>
			
			<%-- Résumé --%>
			<jalios:if predicate="<%= Util.notEmpty(obj.getAbstract()) %>">
				<div>
					<jalios:wiki><%= obj.getAbstract() %></jalios:wiki>
				</div>
			</jalios:if>
			
		</div>
		
		
		<%-- Partie basse : Contacts --%><%-- Menu déroulant --%>
        
		<div class="col-md-12 right-pubCG">			
			<section class="flat-color flatColorSkin">

		        	<div class="pqf-contacts">
			        	<div data-jalios-collapse-toggle="caret caret" class="jalios-accordion">                              
			                <%-- Lien pour déplier les contacts --%>             
			                <div class="panel-heading collapsed" data-toggle="collapse" data-parent="#" data-target="#contact_<%=obj.getId()%>">          
			                    <div class="panel-title title-niv1 bold">                    
			                        <a href="#contact_<%=obj.getId()%>" onclick="return false;" id="anonymous_element_1">
			                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
			                            Contacts
			                        </a>
			                    </div>
			                </div>
			                <%-- Liste des contacts --%>
			                <div id="contact_<%=obj.getId()%>" class="panel-collapse collapse panel-niv-1">
				        		<div class="row">
				           
					             <%-- MEMBRES --%>
			                      <jalios:if predicate="<%= Util.notEmpty(obj.getContactAgent() ) %>">
			                          <jalios:foreach name="itMember" array="<%= obj.getContactAgent() %>" type="Member">
			                             <jalios:if predicate="<%= Util.notEmpty(itMember) %>">
			                             	<div class="col-md-6 publicationCGConteneurContact">
			                                	<%@ include file="../../types/Contacts/doContactItemBoxListItem.jspf" %>
			                                </div>
			                             </jalios:if> 
			                          </jalios:foreach>
			                      </jalios:if>
			                      
			                      
			                      <%-- GROUPES --%>
			                      <jalios:if predicate="<%= Util.notEmpty(obj.getContactUniteOrganisationnelle()) %>">
			                          <jalios:foreach name="itGroup" array="<%= obj.getContactUniteOrganisationnelle() %>" type="Group">
			                             <jalios:if predicate="<%= Util.notEmpty(itGroup) %>">
			                             	<div class="col-md-6 publicationCGConteneurContact">                                                
			                                	<%@ include file="../../types/Contacts/doContactItemGroupBoxListItem.jspf" %>
			                                </div>                                                                           
			                             </jalios:if> 
			                          </jalios:foreach>
			                      </jalios:if>
					           
					           
					              <%-- MEMBRES PAPIER --%>
					              <jalios:if predicate="<%= Util.notEmpty(obj.getContactPourVersionPapierAgent()) %>">
					                  <jalios:foreach name="itMember" array="<%= obj.getContactPourVersionPapierAgent() %>" type="Member">
					                     <jalios:if predicate="<%= Util.notEmpty(itMember) %>">
					                     	<div class="col-md-6 publicationCGConteneurContact">
					                        	<%@ include file="../../types/Contacts/doContactItemBoxListItem.jspf" %>
					                        </div>
					                     </jalios:if> 
					                  </jalios:foreach>
					              </jalios:if>
					              
					              
					              <%-- GROUPES PAPIER --%>
					              <jalios:if predicate="<%= Util.notEmpty(obj.getContactPourVersionPapierUniteOrg()) %>">
					                  <jalios:foreach name="itGroup" array="<%= obj.getContactPourVersionPapierUniteOrg() %>" type="Group">
					                     <jalios:if predicate="<%= Util.notEmpty(itGroup) %>">
					                     	<div class="col-md-6 publicationCGConteneurContact">
					                        	<%@ include file="../../types/Contacts/doContactItemGroupBoxListItem.jspf" %>
					                        </div>                                                                           
					                     </jalios:if> 
					                  </jalios:foreach>
					              </jalios:if>
				              
				              </div>			                    
			                </div>
			             </div>

		            
		            </div>
		            
    
		    </section>    			
		</div>
		
				
	</div>
	
</div>