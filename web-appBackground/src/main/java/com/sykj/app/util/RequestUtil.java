package com.sykj.app.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sykj.app.model.UserM;

/**
 * request工具类
 * 
 * 
 * 
 */
public class RequestUtil {

	/**
	 * 获得请求路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequestPath(HttpServletRequest request) {
		String requestPath = request.getRequestURI() + "?" + request.getQueryString();
		System.out.println("***"+request.getRequestURI() + "?" + request.getQueryString());
		if (requestPath.indexOf("&") > -1) {// 去掉其他参数
			requestPath = requestPath.substring(0, requestPath.indexOf("&"));
		}
		requestPath = requestPath.substring(request.getContextPath().length());// 去掉项目路径
		return requestPath;
	}
	
	/**
	 * 添加用户名和密码到cookie
	 * @param response
	 * @param user
	 */
	public static void addUserCookie(HttpServletResponse response,UserM user){
		Cookie cUserName = new Cookie("userName",user.getUserName());  
	    Cookie cPassword = new Cookie("userPassword",user.getUserPassword()); 
	    cUserName.setMaxAge(60*60*24*365);//保留7天  
	    cPassword.setMaxAge(60*60*24*365);//保留7天  
	    response.addCookie(cUserName);
	    response.addCookie(cPassword);
	}
	/**
	 * 获得cookie里的值
	 * @param cookies
	 * @return
	 */
	public static String getCookie(Cookie[] cookies,String str){
		for (Cookie cookie : cookies) {
		    if (cookie.getName().equals(str)) {
		    	str = cookie.getValue();
			return str;
		    }
		}
		return null;
	}

}
