package com.sykj.app.entity.system;

/**
 * 角色资源映射类
 * @author swh
 *
 */
public class RoleResources implements java.io.Serializable  {

	private String id;
	private Role role;//角色
	private Resources resources;//资源
	
	public RoleResources(){
		
	}
	
	public RoleResources(String id, Role role, Resources resources) {
		super();
		this.id = id;
		this.role = role;
		this.resources = resources;
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

	public Resources getResources() {
		return resources;
	}

	public void setResources(Resources resources) {
		this.resources = resources;
	}
	
	
}
