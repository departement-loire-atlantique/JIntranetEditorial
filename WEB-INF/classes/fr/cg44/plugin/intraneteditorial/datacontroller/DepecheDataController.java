package fr.cg44.plugin.intraneteditorial.datacontroller;


import static com.jalios.jcms.Channel.getChannel;
import generated.Depeches;
import generated.Incident;
import generated.InterventionPlanifiee;

import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;

import org.apache.log4j.Logger;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Data;
import com.jalios.jcms.DataController;
import com.jalios.jcms.Member;
import com.jalios.jcms.mail.MailMessage;
import com.jalios.util.Util;


/**
 * Envoi un e-mail lors de la création d'un incident ou d'une intervention planifiée
 */
public class DepecheDataController extends BasicDataController {

    private static final Logger LOGGER = Logger.getLogger(DepecheDataController.class);
    
	@Override
	public void afterWrite(Data data, int op, Member mbr, Map context) {	    
	    Depeches pub = (Depeches) data;
	    
	    // Evite le traitement quand on clique sur la duplication d'une dépêche
	    Data originalData = (Data) context.get(DataController.CTXT_ORIGINAL_DATA);	
	    if(originalData!=null){
	    	return;
	    }
	    
	    // Création (sans duplication) || Création via duplication de contenu (considéré comme un update JCMS) || Changement d'état de workflow (statut "Terminé")
	    if(op == OP_CREATE ||  op == OP_UPDATE && pub.getPstatus() == 1 || op == OP_UPDATE && pub.getPstatus() == 7 ){  
	       
	        HashMap<Object, Object> mapDepeche = new HashMap<Object, Object>(); 
	        mapDepeche.put("pub", pub);
						
			MailMessage msg = new MailMessage("debut-incident");
			msg.setFrom("assistance.numerique@loire-atlantique.fr");
			
			// Sujet et gabarit suivant le type de dépeche, incicent ou intervention
			// Fin d'intervention ou d'incident
			if(op == OP_UPDATE && pub.getPstatus() == 7) {
				msg.setContentHtmlFromJsp("/plugins/IntranetEditorialPlugin/jsp/numerique/gabaritsMail/gabarit_mess_retab_service.jsp", mbr, getChannel().getLanguage() , mapDepeche, null);           
                msg.setSubject("[Rétablissement de service] - " + pub.getTitle());
			}
			// Création d'un incident ou d'une intervention planifiée
			else {
				if(data instanceof Incident){
    			    msg.setContentHtmlFromJsp("/plugins/IntranetEditorialPlugin/jsp/numerique/gabaritsMail/gabarit_mess_assist_numerique_rouge.jsp", mbr, getChannel().getLanguage() , mapDepeche, null);			
    			    msg.setSubject("[Incident] - " + pub.getTitle());
    			}else if(data instanceof InterventionPlanifiee) {
    	            msg.setContentHtmlFromJsp("/plugins/IntranetEditorialPlugin/jsp/numerique/gabaritsMail/gabarit_mess_interv_planifiee.jsp", mbr, getChannel().getLanguage() , mapDepeche, null);          
    			    msg.setSubject("[Intervention planifiée] - " + pub.getTitle());
    			}
			    
			}
			
			// CC du mail
			msg.setTo("assistance.numerique@loire-atlantique.fr");
			if(Util.notEmpty(data.getAuthor().getEmail())){
				msg.setCc(data.getAuthor().getEmail());				
			}
				
			try {
                msg.send();
            } catch (MessagingException e) {                
                LOGGER.warn("impossible d'envoyer le mail pour la dépêche d'id: " + pub.getId() , e);
            }
			
		}
	}
}
