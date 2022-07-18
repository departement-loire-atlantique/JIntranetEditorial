<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% InterventionPlanifiee obj = (InterventionPlanifiee)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>


<div class="queryDisplay InterventionPlanifiee depeches <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">

    <%-- Picto selon type d'incident --%>
	<div class="icon">	
		<jalios:icon src="glyph:icomoon-wrench" htmlAttributes="style='font-size:20px;'"/>
          <!-- <img src="plugins/IntranetEditorialPlugin/images/numerique/Intervention_planifiee_petit.png" alt="" />-->	   	   
	</div>
	
	
	<%-- Titre et date --%>
	<div class="info">	
	   <%-- Titre --%>
	   <span class="title-depeche">
	       <jalios:link data="<%= obj %>" /> 
	   </span>
	   
	   <%-- Date et heure de dernière modif --%>
	   <span class="sub-info">	      
	       - [<jalios:date format="dd/MM/yyyy HH:mm" date="<%= obj.getMdate() %>" />]
	   </span>
	   
	   <jalios:edit data="<%= obj %>" />
	   
	   <%-- Statut --%>
       <div class="sub-info">
            <jalios:select>
                <%-- A venir --%>
                <jalios:if predicate="<%= obj.getPstatus() == -11 %>">
                    le <jalios:date  format="dd/MM/yyyy HH:mm" date="<%= obj.getDateDeDebut() %>" />
                </jalios:if>
                <%-- En cours --%>
                <jalios:if predicate="<%= obj.getPstatus() == 1 %>">
                    Fin prévisionnelle : <jalios:date  format="dd/MM/yyyy HH:mm" date="<%= obj.getDateDeFin() %>" />
                </jalios:if>
            </jalios:select>
       </div>
	     
	</div>
	
	<div class="clear"></div>

</div>