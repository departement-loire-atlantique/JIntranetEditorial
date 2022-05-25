<%@page import="com.jalios.jcmsplugin.googlemaps.GoogleMapsManager"%><%
%><%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%
%><% 
AVP pub = (AVP)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

request.setAttribute("fullIsHidden", true);

String catColor = currentCategory.getAvailableColor();

boolean hasAside = true;
%><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<%-- <%@ include file='/plugins/GoogleMapsPlugin/jsp/doGoogleMapsConfig.jspf' %> --%>

<%
// Les catégories d'emplois en chaine de caractères
String categoryPoste = pub.getCategorieDemploi(loggedMember).toString().substring(1, pub.getCategorieDemploi(loggedMember).toString().length() -1 );

//Les cadres d'emplois (grades) en chaine de caractères
String gradesPoste = pub.getGrade(loggedMember).toString().substring(1, pub.getGrade(loggedMember).toString().length() -1 );


// Indique si la publication à une position géolocalisée
boolean isPubGeo =  Util.notEmpty(GoogleMapsManager.getGeolocation(pub));
%>

<div class="fullDisplay AVP <%= pub.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>">

  <article class="row-fluid">
    
    <section class='<%= hasAside ? "col-md-8" : "col-md-12" %>'> 
       	<h1 class="main-title"><%= pub.getTitle() %></h1>
			<div class="containerHead">      	
				<jalios:if predicate="<%= Util.notEmpty(pub.getTexteentete()) %>">
		        	<p><%=pub.getTexteentete()%></p>
	        	</jalios:if>
	        	<p>
        			<span class="surlignageJaune"><%= Util.getFirst(pub.getVille(loggedMember)) %> - <%= categoryPoste  %></span>
        		</p>
        	</div>

        <div class="clear"></div>
        
        <div class="infos">
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.poste") %> :</span> <%= pub.getNumeroDePoste()  %></div>
	        <jalios:if predicate="<%= Util.notEmpty(pub.getRifseep(loggedMember)) %>">
	        	<div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.rifseep") %> :</span> <%= Util.getFirst(pub.getRifseep(loggedMember))  %></div>
			</jalios:if>	        
	        <div><%= glp("jcmsplugin.intranetEditorial.avp.depot") %> :  <jalios:date date="<%= pub.getDateLimiteDeDepot() %>" format='<%= "dd MMMM yyyy" %>' /> </div> 	        
	        <%-- Mots Clés --%>
	        <% TreeSet<Category> motsClesSet = pub.getMotscles(loggedMember); %>
	        <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
	            <div class="search-result-meta search-result-categories">
	              <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
	              <% String type =  pub.getClass().getCanonicalName(); %>
                  <%@ include file="/plugins/IntranetEditorialPlugin/jsp/include/doCategoryList.jspf"  %>
	            </div>
	        </jalios:if>	        
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.position") %> :</span> <%= pub.getPositionHierarchique() %></div>	        
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.rattachement") %> :</span> <%= Util.getFirst(pub.getDirectiondelegation(loggedMember)) %> <%=Util.notEmpty(pub.getUo()) ? " / " +pub.getUo() : "" %></div>	        
	        <div><span class="lib"><%= glp("jcmsplugin.intranetEditorial.avp.lieu") %> :</span> <%= pub.getRue()%>, <%= pub.getCp() %> <%= Util.getFirst(pub.getVille(loggedMember)) %> </div>
        </div>

		<%--Inclusion de la carte --%>
	    <jalios:if predicate="<%= isPubGeo %>">
	        <%AVP obj = pub; %>
	        <% request.setAttribute("gMapsType", "large"); %>
	        <%@ include file="/plugins/GoogleMapsPlusPlugin/jsp/doGoogleMapsPublication.jspf" %>
        </jalios:if>
    
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
                    <jalios:wysiwyg><%= pub.getDetailActivite() %></jalios:wysiwyg>
                </div>               
            </div>
            
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
                    <p><%= Util.getFirst(pub.getFiliere(loggedMember)) %></p>                 
                    <%-- Catégorie --%>
                    <h2>Catégorie</h2>                    
                    <p><%= categoryPoste %></p>
                    <%-- Grade --%>
                    <h2>Cadre d'emploi</h2>
       				<p><%= gradesPoste %></p>

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
                    <%-- Connaissances et expériences  --%>
                    <h2>Connaissances et expériences</h2>                                           
                    <%= pub.getConnaissancesEtExperiences()%>                 
                    <%-- Conditions à remplir --%>
                    <h2>Conditions à remplir</h2>                    
                    <%= pub.getConditionsARemplir() %>
                </div>               
            </div>                                      
        </div>

  	
  	</section>
  	
  	<jalios:if predicate="<%= hasAside %>">
        
		<aside class="col-md-4">
			<!-- Postuler en ligne -->
			<!-- Les AVP de l'espace Planet ne sont accessibles qu'aux agents des collèges et renvoient vers un formulaire spécifique -->
			<jalios:select>
				<jalios:if predicate="<%=Util.notEmpty(pub.getReserveAgentsDesColleges(loggedMember)) %>">
					<a href="<%=channel.getProperty("jcmsplugin.intraneteditorial.avp.lienformulairecandidatureagentscolleges") %>" target="blank" class="lien-recherche">Postuler en ligne</a>
				</jalios:if>
				<jalios:default>
					<a href="/FormulaireCandidatureInterne" class="lien-recherche">Postuler en ligne</a>
				</jalios:default>
			</jalios:select>
			
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
