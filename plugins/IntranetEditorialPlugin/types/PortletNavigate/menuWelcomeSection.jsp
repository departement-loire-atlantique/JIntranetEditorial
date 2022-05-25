<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.jalios.jcms.taglib.menu.MenuInfo"%>
<%@page import="com.jalios.jcms.taglib.menu.MenuInfoFilter"%>
<%@page import="com.jalios.jcms.portlet.navigate.CategoryMenuInfo"%>
<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<%@ include file="/types/PortletNavigate/doInitPortletNavigate.jspf" %>
<%
boolean display = rootCategory != null && rootCategory.isNode(loggedMember);
if (!display && box.getHideWhenNoResults()) {
  request.setAttribute("ShowPortalElement", Boolean.FALSE);
  return;
}

jcmsContext.addJavaScript("plugins/IntranetVisualIdentityPlugin/js/navigationToggle.js");

int verticalCounter = Util.toInt(Util.getString(request.getAttribute("verticalCounter"), ""), 0); 
request.setAttribute("verticalCounter", "" + (verticalCounter + 1));

int maxDepthLevel = box.getLevels() - 1;
Category sectionRootCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.root.section.categories");
Boolean isRootSectionCat = JcmsUtil.isSameId(currentCategory.getParent(), sectionRootCat);


Set navigateSet = new TreeSet(Category.getOrderComparator(userLang));
navigateSet.addAll(rootCategory.getChildrenSet());

String color = currentCategory.getAvailableColor();
%>





<div class="verticalMenun navigation-section menu-welcome">
	
	

