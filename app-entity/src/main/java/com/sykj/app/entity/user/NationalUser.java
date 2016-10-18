package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 国庆节新会员用户表
 * @author lsy
 *
 */
public class NationalUser implements java.io.Serializable{

	private String id;
	private String mobile;//号码
	private String sysdictionaryId;//参数表id
	private String describes;//用户描述
	private Date createDateTime; //创建时间
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getSysdictionaryId() {
		return sysdictionaryId;
	}
	public void setSysdictionaryId(String sysdictionaryId) {
		this.sysdictionaryId = sysdictionaryId;
	}
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public String getDescribes() {
		return describes;
	}
	public void setDescribes(String describes) {
		this.describes = describes;
	}
	
}
