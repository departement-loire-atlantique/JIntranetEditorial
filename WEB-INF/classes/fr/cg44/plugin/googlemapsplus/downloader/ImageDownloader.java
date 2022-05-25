package fr.cg44.plugin.googlemapsplus.downloader;

import java.io.File;

import org.apache.commons.io.FileUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;

public class ImageDownloader implements Downloader {

	protected static final Logger LOGGER = Logger.getLogger(Downloader.class);

	protected static final String userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.11 Safari/537.36";

	protected static final String origin = "https://www.loire-atlantique.fr/";

	public void GetImage(String strUrl, String fileType, File file) {

		GetImage(strUrl, fileType, file, userAgent, origin);

	}

	public void GetImage(String strUrl, String fileType, File file, String origin) {

		GetImage(strUrl, fileType, file, userAgent, origin);

	}

	public void GetImage(String strUrl, String fileType, File file, String userAgent, String origin) {

		CloseableHttpClient httpClient = HttpClients.createDefault();

		HttpGet httpGet = new HttpGet(strUrl.toString());
		httpGet.addHeader("User-Agent", userAgent);
		httpGet.addHeader("origin", origin);

		try {
			CloseableHttpResponse httpResponse = httpClient.execute(httpGet);
			HttpEntity imageEntity = httpResponse.getEntity();

			if (imageEntity != null) {
				FileUtils.copyInputStreamToFile(imageEntity.getContent(), file);
			}

		} catch (Exception e) {
			LOGGER.error("Image downloader error ", e);
		}

		httpGet.releaseConnection();

	}

}