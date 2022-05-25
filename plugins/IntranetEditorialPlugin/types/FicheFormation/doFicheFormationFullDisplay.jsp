<%@page import="com.jalios.jcmsplugin.googlemaps.GoogleMapsManager"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%--
  @Summary: FicheFormation display page
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%
%><% FicheFormation obj = (FicheFormation)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%

request.setAttribute("fullIsHidden", true);

String catColor = currentCategory.getAvailableColor();

boolean hasAside = Util.notEmpty(obj.getContactsResponsablesPedagogiques()) ||
					Util.notEmpty(obj.getContactUnitesOrga()) ||
					Util.notEmpty(obj.getPhotoS()) ||
					Util.notEmpty(obj.getVideoS())  ||
					Util.notEmpty(obj.getDocumentsUtiless()) ;

//Indique si la publication à une position géolocalisée
boolean isPubGeo =  Util.notEmpty(GoogleMapsManager.getGeolocation(obj));

%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheFormation <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>">

    <article class="row-fluid">	  
        <section class='<%= hasAside ? "col-md-8" : "col-md-12" %>'>  
	        <h1 class="main-title"><%= obj.getTitle() %></h1>
	        
	        <div class="clear"></div>
	        
	        <%-- Mots Clés --%>
	        <% TreeSet<Category> motsClesSet = obj.getMotscles(loggedMember); %>
	        <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
	            <div class="search-result-meta search-result-categories">
	              <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
	              <% String type =  obj.getClass().getCanonicalName(); %>
	              <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
	            </div>
	        </jalios:if>
	        
	        
	        <%-- Menu déroulant --%>
            <div class="verticalMenun navigation-section menu-welcome">               
	            
	            <%-- Présentation --%>
	            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
	                <%-- Lien pour déplier le Profil souhaité  --%>
	                <div data-target="#presentation" data-toggle="collapse" class="panel-heading">          
	                    <div class="panel-title title-niv1">                    
	                        <a onclick="return false;" href="#presentation">
	                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
	                            Présentation                                                                                      
	                        </a>
	                    </div>
	                </div>               
	                <%-- Contenu de Présentation --%>
	                <div  class="panel-collapse panel-niv-1 collapse in" id="presentation">
	                    <%-- Contexte  --%>
	                    <jalios:if predicate='<%= Util.notEmpty(obj.getContexte()) %>'>
		                    <h2>Contexte</h2>                                           
		                    <jalios:wysiwyg><%= obj.getContexte() %></jalios:wysiwyg>                  
		                </jalios:if>
		                
	                    <%-- Public(s) cible(s) --%>
	                    <jalios:if predicate='<%= Util.notEmpty(obj.getPublicCible()) %>'>
	                    	<h2>Public(s) cible(s)</h2>                    
	                    	<jalios:wysiwyg><%= obj.getPublicCible() %></jalios:wysiwyg>
	                    </jalios:if>
	                    
	                    <%-- Pré-requis --%>
	                    <jalios:if predicate="<%= Util.notEmpty(obj.getPrerequis()) %>">
		                    <h2>Pré-requis</h2>  
		                    <jalios:wysiwyg><%= obj.getPrerequis() %></jalios:wysiwyg>
	                    </jalios:if>
	                    
	                    <%-- Niveau --%>
	                    <jalios:if predicate="<%= Util.notEmpty(obj.getNiveau()) %>">
                        	<h2>Niveau</h2>  
                        	<p><%= obj.getNiveau() %></p>
                        </jalios:if>
                        
                        <%-- Objectifs --%>
                        <jalios:if predicate='<%= Util.notEmpty(obj.getResumeObjectifs()) %>'>
                        	<h2>Objectifs</h2>  
                        	<jalios:wysiwyg><%= obj.getResumeObjectifs() %></jalios:wysiwyg>
                        </jalios:if>
                        
                        <%-- Cout --%>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getCoutDeLaFormation()) %>">
                            <h2>Coût</h2>  
                            <p><%= obj.getCoutDeLaFormation() %></p>
                        </jalios:if>
	                </div>               
	            </div>
	            
	            <%-- Programme --%>
                <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">                              
                    <%-- Lien pour déplier le Profil souhaité  --%>
                    <div data-target="#programme" data-toggle="collapse" class="panel-heading collapsed">          
                        <div class="panel-title title-niv1">                    
                            <a onclick="return false;" href="#programme">
                                <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                                Programme                                                                                      
                            </a>
                        </div>
                    </div>               
                    <%-- Contenu de Programme --%>
                    <div  class="panel-collapse panel-niv-1 collapse" id="programme" style="height: 0px;">
                        <%-- Contenu  --%>
                        <jalios:if predicate='<%= Util.notEmpty(obj.getContenu()) %>'>
                        	<h2>Contenu</h2>                                       
                        	<jalios:wysiwyg><%= obj.getContenu() %></jalios:wysiwyg>
                        </jalios:if>
                                          
                        <%-- Méthode --%>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getMethodePedagogique()) %>">
                            <h2>Méthode pédagogique</h2>                    
                            <jalios:wysiwyg><%= obj.getMethodePedagogique() %></jalios:wysiwyg>
                        </jalios:if>
                        
                        <%-- Support --%>
                        <h2>Support pédagogique</h2>  
                        <p><%= obj.getSupportPedagogiqueFourniLabel(userLang) %></p>                    
                        
                        <%-- Durée --%>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getDuree()) %>">                       
                            <h2>Durée</h2>  
                            <p><%= obj.getDuree() %></p>
                        </jalios:if>
                        
                        <%-- Profil intervenant --%>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getProfilIntervenant()) %>"> 
                            <h2>Profil intervenant</h2>  
                            <p><%= obj.getProfilIntervenant() %></p>
                        </jalios:if>
                    </div>                         
                </div>
                <%-- Infos pratiques --%>
                <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">                              
                    <%-- Lien pour déplier le Profil souhaité  --%>
                    <div data-target="#info" data-toggle="collapse" class="panel-heading collapsed">          
                        <div class="panel-title title-niv1">                    
                            <a onclick="return false;" href="#info">
                                <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                                Infos pratiques                                                                                      
                            </a>
                        </div>
                    </div>               
                    <%-- Contenu Infos pratiques --%>
                    <div  class="panel-collapse panel-niv-1 collapse" id="info" style="height: 0px;">
                        <%-- Modalités d'inscriptions --%>
                        <jalios:if predicate='<%= Util.notEmpty(obj.getModalitesDinscription()) %>'>
                        	<h2>Modalités d'inscription</h2>                                        
                        	<jalios:wysiwyg><%= obj.getModalitesDinscription() %></jalios:wysiwyg>                  
                        </jalios:if>
                        
                        <%-- Période --%>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getPeriodicite()) %>">
                            <h2>Périodicité</h2>                    
                            <p><%= obj.getPeriodicite() %></p>
                        </jalios:if>
                        
                        <%-- Lieu --%>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getLieu()) %>">
                            <h2>Lieu</h2>  
                            <p><%= obj.getLieu() %></p>
                        </jalios:if>
                    </div>                         
                </div>
                
				<%--Inclusion de la carte --%>
	    		<jalios:if predicate="<%= isPubGeo %>">
	        		<% request.setAttribute("gMapsType", "large"); %>
                	<%@ include file="/plugins/GoogleMapsPlusPlugin/jsp/doGoogleMapsPublication.jspf" %>
        		</jalios:if>
  	            
                     
            </div>
        </section> 
        
        <jalios:if predicate="<%= hasAside %>">
        
            <aside class="col-md-4">
               
               <%-- Contact pédagogique --%>
               <jalios:if predicate='<%= Util.notEmpty(obj.getContactsResponsablesPedagogiques()) || Util.notEmpty(obj.getContactUnitesOrga())%>'>
	               <section class="flat-color flatColorSkin">
				        <div class='skinHeader'>
				            <%-- Affichage du titre --%>
				            <h1><%= glp("jcmsplugin.intranetEditorial.ficheformation.contact", Util.getSize(obj.getContactsResponsablesPedagogiques())+Util.getSize(obj.getContactUnitesOrga())) %></h1>        
				        </div> 			         
				        <div class="skinContent">
				           <div class="pqf-contacts">
				           
				              <%-- MEMBRES --%>		
				              <% if (Util.notEmpty(obj.getContactsResponsablesPedagogiques())) { %>	             
				                  <jalios:foreach name="itMember" array="<%= obj.getContactsResponsablesPedagogiques() %>" type="Member">
				                     <jalios:if predicate="<%= Util.notEmpty(itMember) %>">
				                        <%@ include file="../../types/Contacts/doContactItemBoxListItem.jspf" %>
				                     </jalios:if> 
				                  </jalios:foreach>
			                  <% } %>
			                  
			                  <%-- GROUPES --%>
			                  <% if (Util.notEmpty(obj.getContactUnitesOrga())) { %>
				                  <jalios:foreach name="itGroup" array="<%= obj.getContactUnitesOrga() %>" type="Group">
				                     <jalios:if predicate="<%= Util.notEmpty(itGroup) %>">                      				          
								        <%@ include file="../../types/Contacts/doContactItemGroupBoxListItem.jspf" %>				                                                            
				                     </jalios:if> 
	                  </jalios:foreach>
			                  <% } %>					              
				           </div>
				        </div>
				   </section>
			   </jalios:if>
			   
			   
               <%-- Portlet "Parcours métiers associés" --%>
			   <jalios:include id='<%=channel.getProperty("$id.jcmsplugin.intraneteditorial.parcoursMetierAssocies.portlet") %>'/>	
			   
			   <%-- Images --%>
			   <jalios:if predicate="<%= Util.notEmpty(obj.getPhotoS()) %>">
	               <section class="titleThinLineSkin">
	                    <div class='skinHeader'>
	                        <%-- Affichage du titre --%>
	                        <h1><%= glp("jcmsplugin.intranetEditorial.ficheformation.photo", Util.getSize(obj.getPhotoS())) %></h1>          
	                    </div>
	                    <div class="separateur" style="margin-bottom: 15px;"></div>
	                    <div class="skinContent">
	                       <div style="text-align: center;">
	                          <div class="wysiwyg">
	                             <jalios:foreach array="<%= obj.getPhotoS() %>" name="itImage" type="String">
	                                <jalios:image src="<%= itImage %>" alt="" />
	                                <div class="separateur" style="margin: 15px 0;"></div>
	                             </jalios:foreach>
	                          </div>
	                       </div>
	                    </div>                  
	               </section>
               </jalios:if>
			   
			   
			   <%-- Vidéos --%>
			   <jalios:if predicate="<%= Util.notEmpty(obj.getVideoS())  %>">
	               <section class="titleThinLineSkin">
	                    <div class='skinHeader'>
	                        <%-- Affichage du titre --%>
	                        <h1><%= glp("jcmsplugin.intranetEditorial.ficheformation.video", Util.getSize(obj.getVideoS())) %></h1>         
	                    </div>
	                    <div class="separateur" style="margin-bottom: 15px;"></div>
	                    <div class="skinContent">
	                       <div class="pqf-contenuLibre">
	                          <div class="wysiwyg">
	                             <jalios:foreach array="<%= obj.getVideoS() %>" name="itVideo" type="Publication">
	                                <% 
	                                jcmsContext.setTemplateUsage(TypeTemplateEntry.USAGE_DISPLAY_FULL);
	                                Publication clone = (Publication) itVideo.getUpdateInstance();   
	                                clone.setTemplate("full.embed");
	                                request.setAttribute(PortalManager.PORTAL_PUBLICATION, clone);
                                    String displayTemplate = "/" + clone.getTemplatePath(jcmsContext);
                                    %>
                                    <jsp:include page="<%= displayTemplate %>" flush="true" />
	                                <div class="separateur" style="margin: 15px 0;"></div>
	                             </jalios:foreach>
	                             <% request.setAttribute(PortalManager.PORTAL_PUBLICATION, obj); %>
	                          </div>
	                       </div>
	                    </div>
	               </section>
               </jalios:if>
                                
               
                <!-- Documents utiles -->
				<jalios:if predicate="<%= Util.notEmpty(obj.getDocumentsUtiless())  %>">
				    <section class="titleBorderSkin">
				      <div class='skinHeader'>
				        <%-- Affichage du titre --%>
				        <h1><%= glp("jcmsplugin.intranetEditorial.ficheformation.document", Util.getSize(obj.getDocumentsUtiless())) %></h1>                      
				      </div>                      
				      <%-- Filet haut --%>
				      <div class="yellow-border"></div>                   
				      <div class="skinContent">
				        <div class="pqf-simple-list">
				           <ul class="item-box-list item-box-simple-list">
				              <jalios:foreach name="itDoc" array="<%= obj.getDocumentsUtiless() %>" type="FileDocument">                                 
				                 <jalios:if predicate="<%= Util.notEmpty(itDoc) %>">                                 
				                     <li class="item-list item-simple-list">                                        
				                        <div class="icon">
				                          <jalios:dataicon data="<%= itDoc %>" /> 
				                        </div>                                  
				                        <div class="info">                                  
				                          <div class="titre">
				                              <jalios:link data="<%= itDoc %>" />
				                          </div>                                                                            
				                          <p class="sub-info">
				                              <%-- Date --%>                                          
				                              <jalios:date format="dd/MM/yyyy" date="<%= itDoc.getMdate() %>" />                                             
				                              <%-- Poids du document --%>
				                              - <span class="filesize"><jalios:filesize doc="<%= itDoc %>" /></span>                                                                              
				                          </p>                                                                                                                  
				                        </div>                                      
				                     </li>                               
				                 </jalios:if>                                
				              </jalios:foreach>
				           </ul>                        
				        </div>
				      </div>                      
				      <%-- Liseré bas --%>     
				      <div class="separateur"></div>                                          
				    </section>                              
				</jalios:if>
               
                                       
            </aside>
            
     	</jalios:if>
        
        
    </article>
    
    
    <div class="clear"></div>   

</div>