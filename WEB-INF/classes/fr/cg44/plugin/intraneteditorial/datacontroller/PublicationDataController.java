package fr.cg44.plugin.intraneteditorial.datacontroller;

import generated.Article;
import generated.PublicationCG;
import generated.SmallNews;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.FileDocument;
import com.jalios.jcms.Publication;
import com.jalios.jcms.WikiRenderer;
import com.jalios.util.HtmlUtil;

/**
 * Limite le nombre de caractère de la description sur article breve et document
 * @author MFO
 */
public class PublicationDataController extends BasicDataController {
	
	/**
	 * Limite à un seul contenu mis en avant par catégorie.
	 */
	public ControllerStatus checkIntegrity(Data data) {
		
	    Publication pub = (Publication)data;
	    	    
	    // Limite le nombre de caractère de la description sur article breve et document
	    // wysiwyg
	    if(data instanceof Article && HtmlUtil.html2text(pub.getAbstract()).length() > 340) {
            return new ControllerStatus("Le nombre de caractères limite pour le résumé est de 340 caractères");              
	    }
	    // wiki
	    if(data instanceof SmallNews && HtmlUtil.html2text(WikiRenderer.wiki2html(pub.getAbstract())).length() > 340) {
	        return new ControllerStatus("Le nombre de caractères limite pour le chapeau est de 340 caractères"); 
	    }
	    
	    
	    if(data instanceof PublicationCG){
	        PublicationCG pubCG = (PublicationCG) data;
	        if(pubCG.getNombreDePages() <= 0) {
	            return new ControllerStatus("Le champ nombre de pages doit être supérieur à 0"); 
	        }
        }
	    
	    if(data instanceof FileDocument && HtmlUtil.html2text(WikiRenderer.wiki2html(pub.getAbstract())).length() > 340) {
            return new ControllerStatus("Le nombre de caractères limite pour la description est de 340 caractères"); 
        }
	    			
		return ControllerStatus.OK;
	}

}
