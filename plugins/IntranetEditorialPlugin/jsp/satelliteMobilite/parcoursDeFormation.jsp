<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%


Category rootCategory = currentCategory;
Set navigateSet = new TreeSet(Category.getOrderComparator(userLang));
navigateSet.addAll(rootCategory.getChildrenSet());

String color = currentCategory.getAvailableColor();

%>
<section class="navigation-category-header">
	<h1><%=rootCategory.getName() %></h1>
	
	<div class="verticalMenun navigation-section menu-welcome menu-welcome-suivi">
	
		<div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">  

			<jalios:foreach collection="<%= navigateSet %>" name="itCatNiv1" type="Category">
		    	<%-- Requête sur les FicheFormation de la catégorie en cours d'itération --%>
		    	<%
		    	String queryStringFicheFormation = "types=generated.FicheFormation&cids="+itCatNiv1.getId();
		    	%>
		    	<jalios:query name="resultSet" queryString="<%=queryStringFicheFormation%>" comparator="<%= Publication.getTitleComparator() %>" />
			    <jalios:if predicate='<%=!resultSet.isEmpty() %>'>
					<%-- Lien pour déplier la catégorie --%>
				    <div data-target="#<%= itCatNiv1.getId() %>" data-parent="#" data-toggle="collapse" class="panel-heading">
				        
				        <div class="panel-title title-niv1">
					        <a class="toggle-container-accessi" onclick="return false;" href="#<%= itCatNiv1.getId() %>" title="Ouvrir <%= itCatNiv1.getName() %>">
					           <div class="chevron-menu" style="background-color: <%= color %>"></div>
					           <%= itCatNiv1 %>			            
					       </a>
						</div>
					</div>
					
					<%-- Contenu de la catégorie dépliée --%>
			    	<div class="panel-collapse collapse in panel-niv-1" id="<%= itCatNiv1.getId() %>" >
			    	
	
				    	<section class="pqf-fiche-formation">
	    					<ul class="item-box-list item-box-simple-list">
				    	
								<jalios:foreach collection="<%= resultSet %>" name="itFicheFormation" type="FicheFormation" >
									<li class="item-list item-simple-list">
										<% FicheFormation obj = (FicheFormation) itFicheFormation; %>	
										
									    <% String categoryDomaine =  Util.isEmpty(obj.getDomainesDeFormation(loggedMember)) ? "" : obj.getDomainesDeFormation(loggedMember).toString().substring(1, obj.getDomainesDeFormation(loggedMember).toString().length() -1 ); %>		    
									    <div class="elt-formation">			        
									        <div class="titre">
									          <jalios:link data="<%= obj %>" /> <jalios:edit data="<%= obj %>"/>
									        </div>
									        <div class="info">
									           Domaine : <%= categoryDomaine %>
									        </div>
									    </div>
									</li>
								</jalios:foreach>
						
							</ul>
						</section>
			    	</div>
		    	</jalios:if>
			</jalios:foreach>
			
		</div>
		
	</div>
</section>