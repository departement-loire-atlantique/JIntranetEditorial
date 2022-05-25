<%@ include file='/jcore/doInitPage.jspf' %><%

AVP pub = (AVP)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String displayURLparams = (String)request.getAttribute("displayURLparams");

String categoryPoste = pub.getCategorieDemploi(loggedMember).toString().substring(1, pub.getCategorieDemploi(loggedMember).toString().length() -1 );

%><%@ include file='/front/doFullDisplay.jspf' %>

<section class="result AVP">

   <div>
       <h2 class="list-title"><jalios:link data="<%= pub %>" /></h2>
       
       <span class="surlignageJaune"><%= Util.getFirst(pub.getVille(loggedMember)) %> - <%= categoryPoste  %></span>
       <div class="info">      
            <div><%= glp("jcmsplugin.intranetEditorial.avp.depot") %> : <jalios:date date="<%= pub.getDateLimiteDeDepot() %>" format='<%= "dd MMMM yyyy" %>' /> </div>             
            <div><span class="lib"><%= Util.getFirst(pub.getDirectiondelegation(loggedMember)) %> </span></div>           
            <%-- Mots Clés --%>
            <% TreeSet<Category> motsClesSet = pub.getMotscles(loggedMember); %>
            <jalios:if predicate="<%= Util.notEmpty(motsClesSet) %>">
                <div class="search-result-meta search-result-categories">
                  <% Category[] categories = motsClesSet.toArray(new Category[motsClesSet.size()]); %>
                  <%@ include file="/custom/jcms/doCategoryList.jspf"  %>
                </div>
            </jalios:if>
            <jalios:wysiwyg><%= pub.getMission() %></jalios:wysiwyg>
       </div>
       
       
   </div>  
    
    


<!-- 	<div class="pull-right" > -->
<!-- 		<div class="label label-success"> -->
<%-- 			<jalios:foreach name="itCat" type="Category" collection="<%= obj.getCategorie(loggedMember) %>"> --%>
<%-- 				<%= itCat %> --%>
<%-- 			</jalios:foreach> --%>
<!-- 		</div> -->
<!-- 	</div> -->

<!-- 	<div class="clear"> -->
<%-- 		Date limite de dépôt : <jalios:date date="<%= obj.getDateLimiteDeDepot() %>" format="dd/MM/yyyy"/> --%>
<!-- 	</div> -->
	
<!-- 	<div> -->
<%-- 		<h1><jalios:link data="<%= obj %>"><%= obj.getIntituleDuPoste() %> <jalios:edit pub="<%= obj %>" /></h1></jalios:link>  --%>
<!-- 	</div> -->
	
<!-- 	<div class="corps"> -->
<!-- 		<div> -->
<%-- 			<jalios:wysiwyg><%= obj.getMission() %></jalios:wysiwyg> --%>
<!-- 		</div> -->
<!-- 		<div> -->
<!-- 			Rattachement:  -->
<%-- 			<jalios:select> --%>
<%-- 				<jalios:if predicate="<%= Util.notEmpty(obj.getLibelleUniteOrganisationnelleDuP()) %>">					 --%>
<%-- 					<%= obj.getLibelleUniteOrganisationnelleDuP() %> --%>
<%-- 				</jalios:if> --%>
<%-- 				<jalios:default> --%>
<%-- 					<%= obj.getUniteOrganisationnelleDuPoste() %> --%>
<%-- 				</jalios:default> --%>
<%-- 			</jalios:select>						 --%>
<!-- 		</div> -->
<!-- 		<div> -->
<%-- 			Lieu de travail: <%= obj.getLieu() %> <%= obj.getRue() %> <%= obj.getCp() %> <%= Util.getFirst(obj.getVille(loggedMember)) %> --%>
<!-- 		</div> -->
<!-- 	</div> -->

</section>