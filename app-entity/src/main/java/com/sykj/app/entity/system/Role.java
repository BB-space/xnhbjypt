package com.sykj.app.entity.system;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * 角色
 * @author swh
 *
 */
public class Role  implements java.io.Serializable  {
	
	private String id;
	private Role role;//父ID
	private String text;//角色名字
	private BigDecimal seq;//排序
	private String descript;//描述
	private String userType;//对应用户类型(0:后台管理用户，1：门店店员，2：会员，3：游客)
	private Set userRoles = new HashSet(0);//用户角色集合
	private Set roles = new HashSet(0);//父ID
	private Set roleResourceses = new HashSet(0);//角色资源集合
	private Set roleMenus = new HashSet(0);//角色菜单集合
	
	public Role(){
		
	}
	
	public Role(String id, Role role, String text, BigDecimal seq,
			String descript, Set userRoles, Set roles, Set roleResourceses,
			Set roleMenus) {
		super();
		this.id = id;
		this.role = role;
		this.text = text;
		this.seq = seq;
		this.descript = descript;
		this.userRoles = userRoles;
		this.roles = roles;
		this.roleResourceses = roleResourceses;
		this.roleMenus = roleMenus;
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
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public BigDecimal getSeq() {
		return seq;
	}
	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}
	public String getDescript() {
		return descript;
	}
	public void setDescript(String descript) {
		this.descript = descript;
	}
	public Set getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(Set userRoles) {
		this.userRoles = userRoles;
	}
	public Set getRoles() {
		return roles;
	}
	public void setRoles(Set roles) {
		this.roles = roles;
	}
	public Set getRoleResourceses() {
		return roleResourceses;
	}
	public void setRoleResourceses(Set roleResourceses) {
		this.roleResourceses = roleResourceses;
	}

	public Set getRoleMenus() {
		return roleMenus;
	}

	public void setRoleMenus(Set roleMenus) {
		this.roleMenus = roleMenus;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}	
	
}
