package com.sykj.app.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.sql.Time;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.net.ssl.SSLContext;

import org.apache.commons.httpclient.NameValuePair;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

/**
 * 微信支付带证书工具类
 * @author swh
 *
 */
public class PayCertUtil {

	/**
	 * 调用微信商户平台证书
	 * @param certpath
	 * @param certpassword
	 * @return
	 * @throws KeyManagementException
	 * @throws UnrecoverableKeyException
	 * @throws NoSuchAlgorithmException
	 * @throws KeyStoreException
	 * @throws CertificateException
	 * @throws IOException
	 */
	public static CloseableHttpClient checkCertificate(String certpath,String certpassword) throws KeyStoreException, IOException {
		KeyStore keyStore  = KeyStore.getInstance("PKCS12");
		System.out.println(certpath+"*"+certpassword);
        FileInputStream instream = new FileInputStream(new File(certpath));
        try {
            try {
				keyStore.load(instream, certpassword.toCharArray());
			} catch (NoSuchAlgorithmException | CertificateException
					| IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        } finally {
            instream.close();
        }

        // Trust own CA and all self-signed certs
        SSLContext sslcontext = null;
		try {
			sslcontext = SSLContexts.custom()
			        .loadKeyMaterial(keyStore, certpassword.toCharArray())
			        .build();
		} catch (KeyManagementException | UnrecoverableKeyException
				| NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                sslcontext,"TLSv1".split(" ") , null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
        CloseableHttpClient httpclient = HttpClients.custom()
                .setSSLSocketFactory(sslsf)
                .build();

        return httpclient;
    }
	
	//生成订单号
    public static String getMchBillno(String mch_id){
        //商户订单号（每个订单号必须唯一）
        //组成： mch_id+yyyymmdd+10位一天内不能重复的数字。
        //接口根据商户订单号支持重入， 如出现超时可再调用。
        String time = DateUtil.format(new Date());

        return mch_id+time+randomChars(10);
    }
	//随机字符串
    public static String randomChars(int num){
        Random random = new Random();
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String str = "";
        for(int i=0;i<num;i++)
        {
            str+=chars.charAt(random.nextInt(62));
        }
        return str;
    }
    
    /**
     * 向微信发起带证书的请求
     * @param httpclient
     * @param entitys
     * @param url
     * @throws IOException
     */
    public static void sendByPost(CloseableHttpClient httpclient,String entitys,String url) throws IOException {
    	try {
            HttpPost httpPost = new HttpPost(url);//创建HttpPost对象
            if(entitys!=null){
                httpPost.setEntity(new StringEntity(entitys));
            }

            httpPost.setHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.2)");
            // 用逗号分隔显示可以同时接受多种编码
            httpPost.setHeader("Accept-Language", "zh-cn,zh;q=0.5");
            httpPost.setHeader("Accept-Charset", "GB2312,utf-8;q=0.7,*;q=0.7");

            CloseableHttpResponse response = httpclient.execute(httpPost);

            try {
                HttpEntity entity = response.getEntity();

                if (entity != null) {
                    System.out.println("----------------------------------------");
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent()));
                    String text;
                    while ((text = bufferedReader.readLine()) != null) {
                        System.out.println(text);
                    }
                    System.out.println("----------------------------------------");
                }
                EntityUtils.consume(entity);
            } finally {
                response.close();
            }
        } finally {
            httpclient.close();
        }
    }
	

}
