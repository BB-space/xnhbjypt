package com.sykj.app.entity.user;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
/**
 * 用户主表
 * @author swh
 *
 */
public class User  implements java.io.Serializable {

	private String id;//
	private String userName;//用户名
	private String userPassword;//密码
	private Date createDateTime;//创建时间
	private String userType;//用户类型(0:后台管理用户，1：门店店员，2：会员，3：游客；4：店长； 5：客服;6:区域管理7：操作人员)
	private Set userRoles = new HashSet(0);
	private Date editDateTime;//编辑信息后的时间
	private Set userBusinesses = new HashSet(0);
	
	
	public User(){
		
	}
	public User(String id, String userName, String userPassword,
			Date createDateTime, String userType) {
		super();
		this.id = id;
		this.userName = userName;
		this.userPassword = userPassword;
		this.createDateTime = createDateTime;
		this.userType = userType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public Set getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(Set userRoles) {
		this.userRoles = userRoles;
	}
	public Date getEditDateTime() {
		return editDateTime;
	}
	public void setEditDateTime(Date editDateTime) {
		this.editDateTime = editDateTime;
	}
	public Set getUserBusinesses() {
		return userBusinesses;
	}
	public void setUserBusinesses(Set userBusinesses) {
		this.userBusinesses = userBusinesses;
	}
	
}