<div data-jalios-collapse-toggle="caret caret" class="jalios-accordion panel-group">  
  
  <jalios:foreach collection="<%= navigateSet %>" name="itCatNiv1" type="Category">
   
    
	    <%-- Lien pour déplier la catégorie --%>
	    <div data-target="#<%= itCatNiv1.getId() %>" data-parent="#" data-toggle="collapse" class="panel-heading collapsed">
	        
	        <div class="panel-title title-niv1">   
		        
		        
		        <jalios:select>
		        
		          <jalios:if predicate="<%= Util.notEmpty(itCatNiv1.getChildrenSet()) %>">
			        <%-- Ouvrir --%>
			        <a class="toggle-container-accessi" onclick="return false;" href="#<%= itCatNiv1.getId() %>" title="Ouvrir <%= itCatNiv1.getName() %>">
			            <div class="chevron-menu" style="background-color: <%= color %>"></div>
			            <%= itCatNiv1 %>			            
			            <%-- Image (Utilisation de l'icone de la catégorie) --%>
				        <jalios:if predicate="<%= Util.notEmpty(itCatNiv1.getIcon()) %>">
				          <div class="image">
				             <img src="<%= itCatNiv1.getIcon() %>" alt="" />			                
				          </div>
				        </jalios:if>		            		            
			        </a>
			      </jalios:if>
		          	          
		          <jalios:default>
		              <jalios:link data="<%= itCatNiv1 %>">
		                  <div class="chevron-menu" style="background-color: <%= color %>"></div>
		                  <span class="cat-feuille"><%= itCatNiv1 %></span>                        
	                      <%-- Image --%>
	                      <jalios:if predicate="<%= Util.notEmpty(itCatNiv1.getImage()) %>">
	                        <div class="image">
	                           <img src="<%= itCatNiv1.getImage() %>" alt="" />                           
	                        </div>
	                      </jalios:if>    		                  		                  
		              </jalios:link>		          
		          </jalios:default>
		        
		        
		        </jalios:select>
		        
		        		        
		    </div>
		    
	     </div>
	    
	    <%-- Contenu de la catégorie dépliée --%>
	    <div class="panel-collapse collapse in panel-niv-1" id="<%= itCatNiv1.getId() %>">
	        
	        <%-- Catégorie niveau 2 --%>
	        <%
	        Set navigateSetNiv2 = new TreeSet(Category.getOrderComparator(userLang));
	        navigateSetNiv2.addAll(itCatNiv1.getChildrenSet());
			%>
	        <jalios:foreach collection="<%= navigateSetNiv2 %>" name="itCatNiv2" type="Category">
	        
	           <%-- Lien pour déplier la catégorie - niveau 2 --%>
               <jalios:select>
               
                   <jalios:if predicate="<%= Util.notEmpty(itCatNiv2.getChildrenSet()) %>">              
		               <div data-target="#<%= itCatNiv2.getId() %>" data-parent="#" data-toggle="collapse" class="panel-heading collapsed">                                                        	                 
		                    <a  class="toggle-container-accessi" onclick="return false;" href="#<%= itCatNiv2.getId() %>" title="Ouvrir <%= itCatNiv2.getName() %>">  
		                      <div class="panel-title title-niv2 title-niv2-chevron-open"><%= itCatNiv2 %></div>
		                    </a>	                                        
		               </div>	               
	               </jalios:if>
	               	               
	               <jalios:default>
	                   <div class="panel-heading collapsed">
		                   <div class="panel-title title-niv2">
		                       <jalios:link data="<%= itCatNiv2 %>">
		                           <%= itCatNiv2 %>
		                       </jalios:link>
		                   </div>
	                   </div>	               	               	               
	               </jalios:default>
	                             
               </jalios:select>
               
               
               <%-- Contenu de la catégorie dépliée - niveau 2 --%>
               <div class="panel-collapse collapse panel-niv-2" id="<%= itCatNiv2.getId() %>" style="height: 0px;">
                                      
                    <%-- Catégorie niveau 3 --%>
                    <%
			        Set navigateSetNiv3 = new TreeSet(Category.getOrderComparator(userLang));
			        navigateSetNiv3.addAll(itCatNiv2.getChildrenSet());
					%>
		            <jalios:foreach collection="<%= navigateSetNiv3 %>" name="itCatNiv3" type="Category">
		            
		               <%-- Lien pour déplier la catégorie - niveau 3 --%>
		               <div data-target="#<%= itCatNiv3.getId() %>" data-parent="#" data-toggle="collapse" class="panel-heading collapsed">
		                                                         
		                 <div class="panel-title title-niv3">
		                    
		                    <jalios:select>
			                    <jalios:if predicate="<%= Util.notEmpty(itCatNiv3.getChildrenSet()) %>">
				                    <a class="toggle-container-accessi" onclick="return false;" href="#<%= itCatNiv3.getId() %>" title="Ouvrir <%= itCatNiv3.getName() %>">  
				                      <%= itCatNiv3 %>
				                    </a>
		                        </jalios:if>
		                    
		                        <jalios:default>
				                    <jalios:link data="<%= itCatNiv3 %>">
				                      <span class="cat-feuille"><%= itCatNiv3 %></span>
				                    </jalios:link>
		                        </jalios:default>
		                    
		                    </jalios:select>
		                    
		                 </div>
		                                
		               </div>
		               
		               <%-- Contenu de la catégorie dépliée - niveau 3 --%>
		               <div class="panel-collapse collapse" id="<%= itCatNiv3.getId() %>" style="height: 0px;">
		                    		                    	                    
		                    <%-- Catégorie niveau 4 --%>
		                    <jalios:foreach collection="<%= itCatNiv3.getChildrenSet() %>" name="itCatNiv4" type="Category">
		                    
		                       <%-- Lien pour la catégorie - niveau 4 --%>
		                       <div class="panel-title title-niv4 cat-feuille">
	                             <jalios:link data="<%= itCatNiv4 %>">
	                               <%= itCatNiv4 %>
	                             </jalios:link> 
		                       </div>
		                    
		                    </jalios:foreach>
		                    	                    
		               </div>
		            
		            </jalios:foreach>
           
                               
               </div>
	        
	        </jalios:foreach>
	        
	        
	    </div>
    
    
       
  </jalios:foreach>
  
</div> 
  
</div>

