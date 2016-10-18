package com.sykj.app.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringTODate {
	// 将字符串 转为时间戳
	public static String getTime(String user_time) {  
		String re_time = null;  
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		Date d;  
		try {  
		  
		  
		d = sdf.parse(user_time);  
		long l = d.getTime();  
		String str = String.valueOf(l);  
		re_time = str.substring(0, 10);  
		  
		  
		} catch (ParseException e) {  
		e.printStackTrace();  
		}  
		return re_time;  
		}
	// 将时间戳转为字符串  
	public static String getStrTime(String cc_time) {  
	String re_StrTime = null;  
	  
	  
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	// 例如：cc_time=1291778220  
	long lcc_time = Long.valueOf(cc_time);  
	re_StrTime = sdf.format(new Date(lcc_time * 1000L));  
	  
	  
	return re_StrTime;  
	  
	  
	} 
	
	public static void main(String[] args) {  
		  
		  
		String time = "2010-12-08 11:17:00";  
		  
		  
		System.out.println(time);  
		  
		  
		// 字符串=======>时间戳  
		  
		  
		String re_str = getTime(time);  
		System.out.println(re_str);  
		  
		  
		// 时间戳======>字符串  
		  
		  
		String data = getStrTime(re_str);  
		System.out.println(data);  
		} 
}
