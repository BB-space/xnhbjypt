package com.sykj.app.web.interceptors;

import java.net.UnknownHostException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.java_websocket.WebSocketImpl;

import com.sykj.app.websocket.websocketOnline.OnlineChatServer;
/**
 * 重写init方法，使tomcat启动后，websocket同时启动
 * @author swh
 *
 */
public class InitServlet extends HttpServlet{

	
	public void init() throws ServletException {
		System.out.println("启动websocket服务");
		// 获取web.xml中配置的参数
		String prot = getInitParameter("port");
		WebSocketImpl.DEBUG = false;
		OnlineChatServer s;
		try {
			s = new OnlineChatServer(Integer.parseInt(prot));
			s.start();
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
}
