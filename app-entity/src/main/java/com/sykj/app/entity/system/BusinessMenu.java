package com.sykj.app.entity.system;

/**
 * 职务菜单映射表
 * @author wjl 2016年10月12日 上午9:34:59
 */
public class BusinessMenu implements java.io.Serializable{

	private String id;
	private Business business;//职务
	private Menu menu;//菜单
	
	public BusinessMenu(){
		
	}
	
	public BusinessMenu(String id, Business business, Menu menu) {
		super();
		this.id = id;
		this.business = business;
		this.menu = menu;
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

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	
}
