package com.sykj.app.entity.user;

import com.sykj.app.entity.system.Business;

/**
 * 用户职务关系表
 * @author wjl 2016年10月12日 上午9:43:16
 */
public class UserBusiness implements java.io.Serializable{

	private String id;//主键
	private User user;//用户
	private Business business;//职务
	
	public UserBusiness(){
		
	}
	public UserBusiness(String id, User user, Business business) {
		super();
		this.id = id;
		this.user = user;
		this.business = business;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Business getBusiness() {
		return business;
	}
	public void setBusiness(Business business) {
		this.business = business;
	}
}
