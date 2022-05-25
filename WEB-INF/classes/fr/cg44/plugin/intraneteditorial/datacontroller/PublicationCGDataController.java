package fr.cg44.plugin.intraneteditorial.datacontroller;

import java.util.Map;

import generated.PublicationCG;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Data;
import com.jalios.jcms.FieldStatus;
import com.jalios.jcms.Member;
import com.jalios.util.Util;

/**
 * - Permet de vérifier si au moins un champs contact et contact papier sont renseignés
 * - Ajoute le signe obligatoire pour le champ nombre de page
 * @author MFO
 */
public class PublicationCGDataController extends BasicDataController {

    public ControllerStatus checkIntegrity(Data data) {
        PublicationCG pub = (PublicationCG)data;
        // Vérifie le contact de la publication
        if(Util.isEmpty(pub.getContactAgent()) && Util.isEmpty(pub.getContactUniteOrganisationnelle())){
            return new ControllerStatus("Attention le contact publication n'est pas renseigné");
        }
        // Vérifie le contact papier
        if(Util.isEmpty(pub.getContactPourVersionPapierAgent()) && Util.isEmpty(pub.getContactPourVersionPapierUniteOrg())){
            return new ControllerStatus("Attention le contact papier n'est pas renseigné");
        }
        return ControllerStatus.OK;
    }
    
    
    public void processFieldStatusMap(Data data, Member mbr, Map<String, FieldStatus> map) {
        PublicationCG pub = (PublicationCG)data;
        updateFieldStatusMap(map, "nombreDePages", FieldStatus.REQUIRED);
    }
    
    
}
