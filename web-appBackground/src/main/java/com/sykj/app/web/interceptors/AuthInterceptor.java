package com.sykj.app.web.interceptors;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sykj.app.entity.system.Resources;
import com.sykj.app.entity.user.User;
import com.sykj.app.model.SessionInfo;
import com.sykj.app.model.UserM;
import com.sykj.app.service.system.MenuService;
import com.sykj.app.service.system.ResourcesService;
import com.sykj.app.service.user.UserService;
import com.sykj.app.util.RequestUtil;
import com.sykj.app.util.ResourceUtil;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	@Resource
	private ResourcesService resourcesService;
	@Resource
	private UserService userService;
	@Resource
	private MenuService menuService;
	/**
	 * 完成页面的render后调用
	 */
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception exception) throws Exception {
	}

	/**
	 * 在调用controller具体方法后拦截
	 */
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView modelAndView) throws Exception {

	}

	/**
	 * 在调用controller具体方法前拦截
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		String requestPath = RequestUtil.getRequestPath(request);// 用户访问的资源地址
//		System.out.println("&&^**((&^"+requestPath);
//		Resources resources =resourcesService.getResourcesBySrc(requestPath);
//		if(resources==null){
//			forward("数据库缺失【" + requestPath + "】资源！", request, response);
//			return false;
//		}
//		if(resources.getOnoff().equals("0")){
//			return true;
//		}
//		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(ResourceUtil.getSessionInfoName());
//		if (sessionInfo == null) {// 没有登录系统，或登录超时
//			String path = "/background/login.jsp";
//		    response.setCharacterEncoding("utf-8");        
//		    response.setContentType("text/html; charset=utf-8"); 
//	        PrintWriter out = response.getWriter();  
//	        StringBuilder builder = new StringBuilder();  
//	        builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");  
//	        builder.append("alert(\"没有登录系统，或登录超时，请重新登录\");");  
//	        builder.append("window.top.location.href=\"");
//	        builder.append(path);
//	        builder.append("</script>");  
//	        out.print(builder.toString());  
//	        out.close(); 
//			return false;
//		}
//
//		User user = sessionInfo.getUser();
//		if(user!=null ){
//		if (user.getId().equals("0")) {// 超级管理员不需要验证权限
//			return true;
//		}
//		if(resourcesService.checkAuth(user.getId(),requestPath)){
//			return true;
//		}else{
//			forward("您没有【" + resources.getText() + "】权限，请联系管理员给您赋予相应权限！", request, response);
//			return false;
//		}
//	}
		
		System.out.println(requestPath.contains("test")+"234");
		if(requestPath.contains("test")||requestPath.contains("kaptcha")||requestPath.contains("safe")||requestPath.contains("code")){
			System.out.println("*****"+requestPath);
			return true;
		}
		if(requestPath.contains("/compamy/coreServlet.do")){
			return true;
		}
		Resources resources =resourcesService.getResourcesBySrc(requestPath);
		response.setCharacterEncoding("utf-8");
		if(resources==null){
			System.out.println("---------------------first"+requestPath);
			requestPath = request.getRequestURI().substring(request.getContextPath().length());
			resources = resourcesService.getResourcesBySrc(requestPath);
			if(resources==null){
				System.out.println("---------------------second"+requestPath);
				forward("数据库缺失【" + requestPath + "】资源！", request, response);
				return false;
			}
		}
		if(resources.getOnoff().equals("0")){
			return true;
		}
		
		if(requestPath.equals("/weChat.do?login")){
			String wxurl="https://open.weixin.qq.com/connect/qrconnect?appid=wx100e8ffec08db0c7&redirect_uri="+
						 "http%3A%2F%2Fwww.haircentre.cn%2Fykt%2FweChat%2Fcallback.do&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
			response.sendRedirect(wxurl);
			return false;
		}
		if(requestPath.length() == 19) {
			if(requestPath.substring(1,19).equals("weChat/callback.do")){
				return true;
			}
		}
		if(requestPath.equals("/wxRegistered.do?registered")){
			return true;
		}
		UserM userM = (UserM) request.getSession().getAttribute("userM");
		if(userM==null){
			System.out.println("session失效处理");
			doSessionOut(request,response);//处理用户长时间未操作
			return false;
		}
		return true;
	}
	
	private void forward(String msg, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("msg", msg);
		request.getRequestDispatcher("resources/error/authMsg.jsp").forward(request, response);
	}
	
	/**
	 * 用户session失效处理方法
	 * @throws IOException 
	 */
	public void doSessionOut(HttpServletRequest request, HttpServletResponse response) throws IOException{
		StringBuilder builder = new StringBuilder(); 
        builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");  
		String path =request.getContextPath();
		Cookie[] cookies = request.getCookies();//获得cookies
		String userName = RequestUtil.getCookie(cookies,"userName");//获得cookies里面的用户名
		String userPassword = RequestUtil.getCookie(cookies,"userPassword");//获得cookies里面的密码
		UserM userM =userService.login(userName,userPassword);//校验用户名和密码
		if (userM != null) {
			userM.setUserPassword(userPassword);
			RequestUtil.addUserCookie(response, userM);//添加用户到cookie
			HashSet<String> set = menuService.roleMenuIdSet(userM);
			userM.setRoleMenuIdSet(set);
			request.getSession().setAttribute("userM", userM);
			//builder.append("alert(\"进入session失效处理方法！\");"); 
			path+="/index.do";
		}else{
			builder.append("alert(\"您已经太久没登陆了，请重新登录！\");");  
			path+="/index.jsp";
		}
	    response.setContentType("text/html; charset=utf-8"); 
        PrintWriter out = response.getWriter();  
        builder.append("window.top.location.href=\"");
        builder.append(path);
        builder.append("\"");
        builder.append("</script>");  
        out.print(builder.toString());  
        out.close();
	}
}
