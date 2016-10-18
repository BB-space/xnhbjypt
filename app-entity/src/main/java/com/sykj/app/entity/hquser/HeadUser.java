package com.sykj.app.entity.hquser;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
/**
 * 总部用户表
 * @author zq
 *
 */
public class HeadUser  implements java.io.Serializable {

	private String id;//
	private String name;//用户名
	private String password;//密码
	private Date createDateTime;//创建时间
	
	
	public HeadUser() {
		super();
	}


	public HeadUser(String id, String name, String password, Date createDateTime) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.createDateTime = createDateTime;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public Date getCreateDateTime() {
		return createDateTime;
	}


	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	
	
	
}
