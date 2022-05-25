package fr.cg44.plugin.intraneteditorial.queryfilter;

import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jalios.jcms.FileDocument;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryFilter;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.plugin.Plugin;
import com.jalios.jcms.plugin.PluginComponent;

/**
 * Permet d'exclure les images de la recherche front
 *
 */
public class SearchQueryFilter extends QueryFilter implements PluginComponent {

    private Logger logger;
    
    @Override
    public boolean init(Plugin plugin) {
        logger = plugin.getLogger();
        logger.debug("SearchQueryFilter is enabled");
        return true;
    }
    
    
    // ---------------------------------------------------------------
    // AllMemberQueryHandler
    // ---------------------------------------------------------------

    @Override
    public QueryResultSet filterResultSet(QueryHandler qh, QueryResultSet set, Map context) {

		if (!qh.isInFrontOffice()) {   
	        return set;   
	    }
		
	    for(Iterator itQueryResultSet = set.iterator() ; itQueryResultSet.hasNext();){
	    	Publication itPub = (Publication)itQueryResultSet.next();
	    	if(itPub instanceof FileDocument){
	    		FileDocument doc = (FileDocument)itPub;
	    		if(doc.getContentType().indexOf("image") != -1 || doc.getContentType().indexOf("flash") != -1 || doc.getContentType().indexOf("audio") != -1 || doc.getContentType().indexOf("video") != -1){
	    			itQueryResultSet.remove();
	    		}
	    	}
	    }
		return super.filterResultSet(qh, set, context);
	}  
    

}
