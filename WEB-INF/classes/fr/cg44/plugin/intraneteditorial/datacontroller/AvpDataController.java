package fr.cg44.plugin.intraneteditorial.datacontroller;

import generated.AVP;

import java.util.Date;
import java.util.Map;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Data;
import com.jalios.jcms.Member;
import com.jalios.util.Util;

/**
 * Place la date limite de dépôt dans la date de tri. Cela permettra d'avoir le tri adéquat.
 * @author SGU
 */
public class AvpDataController extends BasicDataController {
	
	@Override
	public void beforeWrite(Data data, int op, Member mbr, Map context) {
		if(data instanceof AVP){
			AVP pub = (AVP) data; 
			if(OP_CREATE==op || OP_UPDATE==op){
				if(Util.notEmpty(pub.getDateLimiteDeDepot())){
					Date dateLimite = pub.getDateLimiteDeDepot();
					pub.setSdate(dateLimite);
				}
			}

		}

	}
}
