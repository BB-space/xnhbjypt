package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 用户信息表
 * @author lsq
 *
 */
public class FrontUserInfo implements java.io.Serializable  {

	private String id;//主键
	private String userId;//用户ID
	private String mobile;//手机
	private String email;//邮箱地址
	private double totalMoney;//总资产
	private String location;//地区
	private String realName;//真实姓名
	private String cardType;//证件类型
	private String cardNumber;//证件号码
	private String nickName;//昵称
	private Integer uid;//UID
	private String googleCheckCode;//google验证码
	private String tradePassword;//交易密码
	private Date lastModiTime;//最后修改时间
	private String emailStatus; //邮件激活状态
	private String uuid; //邮箱验证码
	private String mobileStatus; //邮件激活状态
	
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public double getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(double totalMoney) {
		this.totalMoney = totalMoney;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getGoogleCheckCode() {
		return googleCheckCode;
	}
	public void setGoogleCheckCode(String googleCheckCode) {
		this.googleCheckCode = googleCheckCode;
	}
	public String getTradePassword() {
		return tradePassword;
	}
	public void setTradePassword(String tradePassword) {
		this.tradePassword = tradePassword;
	}
	public Date getLastModiTime() {
		return lastModiTime;
	}
	public void setLastModiTime(Date lastModiTime) {
		this.lastModiTime = lastModiTime;
	}
	public String getEmailStatus() {
		return emailStatus;
	}
	public void setEmailStatus(String emailStatus) {
		this.emailStatus = emailStatus;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getMobileStatus() {
		return mobileStatus;
	}
	public void setMobileStatus(String mobileStatus) {
		this.mobileStatus = mobileStatus;
	}
}
