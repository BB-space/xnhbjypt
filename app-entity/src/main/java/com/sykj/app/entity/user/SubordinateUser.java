package com.sykj.app.entity.user;

import java.util.Date;
/**
 * 所属用户信息表
 * @author swh
 *
 */
public class SubordinateUser  implements java.io.Serializable {

	private String id;//
	private String userId;//用户编号
	private String openId;//所属的openID
	private Date createDateTime;//创建时间
	
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
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
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	@Override
	public String toString() {
		return "SubordinateUser [id=" + id + ", userId=" + userId + ", openId="
				+ openId + "]";
	}
	public SubordinateUser(String id, String userId, String openId) {
		super();
		this.id = id;
		this.userId = userId;
		this.openId = openId;
	}
	public SubordinateUser() {
		super();
	}
	
	
	
}
