package com.sykj.app.entity.user;

import java.util.Date;

/**
 * @author wjl 2016年9月22日 下午3:39:35
 */
public class UserSubCenter implements java.io.Serializable{

	private String id;//主键
	private String userId;//用户id
	private String subcenterId;//分中心id
	private Date createTime;//添加时间
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSubcenterId() {
		return subcenterId;
	}
	public void setSubcenterId(String subcenterId) {
		this.subcenterId = subcenterId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
