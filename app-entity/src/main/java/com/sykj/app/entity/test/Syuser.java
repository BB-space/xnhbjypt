package com.sykj.app.entity.test;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户
 * Syuser entity. @author MyEclipse Persistence Tools
 */

public class Syuser implements java.io.Serializable {

	// Fields
	private String id;//主键
	private String name;//用户名
	private String password;//密码
	private String type;//用户类型
	private String realname;//用户实名
	private Date createdatetime;//创建时间
	private Date modifydatetime;//最后修改时间
	private String isValidation;//是否已验证（1为已验证，0为未验证）
	private String isoldUser;//是否老用户（1为老用户）
	private Date activateDatetime;//用户激活时间(如果新注册，注册时间就是激活时间）
	private Set syuserSyroles = new HashSet(0);
	private Set syuserSyorgs = new HashSet(0);
	private Set syuserSyjobs = new HashSet(0);
	
	// Constructors

	/** default constructor */
	public Syuser() {
	}

	/** minimal constructor */
	public Syuser(String id, String name, String password) {
		this.id = id;
		this.name = name;
		this.password = password;
	}


	
	public Syuser(String id, String name, String password, String type,
			String realname, Date createdatetime, Date modifydatetime,
			String isValidation, Set syuserSyroles, Set syuserSyorgs,
			Set syuserSyjobs) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.type = type;
		this.realname = realname;
		this.createdatetime = createdatetime;
		this.modifydatetime = modifydatetime;
		this.isValidation = isValidation;
		this.syuserSyroles = syuserSyroles;
		this.syuserSyorgs = syuserSyorgs;
		this.syuserSyjobs = syuserSyjobs;
	}

	public String getId() {
		return this.id;
	}
	
	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatedatetime() {
		return this.createdatetime;
	}

	public void setCreatedatetime(Date createdatetime) {
		this.createdatetime = createdatetime;
	}

	public Date getModifydatetime() {
		return this.modifydatetime;
	}

	public void setModifydatetime(Date modifydatetime) {
		this.modifydatetime = modifydatetime;
	}

	public Set getSyuserSyroles() {
		return this.syuserSyroles;
	}

	public void setSyuserSyroles(Set syuserSyroles) {
		this.syuserSyroles = syuserSyroles;
	}

	public Set getSyuserSyorgs() {
		return syuserSyorgs;
	}

	public void setSyuserSyorgs(Set syuserSyorgs) {
		this.syuserSyorgs = syuserSyorgs;
	}


	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


	public Set getSyuserSyjobs() {
		return syuserSyjobs;
	}

	public void setSyuserSyjobs(Set syuserSyjobs) {
		this.syuserSyjobs = syuserSyjobs;
	}
	
	public String getIsValidation() {
		return isValidation;
	}

	public void setIsValidation(String isValidation) {
		this.isValidation = isValidation;
	}

	public String getIsoldUser() {
		return isoldUser;
	}

	public void setIsoldUser(String isoldUser) {
		this.isoldUser = isoldUser;
	}

	public Date getActivateDatetime() {
		return activateDatetime;
	}

	public void setActivateDatetime(Date activateDatetime) {
		this.activateDatetime = activateDatetime;
	}
	
}