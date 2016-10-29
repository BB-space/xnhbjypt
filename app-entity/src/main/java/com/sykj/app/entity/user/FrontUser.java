package com.sykj.app.entity.user;

import java.util.Date;
/**
 * 用户主表
 * @author lsq
 *
 */
public class FrontUser  implements java.io.Serializable {

	private String id;//
	private String userName;//手机号码/邮箱地址
	private String password;//密码
	private Date createTime;//创建时间
	private Date updateTime;//更新时间
	
	public FrontUser(){
		
	}
	public FrontUser(String id, String userName, String password, Date createTime, Date updateTime) {
		super();
		this.id = id;
		this.userName = userName;
		this.password = password;
		this.createTime = createTime;
		this.updateTime = updateTime;
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
	
}
