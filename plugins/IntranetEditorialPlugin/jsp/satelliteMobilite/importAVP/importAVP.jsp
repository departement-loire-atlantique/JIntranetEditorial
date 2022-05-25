<%@ page import="org.apache.commons.fileupload.*, com.jalios.jcms.upload.*" %>
<%@ page import='fr.cg44.plugin.intraneteditorial.AvpImportManager' %>
<%@ include file='/jcore/doInitPage.jsp'  %>
<%
jcmsContext.addCSSHeader("plugins/MembersImportPlugin/css/plugin.css");
%>

<%-- 	Importe des AVP en se basant sur un fichier CSV.
		Le processus se déroule en 2 temps : 
		1) Pré-import : on lit le fichier et on regarde son intégrité. On affiche les données du fichier à l'écran.
		2) Si OK, on propose l'import des données.
		Du fait de ces 2 temps, on est obligé d'uploader le fichier à l'étape 1) pour pouvoir le traiter à l'étape 2)
		En effet, après une première soumission, le champ "File" est vidé du formulaire.
--%>

<%@ include file='/work/doWorkHeader.jspf' %>
<%
Boolean checkForm = true;
Boolean importOK = false;
String messageRetour = "";
String traceImport = "";
FileItem fileItem = (FileItem) request.getAttribute("file");
List<String> listeMatricules = new ArrayList<String>();
String[] values;
Workspace currentWs = jcmsContext.getWorkspace();


/* 1. Pré import. */

if(Util.notEmpty(request.getParameter("opPreImportFile"))){
	/* Teste la validité du formulaire */
	if(Util.isEmpty(request.getParameter("file")) ){
		checkForm = false;
		jcmsContext.addMsg(new JcmsMessage(JcmsMessage.Level.ERROR, "Merci de remplir tous les champs"));
	}
	// Traitement
	try{
		if (checkForm){
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
			Date datenow = Calendar.getInstance().getTime();  
			String dateStr = dateFormat.format(datenow);
			
			// Initialisation du path
			if(AvpImportManager.initPath()){
				
				// Vérification cohérence du fichier
				if(AvpImportManager.isFichierCorrect(fileItem)){
					
					// Upload du fichier
					if(AvpImportManager.uploadFile(fileItem, dateStr)){
						importOK = true;
					}
				}
			}
			
		}
	} catch(Exception ex) {
		messageRetour = "Le pré import est en erreur : " + ex;
	}
}

/* 2. Import des données */

if(Util.notEmpty(request.getParameter("opImportFile")) && Util.notEmpty(request.getParameter("pathFichierUpload"))){

	try{
		messageRetour = AvpImportManager.importAvp(request.getParameter("pathFichierUpload"));
	} catch(Exception ex) {
		messageRetour = "L'import est en erreur : " + ex;
	}
}

%>
<h1 class="boTitle icon iconGroup">Importer une liste d'AVP</h1>
<%@ include file='/jcore/doMessageBox.jspf' %>
<form action="plugins/IntranetEditorialPlugin/jsp/satelliteMobilite/importAVP/importAVP.jsp" method="post" enctype="multipart/form-data" class="form-horizontal">

