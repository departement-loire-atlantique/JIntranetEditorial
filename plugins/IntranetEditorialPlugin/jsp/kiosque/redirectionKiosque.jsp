<%@ include file='/jcore/doInitPage.jsp' %>

<%
/* On g�re le titre du navigateur */
/* request.setAttribute("baliseTitle","Planet | Acc�s au Kiosque"); */

String idAgent = "";
String nomAgent = "";
String prenomAgent = "";
String emailAgent = "";

// Le visiteur est identifi�
if(loggedMember != null){
    idAgent = loggedMember.getLogin().toUpperCase();
    nomAgent = loggedMember.getName();
    prenomAgent = loggedMember.getFirstName();
    emailAgent = loggedMember.getEmail();

    String redirect = "http://kiosque.cg44.fr/NASApp/revue_presse/index.jsp?id="+idAgent+"&nom="+nomAgent+"&prenom="+prenomAgent+"&email="+emailAgent;
    response.sendRedirect(redirect);
}
// Le visiteur est anonyme
else{
    response.sendRedirect("http://kiosque.cg44.fr/NASApp/revue_presse/identification.jsp");
}
%>


