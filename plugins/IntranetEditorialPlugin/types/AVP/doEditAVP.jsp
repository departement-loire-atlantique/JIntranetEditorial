<%-- This file has been automatically generated. --%>
<%--
  @Summary: AVP content editor
  @Category: Generated
  @Author: JCMS Type Processor 
  @Customizable: True
  @Requestable: False 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% 
  EditAVPHandler formHandler = (EditAVPHandler)request.getAttribute("formHandler");
  ServletUtil.backupAttribute(pageContext, "classBeingProcessed");
  request.setAttribute("classBeingProcessed", generated.AVP.class);
%>
<% if(!formHandler.isPartialFieldEdition()) { %>
  <ul class="nav nav-tabs">
    <li class='active'><a href="#AVP_contenu_tab" onclick="return false;"><%= formHandler.getTabLabel("contenu") %></a></li>
    <li><a href="#AVP_mission_tab" onclick="return false;"><%= formHandler.getTabLabel("mission") %></a></li>
    <li><a href="#AVP_activite_tab" onclick="return false;"><%= formHandler.getTabLabel("activite") %></a></li>
    <li><a href="#AVP_profil_souhaite_tab" onclick="return false;"><%= formHandler.getTabLabel("profil_souhaite") %></a></li>
    <li><a href="#AVP_competences_attendues_tab" onclick="return false;"><%= formHandler.getTabLabel("competences_attendues") %></a></li>
    <li><a href="#AVP_encadre_tab" onclick="return false;"><%= formHandler.getTabLabel("encadre") %></a></li>
    
  </ul>
<% } %>
<div<%= !formHandler.isPartialFieldEdition() ? " class='tab-content jalios-tab-template clearfix'" : "" %>><div id="AVP_contenu_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane active'" : "" %>>
<%-- Texteentete ------------------------------------------------------------ --%>
<jalios:field name="texteentete" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- DateLimiteDeDepot ------------------------------------------------------------ --%>
<jalios:field name="dateLimiteDeDepot" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- NumeroDePoste ------------------------------------------------------------ --%>
<jalios:field name="numeroDePoste" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- PositionHierarchique ------------------------------------------------------------ --%>
<jalios:field name="positionHierarchique" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Directiondelegation ------------------------------------------------------------ --%>
<jalios:field name="directiondelegation" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- Uo ------------------------------------------------------------ --%>
<jalios:field name="uo" formHandler="<%= formHandler %>">
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
 
</div><div id="AVP_mission_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- Mission ------------------------------------------------------------ --%>
<jalios:field name="mission" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVP_activite_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- DetailActivite ------------------------------------------------------------ --%>
<jalios:field name="detailActivite" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVP_profil_souhaite_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
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
 
</div><div id="AVP_competences_attendues_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
<%-- ConnaissancesEtExperiences ------------------------------------------------------------ --%>
<jalios:field name="connaissancesEtExperiences" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- ConditionsARemplir ------------------------------------------------------------ --%>
<jalios:field name="conditionsARemplir" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
<%-- FicheMetier ------------------------------------------------------------ --%>
<jalios:field name="ficheMetier" formHandler="<%= formHandler %>">
  <jalios:control />
</jalios:field>
 
</div><div id="AVP_encadre_tab"<%= !formHandler.isPartialFieldEdition() ? " class='tab-pane'" : "" %>>
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
  itRemoveCat = channel.getCategory("p1_26891");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("p1_26892");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("p1_5321");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("p1_5324");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  itRemoveCat = channel.getCategory("t1_5452");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  request.setAttribute("AVP.removedCatSet", removedCatSet);
}  
%>
<jalios:include target="EDIT_PUB_MAINTAB" targetContext="div" />
<jalios:include jsp="/jcore/doEditExtraData.jsp" />
<% ServletUtil.restoreAttribute(pageContext , "classBeingProcessed"); %><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- LIJgEBf/In3eW3y85L3LyA== --%>