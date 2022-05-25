package fr.cg44.plugin.googlemapsplus;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.util.ServletUtil;

import fr.cg44.plugin.googlemapsplus.downloader.Downloader;

public class StaticMap {
	
	private static Channel channel = Channel.getChannel();
	
	private static final Logger LOGGER = Logger.getLogger(StaticMap.class);
	
	private static String maptilerApikey = channel.getProperty("plugin.googlemapsplus.maptiler.apikey");
	
	private static String timeoutStaticImageInDays = channel.getProperty("plugin.googlemapsplus.static.images.timeout.days");

	private static String retina = "@2x";
	
	public static String getSrc(String width, String height, String color, float latitude, float longitude, String zoom, Downloader imageLoaded) throws MalformedURLException {
		
		String staticAPI = "https://api.maptiler.com/maps/streets/static/"
					+ Float.toString(longitude) + "," + Float.toString(latitude) + "," + zoom + "/"
					+ width.replace("px", "") + "x" + height.replace("px", "") + retina + ".png"
					+ "?key=" + maptilerApikey + "&markers=" + Float.toString(longitude) + "," + Float.toString(latitude);
		
		LOGGER.debug("URL du service pour generation de la carte statique : " + staticAPI);
		
		String srcHashed = DigestUtils.sha256Hex(staticAPI);
		String parentDirectory = "maps/";
		String firstDirectory = srcHashed.substring(0, 1);
		String secondDirectory = srcHashed.substring(1, 2);
		String filePath = channel.getUploadPath(parentDirectory + firstDirectory + "/" + secondDirectory + "/" + srcHashed + ".png");
		String webappFilePath = "upload/"+ parentDirectory + firstDirectory + "/" + secondDirectory + "/" + srcHashed + ".png";
		File file = new File(filePath);
		
		// Si le fichier existe et qu'il n'est pas trop ancien, on ne le regénère pas
		if(file.exists() && !file.isDirectory()) {
	    
			Date today = new Date();
			Calendar SomeDaysAgo = new GregorianCalendar();
			SomeDaysAgo.setTime(today);
			int timeout = Integer.parseInt(timeoutStaticImageInDays);
			SomeDaysAgo.add(Calendar.DAY_OF_MONTH, -timeout);
			Date dateFile = new Date(file.lastModified());
			if (dateFile.after(SomeDaysAgo.getTime())) {
				LOGGER.debug("fichier récent, on ne regénère pas l'image.");
				return webappFilePath;
			}
			
		}
		
		LOGGER.debug("fichier ancien ou inexistant, on regénère l'image.");
		HttpServletRequest request = channel.getCurrentServletRequest();
		URL urlRequest = new URL(ServletUtil.getBaseUrl(request));
		String origin = urlRequest.getProtocol() + "://" + urlRequest.getAuthority();
		imageLoaded.GetImage(staticAPI, "png", file, origin);
		
		return webappFilePath;
	}

}
