package com.sykj.app.entity.user;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
/**
 * 用户主表
 * @author swh
 *
 */
public class UserBound  implements java.io.Serializable {

	private String id;//
	private String openId;//
	private String mobile;//
	private String status;//
	
	
	public UserBound(){
		
	}


	public UserBound(String id, String openId, String mobile, String status) {
		super();
		this.id = id;
		this.openId = openId;
		this.mobile = mobile;
		this.status = status;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getOpenId() {
		return openId;
	}


	public void setOpenId(String openId) {
		this.openId = openId;
	}


	public String getMobile() {
		return mobile;
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
