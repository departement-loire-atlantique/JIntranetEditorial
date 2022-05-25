<%@page import="com.jalios.jcmsplugin.googlemaps.GoogleMapsManager"%><%
%><%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%
%><% 
AVPImport pub = (AVPImport)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

request.setAttribute("fullIsHidden", true);

String catColor = currentCategory.getAvailableColor();

boolean hasAside = true;
%><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<%-- <%@ include file='/plugins/GoogleMapsPlugin/jsp/doGoogleMapsConfig.jspf' %> --%>

<%
// Les catégories d'emplois en chaine de caractères
String categoryPoste = pub.getCategorieDemploi(loggedMember).toString().substring(1, pub.getCategorieDemploi(loggedMember).toString().length() -1 );

// Indique si la publication à une position géolocalisée
boolean isPubGeo =  Util.notEmpty(GoogleMapsManager.getGeolocation(pub));
%>

<div class="fullDisplay AVP <%= pub.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>">

  <article class="row-fluid">
    
    <section class='<%= hasAside ? "col-md-8" : "col-md-12" %>'> 
        
        <h1 class="main-title"><%= pub.getLibellePoste() %></h1>
        
        <span class="surlignageJaune" style="float:right;"><%= pub.getVille() %> - <%= categoryPoste  %> <%=Util.notEmpty(pub.getVacantOuPropose(loggedMember)) ? " - " + Util.getFirst(pub.getVacantOuPropose(loggedMember)) : "" %></span>
        <div class="clear"></div>
        
        <div class="infos">
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.poste") %> :</span> <%= pub.getNumeroDePoste()  %></div>	        
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.depot") %> :</span> <jalios:date date="<%= pub.getDateLimiteDeDepot() %>" format='<%= "dd MMMM yyyy" %>' /> </div> 	        
	        <%-- Mots Clés --%>
	        <% TreeSet<Category> motsClesSet = pub.getMotscles(loggedMember); %>
	        <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
	            <div class="search-result-meta search-result-categories">
	              <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
	              <% String type =  pub.getClass().getCanonicalName(); %>
                  <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
	            </div>
	        </jalios:if>	        
	        <div><span class="lib">Rattachement hiérarchique :</span> <%= pub.getFonctionResponsable() %></div>	        
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.rattachement") %> :</span>
	        <%=Util.notEmpty(pub.getDelegation(loggedMember)) ? Util.getFirst(pub.getDelegation(loggedMember)) : ""%>
	        <%=Util.notEmpty(pub.getDirectiongenerale()) ? " > " + pub.getDirectiongenerale() : "" %>
	        <%=Util.notEmpty(pub.getDirection()) ? " > " + pub.getDirection() : "" %>
	        <%=Util.notEmpty(pub.getSousdirection()) ? " > " + pub.getSousdirection() : "" %>
	        <%=Util.notEmpty(pub.getService()) ? " > " + pub.getService() : "" %>
	        <%=Util.notEmpty(pub.getUnite()) ? " > " + pub.getUnite() : "" %>
	        
	        
	        </div>	        
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.lieu") %> :</span> <%= pub.getRue()%>, <%= pub.getCp() %> <%= pub.getVille() %> </div>
	       	<jalios:if predicate="<%= Util.notEmpty(pub.getLibelleMetier()) %>">
	        	<div><span class="lib">Libellé métier : </span> <%=pub.getLibelleMetier() %></div>
	        </jalios:if>
	        
        </div>

    
        <%-- Menu déroulant --%>
        <div class="verticalMenun navigation-section menu-welcome" style="margin-top : 30px;">               
            <%-- Missions --%>
            <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">                              
                <%-- Lien pour déplier la Missions --%>             
                <div class="panel-heading" data-toggle="collapse" data-parent="#" data-target="#missions">          
                    <div class="panel-title title-niv1">                    
                        <a href="#missions" onclick="return false;" id="anonymous_element_1">
                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                            Missions
                        </a>
                    </div>
                </div>
                <%-- Contenu de  missions --%>
                <div id="missions" class="panel-collapse panel-niv-1 collapse in">
                    <jalios:wysiwyg><%= pub.getMission() %></jalios:wysiwyg>
                </div>
             </div>
             
            <%-- Activités --%>
            <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">
                <%-- Lien pour déplier la Missions --%>
                <div data-target="#activites" data-parent="#" data-toggle="collapse" class="panel-heading">
                    <div class="panel-title title-niv1">
                        <a onclick="return false;" href="#activites">
                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                            Activités
                        </a>
                    </div>
                </div>
                <%-- Contenu de  missions --%>
                <div id="activites" class="panel-collapse panel-niv-1 collapse in">
                    <jalios:wysiwyg><%= pub.getActivites() %></jalios:wysiwyg>
                </div>               
            </div>
            
            <%-- Autre --%>
            <jalios:if predicate='<%= (Util.notEmpty(pub.getParticularites1()) && !pub.getParticularites1().equals("Aucune"))||Util.notEmpty(pub.getParticularites2())||
	            	Util.notEmpty(pub.getParticularites3())||Util.notEmpty(pub.getParticularites4())||Util.notEmpty(pub.getParticularites5())||
	            	Util.notEmpty(pub.getParticularites6())||Util.notEmpty(pub.getParticularitesAutre()) || 
	            	Util.notEmpty(pub.getResidence()) || 
	            	(Util.notEmpty(pub.getNbi()) && pub.getNbi().equals("NBI"))
	            	%>'>
            
            <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">
                <%-- Lien pour déplier le munu "Autre" --%>
                <div data-target="#autres" data-parent="#" data-toggle="collapse" class="panel-heading">
                    <div class="panel-title title-niv1">
                        <a onclick="return false;" href="#autres">
                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                            Autres
                        </a>
                    </div>
                </div>
                <%-- Contenu de "Autres" --%>
                <div id="autres" class="panel-collapse panel-niv-1 collapse in">
	            	<jalios:if predicate='<%= Util.notEmpty(pub.getResidence()) %>'>
	            		<h2>Indemnité de résidence</h2>
	            		<p><%= pub.getResidence() %></p>
	            	</jalios:if>
	            	<jalios:if predicate='<%= Util.notEmpty(pub.getNbi()) && pub.getNbi().equals("NBI") %>'>
	            		<h2>NBI</h2>
	            		<p>Ce poste donne droit à l'attribution de la NBI</p>
	            	</jalios:if>
	            	<jalios:if predicate='<%= (Util.notEmpty(pub.getParticularites1()) && !pub.getParticularites1().equals("Aucune"))||Util.notEmpty(pub.getParticularites2())||
	            	Util.notEmpty(pub.getParticularites3())||Util.notEmpty(pub.getParticularites4())||Util.notEmpty(pub.getParticularites5())||
	            	Util.notEmpty(pub.getParticularites6())||Util.notEmpty(pub.getParticularitesAutre()) %>'>
	            		<h2>Caractéristiques</h2>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularites1()) && !pub.getParticularites1().equals("Aucune") %>'>
	            			<p><%= pub.getParticularites1() %></p>
	            		</jalios:if>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularites2())%>'>
	            			<p><%= pub.getParticularites2() %></p>
	            		</jalios:if>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularites3())%>'>
	            			<p><%= pub.getParticularites3() %></p>
	            		</jalios:if>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularites4())%>'>
	            			<p><%= pub.getParticularites4() %></p>
	            		</jalios:if>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularites5())%>'>
	            			<p><%= pub.getParticularites5() %></p>
	            		</jalios:if>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularites6())%>'>
	            			<p><%= pub.getParticularites6() %></p>
	            		</jalios:if>
	            		<jalios:if predicate='<%= Util.notEmpty(pub.getParticularitesAutre())%>'>
	            			<p><%= pub.getParticularitesAutre() %></p>
	            		</jalios:if>
	            	</jalios:if>
                    
                </div>               
            </div>
            </jalios:if>
            
            <%-- Profil souhaité --%>
            <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">                              
                <%-- Lien pour déplier le Profil souhaité  --%>
                <div data-target="#profil" data-parent="#" data-toggle="collapse" class="panel-heading">          
                    <div class="panel-title title-niv1">                    
                        <a onclick="return false;" href="#profil">
                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                            Profil souhaité                                                                                      
                        </a>
                    </div>
                </div>               
                <%-- Contenu de  Profil souhaité --%>
                <div id="profil" class="panel-collapse panel-niv-1 collapse in">
                    <%-- Filière  --%>
                    <h2>Filière</h2>                                           
                    <p><%= pub.getFiliere() %></p>                 
                    <%-- Catégorie --%>
                    <h2>Catégorie</h2>                    
                    <p><%= categoryPoste %></p>
                    <%-- Grade --%>
                    <h2>Grade</h2>  
                    <p><%= pub.getGrade() %></p>
                </div>               
            </div>
            
            <%-- Compétences attendues --%>
            <div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">                              
                <%-- Lien pour déplier le Profil souhaité  --%>
                <div data-target="#competences" data-parent="#" data-toggle="collapse" class="panel-heading">          
                    <div class="panel-title title-niv1">                    
                        <a onclick="return false;" href="#competences">
                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
                            Compétences attendues                                                                                      
                        </a>
                    </div>
                </div>               
                <%-- Contenu de  Profil souhaité  --%>
                <div id="competences" class="panel-collapse panel-niv-1 collapse in">                    

					<h2>Compétences métiers</h2>
					<%= pub.getCompetencesMetier()%>
					
					<h2>Compétences travailler ensemble</h2>
					<%= pub.getCompetencesTravailler()%>
					
					<h2>Compétences numériques</h2>
					<%= pub.getCompetencesNumeriques()%>
					
                </div>               
            </div>                                      
        </div>

  	
  	</section>
  	
  	<jalios:if predicate="<%= hasAside %>">
        
		<aside class="col-md-4">
			<!-- Postuler en ligne -->
			<a href="http://mobilite-agents.loire-atlantique.fr" target="blank" class="lien-recherche">Postuler en ligne</a>
			
			<!-- Liste de contacts -->
			<jalios:if predicate="<%= Util.notEmpty(pub.getTitreListeDeContacts()) && (Util.notEmpty(pub.getContactsAgents()) || Util.notEmpty(pub.getContactsUniteOrga()) || Util.notEmpty(pub.getContacts()) ||  Util.notEmpty(pub.getComplementContacts())) %>">
				<div style="margin-top : 30px;">
					<%@ include file="../../jsp/aside/encadreContacts.jspf" %>
				</div>
			</jalios:if> 
			
			
			<!-- Fiches métier utiles -->
			<jalios:if predicate="<%= Util.notEmpty(pub.getFicheMetier()) %>">
			    <section class="titleThinLineSkin">
			      <div class='skinHeader'>
			        <%-- Affichage du titre --%>
			        <h1>Fiches métiers utiles</h1>                      
			      </div>
			      <div style="margin-bottom: 15px;" class="separateur"></div>
                 
			      <div class="skinContent">
			        <div class="pqf-simple-list">
			           <ul class="item-box-list item-box-simple-list">
			              <jalios:foreach name="itFiche" array="<%= pub.getFicheMetier() %>" type="generated.FicheMetier">                                 
			                 <jalios:if predicate='<%= itFiche != null && itFiche.canBeReadBy(loggedMember) %>'>                                
			                     <li class="item-list item-simple-list">                                        
			                        <div class="icon">
			                          <jalios:dataicon data="<%= itFiche %>" /> 
			                        </div>                                  
			                        <div class="info">                                  
			                          <div class="titre">
			                              <jalios:link data="<%= itFiche %>" />
			                          </div>                                                                            
			                          <p class="sub-info">
			                              <%-- Date --%>                                          
			                              <jalios:date format="dd/MM/yyyy" date="<%= itFiche.getMdate() %>" />                                             
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
