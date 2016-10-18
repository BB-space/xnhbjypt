package com.sykj.app.websocket.websocketOnline;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.java_websocket.WebSocket;



/**
 * 在线管理
 */
public class OnlineChatServerPool {

	private static final Map<WebSocket,String> userconnections = new HashMap<WebSocket,String>();
	
	/**
	 * 获取用户名
	 * @param session
	 */
	public static String getUserByKey(WebSocket conn){
		return userconnections.get(conn);
	}
	
	/**
	 * 获取在线总数
	 * @param 
	 */
	public static int getUserCount(){
		return userconnections.size();
	}
	
	/**
	 * 获取WebSocket
	 * @param user
	 */
	public static WebSocket getWebSocketByUser(String user){
		Set<WebSocket> keySet = userconnections.keySet();
		synchronized (keySet) {
			for (WebSocket conn : keySet) {
				String cuser = userconnections.get(conn);
				//System.out.println("cuser:"+cuser);
				if(cuser.equals(user)){
					return conn;
				}
			}
		}
		return null;
	}
	
	public static String getAllUsercon(){
		Set<WebSocket> keySet = userconnections.keySet();
		StringBuilder sbd = new StringBuilder();
		synchronized (keySet) {
			for (WebSocket conn : keySet) {
				String cuser = userconnections.get(conn);
				sbd.append(cuser).append(",");
				//System.out.println("cuser:"+cuser);
			}
		}
		return sbd.toString();
	}
	
	/**
	 * 向连接池中添加连接
	 * @param inbound
	 */
	public static void addUser(String user, WebSocket conn){
		userconnections.put(conn,user);	//添加连接
	}
	
	/**
	 * 获取所有的在线用户
	 * @return
	 */
	public static Collection<String> getOnlineUser(){
		List<String> setUsers = new ArrayList<String>();
		Collection<String> setUser = userconnections.values();
		for(String u:setUser){
			setUsers.add(u);
		}
		return setUsers;
	}
	
	/**
	 * 移除连接池中的连接
	 * @param inbound
	 */
	public static boolean removeUser(WebSocket conn){
		if(userconnections.containsKey(conn)){
			userconnections.remove(conn);	//移除连接
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 向特定的用户发送数据
	 * @param user
	 * @param message
	 */
	public static void sendMessageToUser(WebSocket conn,String message){
		if(null != conn){
			System.out.println("conn:"+conn+"^"+"message:"+message);
			conn.send(message);
		}
	}
	
	/**
	 * 向所有的用户发送消息
	 * @param message
	 */
	public static void sendMessage(String message){
		Set<WebSocket> keySet = userconnections.keySet();
		synchronized (keySet) {
			for (WebSocket conn : keySet) {
				String user = userconnections.get(conn);
				if(user != null){
					conn.send(message);
				}
			}
		}
	}
	
	public static void main( String[] args ) throws InterruptedException , IOException {
		Set<WebSocket> keySet = userconnections.keySet();
		System.out.println(userconnections.size());
		for (WebSocket conn : keySet) {
			String cuser = userconnections.get(conn);
			System.out.println(cuser);
		}
		//System.out.println(ChatServerPool.getWebSocketByUser("0025c37c-33e0-4b0f-ad61-6b8a55257a53"));
	}
}
