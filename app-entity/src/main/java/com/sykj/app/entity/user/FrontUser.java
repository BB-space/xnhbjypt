package com.sykj.app.entity.user;

import java.util.Date;
/**
 * 用户主表
 * @author lsq
 *
 */
public class FrontUser  implements java.io.Serializable {

	private String id;//
	private Date createTime;//创建时间
	private Date updateTime;//更新时间
	private String createUser; //创建人
	private String updateUser;//修改人
	private String userName;//手机号码/邮箱地址
	private String password;//密码
	private String description; //描述
	
	public FrontUser(){
		
	}
	public FrontUser(String id, Date createTime, Date updateTime, String createUser, String updateUser, String userName,
			String password, String description) {
		super();
		this.id = id;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.createUser = createUser;
		this.updateUser = updateUser;
		this.userName = userName;
		this.password = password;
		this.description = description;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
