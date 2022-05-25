<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%

//String color = currentCategory.getAvailableColor();
%>

<%
// On récupère les parcours de formation : juste le premier niveau de catégories de la branche "Parcours de formation"
Category catRacineParcoursFormation = channel.getCategory("$id.jcmsplugin.intraneteditorial.parcoursMetier.cat");
Set catParcoursFormationSet = new TreeSet(Category.getOrderComparator(userLang));
catParcoursFormationSet.addAll(catRacineParcoursFormation.getChildrenSet());

%>

<jalios:pager name='myPagerParcours' declare='true' action='init' pageSize='100' pagerAllLimit='100' size='<%= catParcoursFormationSet.size() %>'/>

<section class="pqf-fiche-formation">
	<ul class="item-box-list item-box-simple-list">
		<jalios:foreach collection="<%= catParcoursFormationSet %>" name="itParcours" type="Category"
					max='<%= myPagerParcours.getPageSize() %>' skip='<%= myPagerParcours.getStart() %>' >
			<li class="item-list item-simple-list">  
				<div class="elt-formation">			        
			        <div class="titre">
			        	<jalios:link data="<%=itParcours%>"><%=itParcours%></jalios:link>
			        </div>
			    </div>
			</li>
		</jalios:foreach>
		
		<jalios:pager name='myPagerParcours' />	
</section>