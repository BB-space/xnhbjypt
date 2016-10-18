package com.sykj.app.entity.user;

import com.sykj.app.entity.system.Role;

/**
 * 用户角色关系表
 * @author swh
 *
 */
public class UserRole implements java.io.Serializable{

	private String id;//主键
	private User user;//用户
	private Role role;//角色
	
	public UserRole(){
		
	}
	public UserRole(String id, User user, Role role) {
		super();
		this.id = id;
		this.user = user;
		this.role = role;
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
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	
	
}
