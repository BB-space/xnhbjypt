package com.sykj.app.model;

import com.sykj.app.entity.user.User;

/**
 * session信息模型
 * 
 * 
 * 
 */
public class SessionInfo implements java.io.Serializable {

	private User storeUser;
	private User drUser;
	private User user;
	private User regUser;
	private UserM userM;
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getStoreUser() {
		return storeUser;
	}

	public void setStoreUser(User storeUser) {
		this.storeUser = storeUser;
	}

	public User getDrUser() {
		return drUser;
	}

	public void setDrUser(User drUser) {
		this.drUser = drUser;
	}

	public User getRegUser() {
		return regUser;
	}

	public void setRegUser(User regUser) {
		this.regUser = regUser;
	}

	public UserM getUserM() {
		return userM;
	}

	public void setUserM(UserM userM) {
		this.userM = userM;
	}

}
