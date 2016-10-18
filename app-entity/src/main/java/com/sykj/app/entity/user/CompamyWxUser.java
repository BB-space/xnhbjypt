package com.sykj.app.entity.user;
/**
 * 企业号用户信息表
 * @author swh
 *
 */
public class CompamyWxUser extends WxUser implements java.io.Serializable{

	private Integer applyId;//应用ID
	private String compamyUserId;//企业号用户ID，唯一
	private String position;//职位
	private String department;//成员所属部门id列表
	private String weixinid;//微信号
	private String email;//邮箱
	private String extattr;//扩展属性
	private String mobile;//手机号
	private String name;//姓名
	
	public Integer getApplyId() {
		return applyId;
	}
	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}
	public String getCompamyUserId() {
		return compamyUserId;
	}
	public void setCompamyUserId(String compamyUserId) {
		this.compamyUserId = compamyUserId;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getWeixinid() {
		return weixinid;
	}
	public void setWeixinid(String weixinid) {
		this.weixinid = weixinid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getExtattr() {
		return extattr;
	}
	public void setExtattr(String extattr) {
		this.extattr = extattr;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
