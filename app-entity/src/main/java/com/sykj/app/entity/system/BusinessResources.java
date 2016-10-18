package com.sykj.app.entity.system;

/**
 * 职务资源映射表
 * @author wjl 2016年10月12日 上午9:39:00
 */
public class BusinessResources implements java.io.Serializable  {

	private String id;
	private Business business;//职务
	private Resources resources;//资源
	
	public BusinessResources(){
		
	}
	
	public BusinessResources(String id, Business business, Resources resources) {
		super();
		this.id = id;
		this.business = business;
		this.resources = resources;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Business getBusiness() {
		return business;
	}

	public void setBusiness(Business business) {
		this.business = business;
	}

	public Resources getResources() {
		return resources;
	}

	public void setResources(Resources resources) {
		this.resources = resources;
	}
	
}