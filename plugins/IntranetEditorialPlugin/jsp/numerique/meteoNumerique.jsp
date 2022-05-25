<%@page import="org.jsoup.select.Evaluator.IsEmpty"%>
<%@ include file='/jcore/doInitPage.jspf'%><%
%><%@ page contentType="text/html; charset=UTF-8" %>


<%
  Category incidentMajeurCat = channel.getCategory("$id.jcmsplugin.intraneteditorial.depeche.incident.majeur");
%>

<%-- Incident en cours --%>
<jalios:query name="incidentEncoursSet" pstatus="1" dataset="<%= channel.getAllPublicationSet(Incident.class, loggedMember) %>"  comparator="<%= Publication.getUdateComparator() %>" />

<%-- Incident en cours et majeur --%>
<jalios:query name="incidentMajeurSet" cids="$id.jcmsplugin.intraneteditorial.depeche.incident.majeur" pstatus="1" dataset="<%= incidentEncoursSet %>"  comparator="<%= Publication.getUdateComparator() %>" />
<%-- Incident en cours et mineur --%>
<jalios:query name="incidentMineurSet" cidsoff="$id.jcmsplugin.intraneteditorial.depeche.incident.majeur" pstatus="1" dataset="<%= incidentEncoursSet %>"  comparator="<%= Publication.getUdateComparator() %>" />


<%
  // Couleur de la bordure
  // Choix de l'image
  // Choix du libelle
  String borderColor = "#FEC227";
  String image = "glyph:icomoon-sun";
  String libelle = "jcmsplugin.intranetEditorial.numerique.services.operationnel.lbl";
  // Incident(s) mineur(s)
  if(Util.notEmpty(incidentMineurSet) && Util.isEmpty(incidentMajeurSet)) {
      borderColor = "#0072BC";
      image= "glyph:icomoon-weather-cloud-sun";      
      libelle = "jcmsplugin.intranetEditorial.numerique.services.operationnel-sauf.lbl";
  }else if(Util.notEmpty(incidentMajeurSet)) {
      borderColor = "#FF0000";
      image= "glyph:icomoon-weather-lightning";
      libelle = "jcmsplugin.intranetEditorial.numerique.services.panne.lbl";
  }
  

%>

<div class="meteo-numerique">
<div class="contener-meteo" style="border-color: <%= borderColor %>;">



	<div class="date bold">
	   <jalios:date format="dd MMMM yyyy" date="<%= new Date() %>" /> 
	</div>
	
	<div class="etat-services-img">
	   <jalios:icon src="<%= image %>" htmlAttributes="style='font-size:80px;'"/>
    </div>
    <div class="etat-services-lbl">
        <%= glp(libelle) %>
    </div>
    <div class="clear"></div>
    
    <jalios:if predicate="<%= Util.notEmpty(incidentEncoursSet) %>">
	    <jalios:foreach collection="<%= incidentEncoursSet %>" name="itIncident" type="Incident">
	        <div class="Incident depeches" <%= itCounter == incidentEncoursSet.size() ? "style='border: none;'" : "" %>>
	           
	            <%-- Picto selon type d'incident --%>
			    <div class="icon">  
			       <jalios:select>   
			           <jalios:if predicate="<%= JcmsUtil.isSameId(itIncident.getFirstTypeDincident(loggedMember), incidentMajeurCat) %>">
			               <jalios:icon src="glyph:icomoon-weather-lightning" htmlAttributes="style='font-size:22px;'"/>
			           </jalios:if>
			           <jalios:default>
			               <jalios:icon src="glyph:icomoon-weather-cloud-sun" htmlAttributes="style='font-size:20px;'"/>
			           </jalios:default>       
			       </jalios:select>        
			    </div>
	           
	           
	           <%-- Titre--%>
			   <div class="info">  
			       <%-- Titre --%>
			       <span class="title-depeche">
			           <jalios:link data="<%= itIncident %>" /> 
			       </span>
			       			      			       
			       <jalios:edit data="<%= itIncident %>" />
			       
			       <%-- Date depuis X --%>
			       <div class="sub-info">
			            Depuis <jalios:duration begin="<%= itIncident.getCdate() %>" end="<%= new Date() %>" round="<%= true %>" />
			       </div>			         
			   </div>
			   			    
			   <div class="clear"></div>
	           
	           
	        </div>
	    </jalios:foreach>
    </jalios:if>
</div>
</div>