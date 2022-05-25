<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: FicheMetier display page
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%
%><% FicheMetier obj = (FicheMetier)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%

request.setAttribute("fullIsHidden", true);

String catColor = currentCategory.getAvailableColor();

boolean hasAside = Util.notEmpty(obj.getParcoursAssocie(loggedMember)) || 
					Util.notEmpty(obj.getLienInterne()) ||
					Util.notEmpty(obj.getLienLibre());


%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheMetier <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">

    <article class="row-fluid">	  
        <section class='<%= hasAside ? "col-md-8" : "col-md-12" %>'> 
        
        	<span style="font-size:18px;color:#fff;background-color:#000;padding:4px;margin-bottom:10px;display:inline-block;">Fiche métier</span>
         
	        <h1 class="main-title"><%= obj.getTitle() %></h1>
	        
	        <div class="clear"></div>

			<%-- Menu déroulant --%>
	        <div class="verticalMenun navigation-section menu-welcome">
	        
	            <%-- Missions --%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getMissions()) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#missions" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#missions">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            <%= channel.getTypeFieldLabel(FicheMetier.class, "missions", userLang) %>
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu des missions --%>
		                <div  class="panel-collapse panel-niv-1 collapse in" id="missions">
							<jalios:wysiwyg><%= obj.getMissions() %></jalios:wysiwyg>            
		                </div>               
		            </div> 
	            </jalios:if>   
	            
	            <%-- Activités --%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getActivites()) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#activites" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#activites">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            <%= channel.getTypeFieldLabel(FicheMetier.class, "activites", userLang) %>
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu des activités --%>
		                <div  class="panel-collapse panel-niv-1 collapse in" id="activites">
							<jalios:wysiwyg><%= obj.getActivites() %></jalios:wysiwyg>            
		                </div>               
		            </div> 
	            </jalios:if> 
	            
	            <%-- Catégorie --%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getCategorieDemploi(loggedMember)) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#categorie" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#categorie">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            <%= channel.getTypeFieldLabel(FicheMetier.class, "categorieDemploi", userLang) %>
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu de la catégorie --%>
		                <div  class="panel-collapse panel-niv-1 collapse in" id="categorie">
			               	<%  
	            			String categoryPoste = obj.getCategorieDemploi(loggedMember).toString().substring(1, obj.getCategorieDemploi(loggedMember).toString().length() -1 );
	            			%>
	            			<%= categoryPoste  %>
		                </div>               
		            </div> 
	            </jalios:if> 
	        
	            <%-- Filière --%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getCategorieDemploi(loggedMember)) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#filiere" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#filiere">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            <%= channel.getTypeFieldLabel(FicheMetier.class, "filiere", userLang) %>
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu de la filière --%>
		                <div class="panel-collapse panel-niv-1 collapse in" id="filiere">
							<jalios:foreach collection="<%= obj.getFiliere(loggedMember) %>" type="Category" name="itCat" counter="itCatCounter">
								<%=itCat.getName(userLang)%><%= itCatCounter < obj.getFiliere(loggedMember).size() ? ", " :""%>
            				</jalios:foreach>            
		                </div>               
		            </div> 
	            </jalios:if> 	        
	        
	            <%-- Conditions d'exercice --%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getConditionsExercice()) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#conditions" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#conditions">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            <%= channel.getTypeFieldLabel(FicheMetier.class, "conditionsExercice", userLang) %>
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu des conditions d'exercice --%>
		                <div class="panel-collapse panel-niv-1 collapse in" id="conditions">
							<jalios:wysiwyg><%= obj.getConditionsExercice() %></jalios:wysiwyg>             
		                </div>               
		            </div> 
	            </jalios:if> 	        
	  
	            <%-- Compétences --%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getCompetencesSpecifiques())||Util.isEmpty(obj.getCompetencesRelationnelles()) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#competences" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#competences">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            Compétences
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu des compétences --%>
		                <div class="panel-collapse panel-niv-1 collapse in" id="competences">
		                	
            				<jalios:if predicate='<%= Util.notEmpty(obj.getCompetencesSpecifiques()) %>'>
            					<h2><%= channel.getTypeFieldLabel(FicheMetier.class, "competencesSpecifiques", userLang) %></h2>
            					<jalios:wysiwyg><%= obj.getCompetencesSpecifiques() %></jalios:wysiwyg>            
            				</jalios:if>
							
							<jalios:if predicate='<%= Util.notEmpty(obj.getCompetencesRelationnelles()) %>'>
								<h2><%= channel.getTypeFieldLabel(FicheMetier.class, "competencesRelationnelles", userLang) %></h2>
								<jalios:wysiwyg><%= obj.getCompetencesRelationnelles() %></jalios:wysiwyg>
							</jalios:if>            
		                </div>               
		            </div> 
	            </jalios:if>
	            
	            <%-- Niveau de compétences attendu--%>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getNiveauCompetenceAttendu()) %>'>
		            <div data-jalios-collapse-toggle="caret" class="jalios-accordion panel-group">                              
		                <%-- Lien pour déplier le Profil souhaité  --%>
		                <div data-target="#niveauCompetences" data-parent="#" data-toggle="collapse" class="panel-heading">          
		                    <div class="panel-title title-niv1">                    
		                        <a onclick="return false;" href="#niveauCompetences">
		                            <div class="chevron-menu" style="background-color: <%= catColor %>"></div>
		                            Compétences
		                        </a>
		                    </div>
		                </div>               
		                <%-- Contenu du niveau de compétences --%>
		                <div class="panel-collapse panel-niv-1 collapse in" id="niveauCompetences">
				            <%= obj.getNiveauCompetenceAttendu() %>
		                </div>               
		            </div> 
	            </jalios:if>         

            
	        </div> 
        
        </section>


		<jalios:if predicate="<%= hasAside %>">
        
			<aside class="col-md-4">
			   
				<%-- Portlet "Parcours métiers associés" --%>
			   	<jalios:include id='<%=channel.getProperty("$id.jcmsplugin.intraneteditorial.parcoursMetierAssocies.portlet") %>'/>
			   
			   	<%-- Liste de liens (adapté de IntranetEditorialPlugin/jsp/aside/encadre.jspf) --%>
				<jalios:if predicate="<%= Util.notEmpty(obj.getLienInterne()) || Util.notEmpty(obj.getLienLibre()) %>">
				    <section class="titleBorderSkin">
				      <div class='skinHeader'>
				        <%-- Affichage du titre --%>
				        <h1>Liens utiles</h1>
				      </div>
				      <%-- Filet haut --%>
				      <div class="blue-border" style="background-color: <%= catColor %>"></div>                     
				      <div class="skinContent">
				        <div class="pqf-simple-list">                                            
				          <ul class="item-box-list item-box-simple-list">                                                                                  
				            <!-- Liens internes -->
				            <jalios:if predicate="<%= Util.notEmpty(obj.getLienInterne()) %>">                                            
				                <% int index = 0; %>
				                    <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getLienInterne() %>">
				                        <% String libelle = ""; %>
				                        <jalios:if predicate='<%= itData != null && itData.canBeReadBy(loggedMember) %>'>
				                            <jalios:if predicate='<%= obj.getLibelleLienInterne().length > index %>'>
				                                <% libelle = obj.getLibelleLienInterne()[index]; %>
				                            </jalios:if>
				                             <li class="item-list item-simple-list">                                         
				                                <div class="icon">
				                                   <jalios:dataicon data="<%= itData %>" /> 
				                                </div>                                  
				                                <div class="info"> 
				                                   <div class="titre">                                       
				                                       <a href="<jalios:url data='<%= itData %>' />"><%= Util.notEmpty(libelle) ? libelle : itData %></a>
				                                   </div>
				                                </div>
				                            </li>
				                        </jalios:if>
				                        <% index++; %>
				                    </jalios:foreach>                                         
				            </jalios:if>
				            
				            
				            <!-- Liens libres -->
				            <jalios:if predicate="<%= Util.notEmpty(obj.getLienLibre()) %>">            
				                <% int index = 0; %>
				                <jalios:foreach name="urlLien" type="String" array="<%= obj.getLienLibre() %>">
				                    <% String libelle = ""; %>
				                    <jalios:if predicate='<%= Util.notEmpty(urlLien) %>'>
				                        <jalios:if predicate='<%= obj.getLibelleLienLibre().length > index %>'>
				                            <% libelle = obj.getLibelleLienLibre()[index]; %>
				                        </jalios:if>
				                        <li class="item-list item-simple-list">                                         
				                            <div class="icon">
				                               <jalios:icon src='<%= "plugins/IntranetVisualIdentityPlugin/images/icon/lien_externe.png" %>' /> 
				                            </div>                                  
				                            <div class="info"> 
				                               <div class="titre">                                      
				                                 <a href='<%= urlLien %>'><%= Util.notEmpty(libelle) ? libelle : urlLien %></a>
				                               </div>
				                            </div>                                          
				                        </li>
				                    </jalios:if>
				                    <% index++; %>
				                </jalios:foreach>           
				            </jalios:if>                                                        
				          </ul> 
				                                  
				        </div>
				      </div> 
				      <%-- Liseré bas --%>     
				      <div class="separateur"></div>                                                               
				    </section>
				</jalios:if>
				
				<%-- Focus "Voir la liste des parcours métiers" --%>
			   	<jalios:include id='<%=channel.getProperty("$id.jcmsplugin.intraneteditorial.focusListeParcoursMetier.id") %>'/>  

               
                                       
            </aside>
            
     	</jalios:if>



	</article>
	
 	<div class="clear"></div>  
</div>
