<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="generated.InterventionPlanifiee"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jcore/doInitPage.jspf" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Document sans nom</title>
<style type="text/css">
.whiteTitle {
    color: white;
    font-size: 20px;
    padding-left: 10px;
    font-family: arial;
}
.Arialvert {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 12px;
    color: #4CA4AE;
    margin-left: 10px;
}

.Arial10px {    font-family: Arial, Helvetica, sans-serif;
}
.Arial10px {    font-family: Arial, Helvetica, sans-serif;
}
.Arial10px {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 12px;
    font-weight: normal;
    color: #000;
}
.Arial14pxBold {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 14px;
    font-weight: bold;
    color: #000;
}
.arialbleu {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 11px;
    color: #004667;
}
.ARIALtextebleu {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 12px;
    color: #004667;
    margin-left: 10px;
}
.Arialbold {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #004667;
}
.ARIALtextebleu p {
margin-left: 10px}

@media screen{
}
</style>
</head>

<%
InterventionPlanifiee obj = (InterventionPlanifiee) request.getAttribute("pub");
%>

<body>
<table width="663" border="0" cellspacing="0">
  <tr> 
    <td colspan="3" bgcolor="#adcccc" width="663"><span style="color: #fe0000"></span><br /><span class="whiteTitle">Intervention planifiée</span></td>
  </tr>
  <tr > 
    <td width="143" rowspan="2" bgcolor="#e6f0f0" class="ARIALtextebleu" valign="top"><p><span class="Arialbold"><br/>Sont concernés :</span><br />
      <%= obj.getApplicationsConcernees() %></p>
      <p><span class="Arialbold">Destinataires :</span><br />
      <%= obj.getDestinataire() %></p>
      <p><span class="Arialbold">Effet :</span><br />
      <jalios:date format="dd/MM/yyyy à HH:mm" date="<%= obj.getDateDeDebut() %>" /></p>
      <p><span class="Arialbold">Remise en service :</span><br />
      <jalios:date format="dd/MM/yyyy à HH:mm" date="<%= obj.getDateDeFin() %>" /></p>
      <p><span class="Arialbold">Nature de l'intervention :</span><br /> 
        Maintenance
          <br />
          <br />
      </p>
<p align="right"><img src="plugins/IntranetEditorialPlugin/jsp/numerique/gabaritsMail/Logo_assist_num.png" width="140" height="84" align="right"></p></td>
    <td width="450" valign="top"><p class="ARIALtextebleu"valign="top"><br />
      Madame, Monsieur,</p>
<p class="ARIALtextebleu">Les équipes de la direction solutions numériques vont procéder à une opération de maintenance sur<strong> "<%= obj.getApplicationsConcernees() %>"</strong>.</p>
      <p class="ARIALtextebleu"><strong>"<%= applications %>"</strong> sera indisponible du<strong> <jalios:date format="dd/MM/yyyy à HH:mm" date="<%= obj.getDateDeDebut() %>" /> </strong> au <strong><jalios:date format="dd/MM/yyyy à HH:mm" date="<%= obj.getDateDeFin() %>" /></strong>.</p>
    <p class="ARIALtextebleu">L’assistance numérique vous remercie de votre compréhension.</p>
    <p class="ARIALtextebleu">&nbsp;</p>
    <p class="ARIALtextebleu">&nbsp;</p>
    <p class="ARIALtextebleu">&nbsp;</p></td>
    <td width="70" align="left" valign="top" class="Arialvert"> <p class="Arial10px">&nbsp;</p></td>
  </tr>
  <tr> 
    <td width="450">
    
    <p class="ARIALtextebleu">
    <span style="font-weight: bold; font-size: 16px;">Assistance</span> <span style="color: #CBD234; font-weight: bold; font-size: 16px;">numérique</span><br/>
    Direction solutions numérique<br/>
    Assistance et support client<br/>
    11 rue Henri Cochard - 44041 Nantes<br/>
    Tél. 02 40 99 <strong>1234</strong><br/>
    assistance.numerique@loire-atlantique.fr
    </p>
    
    
    </td>
    <td valign="bottom" class="Arial10px"  width="70">
    <img src="plugins/IntranetEditorialPlugin/jsp/numerique/gabaritsMail/logo_cg.jpg" width="68" height="49" align="absbottom" /></td>
  </tr>
  <tr> 
    <td colspan="3"  width="663">&nbsp;</td>
  </tr>
</table>
</body>
</html>
