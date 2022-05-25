package fr.cg44.plugin.googlemapsplus.downloader;

import java.io.File;

public interface Downloader {

	/**
	 * Récupère une image sur un site HTTPS en indiquant des entêtes
	 * 'User-Agent' et 'Origin' particulières
	 * 
	 * @param strUrl
	 *            URL du fichier
	 * 
	 * @param fileType
	 *            Type du fichier (ex. png)
	 * 
	 * @param file
	 *            Fichier où l'image sera enregistrée
	 * 
	 * @param userAgent
	 *            Entête 'User-Agent' indiquée dans la requête GET HTTP
	 * 
	 * @param origin
	 *            Entête 'Origin' indiquée dans la requête GET HTTP
	 * 
	 * @throws Exception
	 *             Exception en cas d'erreur à la connexion
	 */

	void GetImage(String strUrl, String fileType, File file, String userAgent, String origin);

	/**
	 * Récupère une image sur un site HTTPS en indiquant une entête 'User-Agent'
	 * particulière et une entête 'Origin' à 'www.loire-atlantique.fr'
	 * 
	 * @param strUrl
	 *            URL du fichier
	 * 
	 * @param fileType
	 *            Type du fichier (ex. png)
	 * 
	 * @param file
	 *            Fichier où l'image sera enregistrée
	 * 
	 * @param userAgent
	 *            Entête 'User-Agent' indiquée dans la requête GET HTTP
	 * 
	 * @throws Exception
	 *             Exception en cas d'erreur à la connexion
	 */

	void GetImage(String strUrl, String fileType, File file, String userAgent);

	/**
	 * Récupère une image sur un site HTTPS avec une entête 'User-Agent' par
	 * défaut et une entête 'Origin' à 'www.loire-atlantique.fr'
	 * 
	 * @param strUrl
	 *            URL du fichier
	 * 
	 * @param fileType
	 *            Type du fichier (ex. png)
	 * 
	 * @param file
	 *            Fichier où l'image sera enregistrée
	 * 
	 * @throws Exception
	 *             Exception en cas d'erreur à la connexion
	 */

	void GetImage(String strUrl, String fileType, File file);

}
