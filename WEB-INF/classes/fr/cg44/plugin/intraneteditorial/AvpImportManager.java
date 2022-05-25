package fr.cg44.plugin.intraneteditorial;


import static com.jalios.jcms.Channel.getChannel;
import generated.AVPImport;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TreeSet;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.csvreader.CsvReader;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Member;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.util.Util;


public class AvpImportManager {

	private static final Logger LOGGER = Logger.getLogger(AvpImportManager.class);
	private static CsvReader csvReader;
	private static char separator = ';';
	private static File csvFile;
	private static String pathFile = getChannel().getRealPath("/upload/import_avp/");
	private static String originalFileName = "import_";
	private static String tempFileName = "temp_import_";
	private static String finalFileName = "final_import_";
	private static String fileExtensionCsv = ".csv";
	private static String fileExtensionTxt = ".txt";
	private static String fileExtensionXlsx = ".xlsx";
	private static String logFile = "resultat_import_";
	private static String csvSplitBy = ";";
	private static String encoding = "UTF-8";
	private static String csvTypeMime = "application/csv";
	private static String xlsxTypeMime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	private static int nbColonnes = 37;
	private static int nbLignesEnTete = 1;
	protected static final Channel channel = Channel.getChannel();
	protected static final JcmsContext jcmsContext = Channel.getChannel().getCurrentJcmsContext();
	private static Member opAuthor = channel.getDefaultAdmin();
	private static String userLang = channel.getLanguage();
	protected String[] cids;


	/* Teste la cohérence du fichier (vérifie qu'on a bien un format CSV et une seule valeur à chaque ligne.
	 * Renvoie dans la réponse un "JcmsMessage" + la trace d'erreur.
	 * 
	 * */
	public static boolean isFichierCorrect(FileItem fileItem){
		boolean result = true;
		String message = "";
		String trace = "";
		
		if(!fileItem.getContentType().equals(xlsxTypeMime)){
			message = "Le fichier doit être au format XLSX";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
			return false;
		}

		try {
			final Workbook workbook = WorkbookFactory.create(fileItem.getInputStream());
			final Sheet sheet = workbook.getSheet("Feuil1");
			
			int index = nbLignesEnTete;
			int nbRow = sheet.getLastRowNum()+1;

	        LOGGER.warn("Nombre de lignes d'en tête : "+ nbLignesEnTete);
	        LOGGER.warn("Numéro dernière ligne : "+ nbRow);
	        LOGGER.warn("Nombre de lignes à traiter : "+ (sheet.getLastRowNum()-nbLignesEnTete+1));
	        for (int i = index; i < nbRow; i++) {
	        	Row row = sheet.getRow(i);
	        	if (row != null) { 
		        	String titre = row.getCell(0).getStringCellValue();
		        	String codePoste = row.getCell(1).getStringCellValue();
		        	LOGGER.warn("Ligne " + (i+1) + " | nombre de colonnes : " + row.getLastCellNum() + " | " + titre);
		        	/*
		        	if(row.getLastCellNum() != nbColonnes){
						trace += "Le fichier contient une ligne incorrecte [ligne " + (i+1) + "], nombre de colonnes différent de " + nbColonnes + "\r\n";
						result = false;
					}
		        	else{
		        	*/
		        		trace += "Ligne " + (i+1) + " : " + titre + " - " + codePoste + "\r\n";
		        	//}
	        	}
	        }
	        
	        if(!result){
				message = "Le fichier contient des lignes en erreur.";
				channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
			}
			else{
				result = true;
				message = "La syntaxe du fichier est correcte.";
				channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.INFO, message));
			}
			
