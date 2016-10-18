package com.sykj.app.util;

import java.io.UnsupportedEncodingException;

/**
 * @author wjl 2016年7月29日 上午9:57:24
 */
public class UrlCodeUtil {

	/**
	 * 解码
	 * @param source
	 * @return
	 */
	public static String decode(String source){
		String result = source;
		try {
			result = java.net.URLDecoder.decode(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 编码
	 * @param source
	 * @return
	 */
	public static String urlEncodeUTF8(String source) {
		String result = source;
		try {
			result = java.net.URLEncoder.encode(source, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return result;
	}
}
