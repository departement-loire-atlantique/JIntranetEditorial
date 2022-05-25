<%-- This file has been automatically generated. --%>
<%--
  @Summary: AVPImport content editor
  @Category: Generated
  @Author: JCMS Type Processor 
  @Customizable: True
  @Requestable: False 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% 
  EditAVPImportHandler formHandler = (EditAVPImportHandler)request.getAttribute("formHandler");
  ServletUtil.backupAttribute(pageContext, "classBeingProcessed");
  request.setAttribute("classBeingProcessed", generated.AVPImport.class);
%>
<% if(!formHandler.isPartialFieldEdition()) { %>
  <ul class="nav nav-tabs">
    <li class='active'><a href="#AVPImport_contenu_tab" onclick="return false;"><%= formHandler.getTabLabel("contenu") %></a></li>
    <li><a href="#AVPImport_mission_tab" onclick="return false;"><%= formHandler.getTabLabel("mission") %></a></li>
    <li><a href="#AVPImport_activite_tab" onclick="return false;"><%= formHandler.getTabLabel("activite") %></a></li>
    <li><a href="#AVPImport_profil_souhaite_tab" onclick="return false;"><%= formHandler.getTabLabel("profil_souhaite") %></a></li>
    <li><a href="#AVPImport_competences_attendues_tab" onclick="return false;"><%= formHandler.getTabLabel("competences_attendues") %></a></li>
    <li><a href="#AVPImport_autre_tab" onclick="return false;"><%= formHandler.getTabLabel("autre") %></a></li>
    <li><a href="#AVPImport_encadre_tab" onclick="return false;"><%= formHandler.getTabLabel("encadre") %></a></li>
    
  </ul>
<% } %>
<div<%= !formHandler.isPartialFieldEdition() ? " class='tab-content jalios-tab-template clearfix'" : "" %>><div id="AVPImport_contenu_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane active'" : "" %>>
<%-- DateLimiteDeDepot ------------------------------------------------------------ --%>
<jalios:field name="dateLimiteDeDepot" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- NumeroDePoste ------------------------------------------------------------ --%>
<jalios:field name="numeroDePoste" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- LibellePoste ------------------------------------------------------------ --%>
<jalios:field name="libellePoste" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- LibelleMetier ------------------------------------------------------------ --%>
<jalios:field name="libelleMetier" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- VacantOuPropose ------------------------------------------------------------ --%>
<jalios:field name="vacantOuPropose" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- FonctionResponsable ------------------------------------------------------------ --%>
<jalios:field name="fonctionResponsable" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Delegation ------------------------------------------------------------ --%>
<jalios:field name="delegation" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Directiongenerale ------------------------------------------------------------ --%>
<jalios:field name="directiongenerale" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Direction ------------------------------------------------------------ --%>
<jalios:field name="direction" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Sousdirection ------------------------------------------------------------ --%>
<jalios:field name="sousdirection" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Service ------------------------------------------------------------ --%>
<jalios:field name="service" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Unite ------------------------------------------------------------ --%>
<jalios:field name="unite" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Rue ------------------------------------------------------------ --%>
<jalios:field name="rue" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Cp ------------------------------------------------------------ --%>
<jalios:field name="cp" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Ville ------------------------------------------------------------ --%>
<jalios:field name="ville" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Motscles ------------------------------------------------------------ --%>
<jalios:field name="motscles" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVPImport_mission_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- Mission ------------------------------------------------------------ --%>
<jalios:field name="mission" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVPImport_activite_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- Activites ------------------------------------------------------------ --%>
<jalios:field name="activites" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVPImport_profil_souhaite_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- Filiere ------------------------------------------------------------ --%>
<jalios:field name="filiere" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- CategorieDemploi ------------------------------------------------------------ --%>
<jalios:field name="categorieDemploi" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Grade ------------------------------------------------------------ --%>
<jalios:field name="grade" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVPImport_competences_attendues_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- CompetencesMetier ------------------------------------------------------------ --%>
<jalios:field name="competencesMetier" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- CompetencesTravailler ------------------------------------------------------------ --%>
<jalios:field name="competencesTravailler" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- CompetencesNumeriques ------------------------------------------------------------ --%>
<jalios:field name="competencesNumeriques" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- FicheMetier ------------------------------------------------------------ --%>
<jalios:field name="ficheMetier" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVPImport_autre_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- Nbi ------------------------------------------------------------ --%>
<jalios:field name="nbi" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Residence ------------------------------------------------------------ --%>
<jalios:field name="residence" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Particularites1 ------------------------------------------------------------ --%>
<jalios:field name="particularites1" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Particularites2 ------------------------------------------------------------ --%>
<jalios:field name="particularites2" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Particularites3 ------------------------------------------------------------ --%>
<jalios:field name="particularites3" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Particularites4 ------------------------------------------------------------ --%>
<jalios:field name="particularites4" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Particularites5 ------------------------------------------------------------ --%>
<jalios:field name="particularites5" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Particularites6 ------------------------------------------------------------ --%>
<jalios:field name="particularites6" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- ParticularitesAutre ------------------------------------------------------------ --%>
<jalios:field name="particularitesAutre" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Commentaire ------------------------------------------------------------ --%>
<jalios:field name="commentaire" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVPImport_encadre_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- TitreListeDeContacts ------------------------------------------------------------ --%>
<jalios:field name="titreListeDeContacts" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- ContactsAgents ------------------------------------------------------------ --%>
<jalios:field name="contactsAgents" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- ContactsUniteOrga ------------------------------------------------------------ --%>
<jalios:field name="contactsUniteOrga" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Contacts ------------------------------------------------------------ --%>
<jalios:field name="contacts" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- ComplementContacts ------------------------------------------------------------ --%>
<jalios:field name="complementContacts" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><%-- End last tab --%></div><%-- End 'tab-content' --%>
<%
{ 
  TreeSet  removedCatSet = new TreeSet(); 
  Category itRemoveCat = null;
  itRemoveCat = channel.getCategory("p1_26887");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("p1_5324");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("p1_756136");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("t1_5452");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  request.setAttribute("AVPImport.removedCatSet", removedCatSet);
}  
%>
<jalios:include target="EDIT_PUB_MAINTAB" targetContext="div" />
<jalios:include jsp="/jcore/doEditExtraData.jsp" />
<% ServletUtil.restoreAttribute(pageContext , "classBeingProcessed"); %><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- vfnxTfSoEgppDYghaV1eSg== --%>