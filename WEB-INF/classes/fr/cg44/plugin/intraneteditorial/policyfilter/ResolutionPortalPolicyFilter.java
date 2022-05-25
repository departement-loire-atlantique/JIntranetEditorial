package fr.cg44.plugin.intraneteditorial.policyfilter;

import generated.PortalJspCollection;
import generated.PortletPortalRedirect;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;

import static com.jalios.jcms.Channel.getChannel;

import com.jalios.jcms.Publication;
import com.jalios.jcms.policy.BasicPortalPolicyFilter;
import com.jalios.jcms.portlet.Portal;
import com.jalios.jcms.portlet.PortalInterface;
import com.jalios.jcms.portlet.PortalManager;
import com.jalios.util.Util;

/**
 * Obsolete
 * Règles de résolution de portail pour les contenu forcé sur un portail spécifique
 * 
 */
public class ResolutionPortalPolicyFilter extends BasicPortalPolicyFilter {

    private static final Logger LOGGER = Logger.getLogger(ResolutionPortalPolicyFilter.class);

    // Le portal servant pour les contenus devant s'afficher en full
    private static final String FULL_PORTAL_PROP = "$id.jcmsplugin.intraneteditorial.fulldisplay.portal";
    // Les types de contenu qui doivent être dans le portal full
    private static final String FULL_TYPE_PROP = "jcmsplugin.intraneteditorial.fulldisplay.type";
    // La catégorie technique qui désigne qu'un contenu est mis en avant si celui-ci y est catégorisé.
    private static final String SECTION_CAT_PROP = "$id.jcmsplugin.intraneteditorial.publication.section.categories";

    public void filterDisplayContext(PortalManager.DisplayContextParameters dcp) {

        ServletRequest request = getChannel().getCurrentServletRequest();

        if(request != null && request.getParameter("portal") != null){
            return;
        }

        Member loggedMember = getChannel().getCurrentLoggedMember();

        // Selection du portail une colonne pour certain type de contenu (configurable en property)
        List<String> typeFull = Arrays.asList(getChannel().getStringArrayProperty(FULL_TYPE_PROP, new String[] {}));
        Publication pub = getChannel().getPublication(dcp.id);	  
        if(pub != null && typeFull.contains(pub.getClass().getSimpleName())){
            PortalInterface portalStandard = (PortalInterface) getChannel().getPublication(FULL_PORTAL_PROP);
            if (portalStandard != null) {
                dcp.overrided = portalStandard;
            }		  
        }

        // Redirection pour les catégorie avec un contenu "mis en avant" (Contenu appartenant a la catégorie "mis en avant")
        Category cat = getChannel().getCategory(dcp.id);
        if(cat != null){
            Category publicationSectionCat = getChannel().getCategory(SECTION_CAT_PROP);
            Set<Publication> pubCat = cat.getPublicationSet();
            
            // Seulement les publication à l'état visible
            pubCat = (Set<Publication>) JcmsUtil.applyDataSelector(new TreeSet(pubCat), new Publication.VisibleStateSelector());
                       
            Boolean isRedirect = false;
            Boolean hasPortal = false;

            // Si il existe une redirection avec les droits sur le loggedMember alors ne pas forcer l'affichage du contenu "mis en avant"
            // Si il existe un portail sur la catgorie alors le portal est gardé lors de l'affichage du contenu "mis en avant"
            for(Publication pubCatIter : pubCat){
                if(pubCatIter instanceof PortletPortalRedirect && pubCatIter.canBeReadBy(loggedMember)){
                    isRedirect = true;
                }
                if(pubCatIter instanceof PortalJspCollection || pubCatIter instanceof Portal){
                    hasPortal = true;
                }
            }

            Set<Publication> pubCatSection = publicationSectionCat != null ? publicationSectionCat.getPublicationSet():null;
            Publication pubRedirect = (Publication) Util.getFirst(Util.interSet(pubCat, pubCatSection));
            if(!isRedirect && pubRedirect != null){
                dcp.id = pubRedirect.getId();
                // Re-calcul le nouveau portail de la publication si aucun portal n'est défini explicitement sur la catégorie courante
                if (!hasPortal){
                    filterDisplayContext(dcp);
                }
            }
        }
    }
}