			channel.getCurrentJcmsContext().getRequest().setAttribute("traceImport", trace);
			
		} catch (FileNotFoundException e) {
			result = false;
			message = "Impossible de trouver le fichier";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
		} catch (IOException e) {
			result = false;
			message = "Erreur lors de la lecture du fichier";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
			channel.getCurrentJcmsContext().getRequest().setAttribute("traceImport", e);
		} catch (InvalidFormatException e) {
			message = "Format de fichier incorrect";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
		} 

		return result;
	}
	

	public static String importAvp(String filePath){
		String message = "";
		int cptOK=0;
		int cptNOK=0;
		File file = null;
		
		try {
			InputStream inp= new FileInputStream(filePath);
			file = new File(filePath);
			Workbook workbook = WorkbookFactory.create(inp);
			Sheet sheet = workbook.getSheet("Feuil1");
			
			int index = nbLignesEnTete;
			int nbRow = sheet.getLastRowNum()+1;


	        for (int i = index; i < nbRow; i++) {
	        	Row row = sheet.getRow(i);
	        	if (row != null) { 
		        	
	        		// COL A1 : LIBELLE_POSTE
	        		String libellePoste = Util.notEmpty(row.getCell(0)) ? row.getCell(0).getStringCellValue() : "";
	        		
	        		// COL B2 : LIB_METIER
	        		String libelleMetier = Util.notEmpty(row.getCell(1)) ? row.getCell(1).getStringCellValue() : "";
	        		
	        		// COL C3 : CODE_POSTE
		        	String numeroDePoste = Util.notEmpty(row.getCell(2)) ? row.getCell(2).getStringCellValue() : "";
		        	LOGGER.warn("Ligne : " + i + " - " + numeroDePoste);
		        	
		        	String titre = libellePoste + " - " + numeroDePoste;
		        	
		        	// COL D4 : MATRICULE_RESPONSABLE
				    String matriculeResponsable = Util.notEmpty(row.getCell(3)) ? row.getCell(3).getStringCellValue() : "";
				    
				    Member responsable = channel.getMemberFromLogin(matriculeResponsable, false);
				    Member[] contactsAgents = new Member[]{responsable};
				    
				    // COL F6 : FONCTION_RESPONSABLE
				    String fonctionResponsable = Util.notEmpty(row.getCell(5)) ? row.getCell(5).getStringCellValue() : "";

				    // COL G7 : DELEGATION
				    String delegation = Util.notEmpty(row.getCell(6)) ? row.getCell(6).getStringCellValue() : "";
				    
				    // COL H8 : DIRECTION_GENERALE
				    String directiongenerale = Util.notEmpty(row.getCell(7)) ? row.getCell(7).getStringCellValue() : "";
				    
				    // COL I9 : DIRECTION
				    String direction = Util.notEmpty(row.getCell(8)) ? row.getCell(8).getStringCellValue() : "";
				    
				    // COL J10 : SOUS_DIRECTION
				    String sousdirection = Util.notEmpty(row.getCell(9)) ? row.getCell(9).getStringCellValue() : "";
				    
				    // COL K11 : SERVICE
				    String service = Util.notEmpty(row.getCell(10)) ? row.getCell(10).getStringCellValue() : "";
				    
				    // COL L12 : UNITE
				    String unite = Util.notEmpty(row.getCell(11)) ? row.getCell(11).getStringCellValue() : "";
				    
				    // COL M13 : LIEU_DE_W
				    String rue = Util.notEmpty(row.getCell(12)) ? row.getCell(12).getStringCellValue() : "";
				    
				    // COL N14 : CP_LIEU_W
				    String cp = Util.notEmpty(row.getCell(13)) ? row.getCell(13).getStringCellValue() : "";
				    
				    // COL O15 : VILLE_LIEU_DE_W
				    String ville = Util.notEmpty(row.getCell(14)) ? row.getCell(14).getStringCellValue() : "";
				    
				    // COL P16 : CATEGORIE_POSTE
				    String catEmploi = Util.notEmpty(row.getCell(15)) ? row.getCell(15).getStringCellValue() : "";
				    
				    // COL Q17 : FILIERE_POSTE
				    String filiere = Util.notEmpty(row.getCell(16)) ? row.getCell(16).getStringCellValue() : "";
				    
				    // COL R18 : CADRE_DEMPLOI
				    String grade = Util.notEmpty(row.getCell(17)) ? row.getCell(17).getStringCellValue() : "";

				    // COL S19 : CODE_METIER
				    String codeMetier = Util.notEmpty(row.getCell(18)) ? row.getCell(18).getStringCellValue() : "";
				    
				    // COL T20 : MISSION_POSTE
				    String mission = Util.notEmpty(row.getCell(19)) ? row.getCell(19).getStringCellValue().replaceAll("\n","<br>" ) : "";
				    
				    // COL U21 : ACTIVITES_POSTE
				    String activites = Util.notEmpty(row.getCell(20)) ? row.getCell(20).getStringCellValue().replaceAll("\n","<br>" ) : "";
				    
				    // COL V22 : COMPETENCES_DESCRIPTION_METIER
				    String competencesMetier = Util.notEmpty(row.getCell(21)) ? row.getCell(21).getStringCellValue().replaceAll("\n","<br>" ) : "";
				    
				    // COL W23 : TRAVAILLER_ENSEMBLE
				    String competencesTravailler = Util.notEmpty(row.getCell(22)) ? row.getCell(22).getStringCellValue().replaceAll("\n","<br>" ) : "";
				    
				    // COL X24 : CPTCES_NUMERIQUES
				    String competencesNumeriques = Util.notEmpty(row.getCell(23)) ? row.getCell(23).getStringCellValue().replaceAll("\n","<br>" ) : "";

				    // COL Y25 : COMMENTAIRE
				    String commentaire = Util.notEmpty(row.getCell(24)) ? row.getCell(24).getStringCellValue().replaceAll("\n","<br>" ) : "";
				    
				    // COL Z26 : HORAIRES
				    String horaires = Util.notEmpty(row.getCell(25)) ? row.getCell(25).getStringCellValue() : "";
				    
				    // COL AA27 : NBI
				    String nbi = Util.notEmpty(row.getCell(26)) ? row.getCell(26).getStringCellValue() : "";
				    
				    // COL AB28 : RESIDENCE
				    String residence = Util.notEmpty(row.getCell(27)) ? row.getCell(27).getStringCellValue() : "";
				    
				    // COL AC29 : SUJETIONS
				    String sujetion = Util.notEmpty(row.getCell(28)) ? row.getCell(28).getStringCellValue() : "";
				    
				    // COL AD30 : SUJETIONS_Autre
				    String sujetionAutre = Util.notEmpty(row.getCell(29)) ? row.getCell(29).getStringCellValue() : "";
				    
				    // COL AE31 : CARACTERISTIQUES_POSTE_1
				    String particularites1 = Util.notEmpty(row.getCell(30)) ? row.getCell(30).getStringCellValue() : "";
				    
				    // COL AF32 : CARACTERISTIQUES_POSTE_2
				    String particularites2 = Util.notEmpty(row.getCell(31)) ? row.getCell(31).getStringCellValue() : "";
				    
				    // COL AG33 : CARACTERISTIQUES_POSTE_3
				    String particularites3 = Util.notEmpty(row.getCell(32)) ? row.getCell(32).getStringCellValue() : "";
				    
				    // COL AH34 : CARACTERISTIQUES_POSTE_4
				    String particularites4 = Util.notEmpty(row.getCell(33)) ? row.getCell(33).getStringCellValue() : "";
				    
				    // COL AI35 : CARACTERISTIQUES_POSTE_5
				    String particularites5 = Util.notEmpty(row.getCell(34)) ? row.getCell(34).getStringCellValue() : "";
				    
				    // COL AJ36 : CARACTERISTIQUES_POSTE_6
				    String particularites6 = Util.notEmpty(row.getCell(35)) ? row.getCell(35).getStringCellValue() : "";
				    
				    // COL AK37 : CARACTERISTIQUES_POSTE_Autre
				    String particularitesAutre = Util.notEmpty(row.getCell(36)) ? row.getCell(36).getStringCellValue() : "";

				    /*
				    LOGGER.warn("Ligne "+i);
				    LOGGER.warn("libellePoste : "+libellePoste);
				    LOGGER.warn("libelleMetier : "+libelleMetier);
				    LOGGER.warn("numeroDePoste : "+numeroDePoste);
				    LOGGER.warn("titre : "+titre);
		        	LOGGER.warn("matriculeResponsable : "+matriculeResponsable);
		        	LOGGER.warn("responsable : "+responsable.getFullName());
		        	LOGGER.warn("fonctionResponsable : "+fonctionResponsable);
		        	
		        	LOGGER.warn("delegation : "+delegation + " / " + channel.getCategory(getIdCategorieDelegation(delegation)));
		        	LOGGER.warn("directiongenerale : "+directiongenerale);
					LOGGER.warn("direction : "+direction);
					LOGGER.warn("sousdirection : "+sousdirection);
					LOGGER.warn("service : "+service);
					LOGGER.warn("unite : "+unite);

					LOGGER.warn("rue : "+rue);
		        	LOGGER.warn("cp : "+cp);
		        	LOGGER.warn("ville : "+ville);
		        	
		        	LOGGER.warn("catEmploi : "+catEmploi + " / " + channel.getCategory(getIdCategoriePoste(catEmploi)));
		        	LOGGER.warn("filiere : "+filiere);
		        	LOGGER.warn("grade : "+grade);
					
		        	LOGGER.warn("codeMetier : "+codeMetier);
		        	
					LOGGER.warn("mission : "+mission);
					LOGGER.warn("activites : "+activites);
					LOGGER.warn("competencesMetier : "+competencesMetier);
					LOGGER.warn("competencesTravailler : "+competencesTravailler);
					LOGGER.warn("competencesNumeriques : "+competencesNumeriques);
					LOGGER.warn("commentaire : "+commentaire);
					
					LOGGER.warn("horaires : "+horaires);
					LOGGER.warn("nbi : "+nbi);
					LOGGER.warn("residence : "+residence);
					LOGGER.warn("sujetion : "+sujetion);
					LOGGER.warn("sujetionAutre : "+sujetionAutre);
					LOGGER.warn("particularites1 : "+particularites1);
					LOGGER.warn("particularites2 : "+particularites2);
					LOGGER.warn("particularites3 : "+particularites3);
					LOGGER.warn("particularites4 : "+particularites4);
					LOGGER.warn("particularites5 : "+particularites5);
					LOGGER.warn("particularites6 : "+particularites6);
					LOGGER.warn("particularitesAutre : "+particularitesAutre);
					LOGGER.warn("---------------");
					*/
				    
					AVPImport avp = new AVPImport();
					avp.setTitle(titre);
					avp.setLibellePoste(libellePoste);
					avp.setLibelleMetier(libelleMetier);
					avp.setNumeroDePoste(numeroDePoste);
					avp.setFonctionResponsable(fonctionResponsable);
					
					avp.setDirectiongenerale(directiongenerale);
					avp.setDirection(direction);
					avp.setSousdirection(sousdirection);
					avp.setService(service);
					avp.setUnite(unite);
					
					avp.setRue(rue);
					avp.setCp(cp);
					avp.setVille(ville);
					
					avp.setFiliere(filiere);
					avp.setGrade(grade);
					
					avp.setMission(mission);
					avp.setActivites(activites);
					avp.setCompetencesMetier(competencesMetier);
					avp.setCompetencesTravailler(competencesTravailler);
					avp.setCompetencesNumeriques(competencesNumeriques);
					avp.setCommentaire(commentaire);
					
					avp.setNbi(nbi);
					avp.setResidence(residence);
					avp.setParticularites1(particularites1);
					avp.setParticularites2(particularites2);
					avp.setParticularites3(particularites3);
					avp.setParticularites4(particularites4);
					avp.setParticularites5(particularites5);
					avp.setParticularites6(particularites6);
					avp.setParticularitesAutre(particularitesAutre);
					
					// On met le responsable comme contact
					if(Util.notEmpty(responsable)){
						avp.setTitreListeDeContacts("Contact(s)");
						avp.setContactsAgents(contactsAgents);
					}
					
					avp.setAuthor(channel.getDefaultAdmin());
					avp.setPstatus(-100);
					
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
					Date date = simpleDateFormat.parse("23/10/2017"); 
					avp.setDateLimiteDeDepot(date);
					avp.setWorkspace(channel.getWorkspace("p1_5327")); // Site thématique "Mobilité/Formation"
					
					// On value les champs de type "Catégorie"
					Category categorieEmploi = channel.getCategory(getIdCategoriePoste(catEmploi));
					Category categorieDelegation = channel.getCategory(getIdCategorieDelegation(delegation));
					// Par défaut lors de l'import le poste sera mis à "Proposé"
					Category categoriePostePropose = channel.getCategory("p1_756137");
					
					TreeSet<Category> categorySet = new TreeSet<Category>();
					if(Util.notEmpty(categorieEmploi)){
						categorySet.add(categorieEmploi);	
					}
					if(Util.notEmpty(categorieDelegation)){
						categorySet.add(categorieDelegation);
					}
					if(Util.notEmpty(categoriePostePropose)){
						categorySet.add(categoriePostePropose);
					}
					
					avp.setCategorySet(categorySet);
					
					// Create
					ControllerStatus status = avp.checkCreate(opAuthor);
					if (status.hasFailed()) {
						LOGGER.warn("ERREUR import AVP");
					    message = status.getMessage(userLang);
						channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
					} else {
					    avp.performCreate(opAuthor);
					}
				
					
				}

			}
	        inp.close();
			message =  "Import des membres terminé : " + cptOK + " membres ajoutés, " + cptNOK + " membres ignorés.";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.INFO, message));


		} catch (FileNotFoundException e) {
			message = "Impossible de trouver le fichier";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
		} catch (IOException e) {
			message = "Erreur lors de la lecture du fichier";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
			channel.getCurrentJcmsContext().getRequest().setAttribute("traceImport", e);
		} catch (InvalidFormatException e) {
			message = "Format de fichier incorrect";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
		} catch (Exception e){
			message = "Une erreur est survenue";
			channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
			LOGGER.warn("Exception : "+e.getMessage());
		} finally{
			try {
				file.delete();
			} catch (Exception e) {
				LOGGER.error(e.getMessage());
			}
		}		

		return message;
	}

	/* Teste si le répertoire d'upload du fichier existe. 
	 * Création dans le cas contraire.
	 * */
	public static boolean initPath(){
		boolean result = true;
		try{
			File f = new File(pathFile);
			if (!f.exists()) {
				f.mkdir();
				LOGGER.info("Création du pathFile " + pathFile);
			}
		}
		catch(Exception e){
			result = false;
		}
		return result;
	}
	
	/* Upload le fichier reçu du formulaire et renvoie son path dans un attribut.
	 * Cela permet de placer le path dans un champ caché pour être utilisé lors de l'étape d'import. 
	 * */
	public static boolean uploadFile(FileItem fileItem, String dateStr){
		boolean result = false;
		try {		
			File file = new File(pathFile+originalFileName+"_"+dateStr+fileExtensionXlsx);
			fileItem.write(file);
			result = true;
			channel.getCurrentJcmsContext().getRequest().setAttribute("pathFichierUpload", file.getAbsolutePath());
		} catch (IOException e) {
			LOGGER.error("Impossible de lire le fichier csv", e);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		return result;
	}
	
	
	public void setDelegation(String[] v) {
	    updateCids(v);
	  }
	
	public void updateCids(String[] paramArrayOfString)
	  {
	    if (this.cids == null)
	    {
	      this.cids = paramArrayOfString;
	      return;
	    }
	    String[] arrayOfString = new String[this.cids.length + paramArrayOfString.length];
	    System.arraycopy(this.cids, 0, arrayOfString, 0, this.cids.length);
	    System.arraycopy(paramArrayOfString, 0, arrayOfString, this.cids.length, paramArrayOfString.length);
	    this.cids = arrayOfString;
	  }	
	
	public static String getIdCategoriePoste(String libelle){
		if(libelle.equals("Catégorie A")){
			return "p1_26888";
		}
		if(libelle.equals("Catégorie B")){
			return "p1_26889";
		}
		if(libelle.equals("Catégorie C")){
			return "p1_26890";
		}
		
		return null;
	}
	
	public static String getIdCategorieDelegation(String libelle){
		// Délégation Ancenis
		if(libelle.equals("DELEGATION ANCENIS")){
			return "p2_158927";
		}
		// Délégation Châteaubriant
		if(libelle.equals("DELEGATION CHATEAUBRIANT")){
			return "p2_158928";
		}
		// Délégation Nantes
		if(libelle.equals("DELEGATION NANTES")){
			return "p1_5325";
		}
		// Délégation Pays de Retz
		if(libelle.equals("DELEGATION PAYS DE RETZ")){
			return "p2_158929";
		}
		// Délégation Saint Nazaire
		if(libelle.equals("DELEGATION SAINT NAZAIRE")){
			return "p1_5326";
		}
		//Délégation Vignoble
		if(libelle.equals("DELEGATION VIGNOBLE")){
			return "p2_158930";
		}
		// Siège
		if(libelle.equals("SIEGE")){
			return "p1_747230";
		}
		
		
		return null;
	}
	
	

}