<div class="importForm" id="importFileForm">
	<div class="title">
		<h2 class="import"><%= glp("ui.adm.import-mgr.lbl.import-file") %></h2>
	</div>
	
	<div class="content">
	 
		<p><strong>Prérequis :</strong><br/>
			<ul>
				<li>Le fichier doit être au format XLSX</li>
				<li>Le fichier doit contenir 1 en-tête, et respectant cet ordre :
					<ol>
					<li>COL A 1 : LIBELLE_POSTE</li>
					<li>COL B 2 : LIB_METIER</li>
					<li>COL C 3 : CODE_POSTE</li>
					<li>COL D 4 : MATRICULE_RESPONSABLE</li>
					<li>COL E 5 : NOM_RESPONSABLE</li>
					<li>COL F 6 : FONCTION_RESPONSABLE</li>
					<li>COL G 7 : DELEGATION</li>
					<li>COL H 8 : DIRECTION_GENERALE</li>
					<li>COL I 9 : DIRECTION</li>
					<li>COL J 10 : SOUS_DIRECTION</li>
					<li>COL K 11 : SERVICE</li>
					<li>COL L 12 : UNITE</li>
					<li>COL M 13 : LIEU_DE_W</li>
					<li>COL N 14 : CP_LIEU_W</li>
					<li>COL O 15 : VILLE_LIEU_DE_W</li>
					<li>COL P 16 : CATEGORIE_POSTE</li>
					<li>COL Q 17 : FILIERE_POSTE</li>
					<li>COL R 18 : CADRE_DEMPLOI</li>
					<li>COL S 19 : CODE_METIER</li>
					<li>COL T 20 : MISSION_POSTE</li>
					<li>COL U 21 : ACTIVITES_POSTE</li>
					<li>COL V 22 : COMPETENCES_DESCRIPTION_METIER</li>
					<li>COL W 23 : MISSION_POSTE</li>
					<li>COL X 24 : MISSION_POSTE</li>
					<li>COL Y 25 : MISSION_POSTE</li>
					<li>COL Z 26 : HORAIRES</li>
					<li>COL AA 27 : NBI</li>
					<li>COL AB 28 : RESIDENCE</li>
					<li>COL AC 29 : SUJETIONS</li>
					<li>COL AD 30 : SUJETIONS_Autre</li>
					<li>COL AE 31 : CARACTERISTIQUES_POSTE_1</li>
					<li>COL AF 32 : CARACTERISTIQUES_POSTE_2</li>
					<li>COL AG 33 : CARACTERISTIQUES_POSTE_3</li>
					<li>COL AH 34 : CARACTERISTIQUES_POSTE_4</li>
					<li>COL AI 35 : CARACTERISTIQUES_POSTE_5</li>
					<li>COL AJ 36 : CARACTERISTIQUES_POSTE_6</li>
					<li>COL AK 37 : CARACTERISTIQUES_POSTE_Autre</li>
					</ol>
				</li>
			</ul>
		</p>
	  	<p>Indiquez le fichier CSV à importer. Ce fichier doit respecter le format CSV d'Import/Export des résultats (UTF-8 sans BOM).</p>
	  	
	  	<jalios:field name="file" label="Fichier CSV"> 
 			<jalios:control settings="<%= new FileSettings().mode(FileSettings.Mode.SIMPLE_FILE) %>" /> 
		</jalios:field> 

	  	<input class="btn btn-primary" type="submit" name="opPreImportFile" value="Pré-importer" />
	</div>
</div>

<%-- Pré import --%>
<jalios:if predicate='<%= Util.notEmpty(request.getParameter("opPreImportFile")) && checkForm  %>'>
	
	<div class="importForm">
		<div class="title">
			Resultat du pré import :
		</div>
		
		<div class="content">

			<div>
				<jalios:if predicate='<%=Util.notEmpty(request.getAttribute("traceImport"))%>'>
					<p>Trace de chargement du fichier : <p>
					<pre><%=traceImport = request.getAttribute("traceImport").toString()%></pre>
				</jalios:if>
				
				
				<jalios:if predicate='<%= Util.notEmpty(request.getParameter("opPreImportFile")) && importOK  %>'>
				
					<input type="hidden" name="pathFichierUpload" value="<%=request.getAttribute("pathFichierUpload")%>"/>
					<input class="btn btn-primary" type="submit" name="opImportFile" value="Importer" />
		
					<% request.setAttribute("file", fileItem); %>
			
				</jalios:if>
			
			</div>
		</div>
	</div>
</jalios:if>


	
<%-- Import --%>
<jalios:if predicate='<%= Util.notEmpty(request.getParameter("opImportFile")) && Util.notEmpty(messageRetour) && messageRetour.equals("OK") %>'>
IMPORT
</jalios:if>

</form>
<%@ include file='/work/doWorkFooter.jspf' %>