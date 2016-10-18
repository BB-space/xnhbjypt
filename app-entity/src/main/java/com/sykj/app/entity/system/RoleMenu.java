package com.sykj.app.entity.system;

/**
 * 角色菜单映射类
 * @author swh
 *
 */
public class RoleMenu implements java.io.Serializable  {

	private String id;
	private Role role;//角色
	private Menu menu;//菜单
	
	public RoleMenu(){
		
	}
	
	public RoleMenu(String id, Role role, Menu menu) {
		super();
		this.id = id;
		this.role = role;
		this.menu = menu;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	
	
}
