package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 加盟商
 * @author wjl 2016年9月29日 上午10:46:43
 */
public class Franchisee implements java.io.Serializable{

	private String id;//主键
	private String userId;//用户id
	private String shopId;//门店id
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
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
