package com.sykj.app.model;

public class FrontUserM {

	private String id;
	private String userName;
	private String password;
	private Integer uid;
	private String uuid;
	private double totalMoney;
	private String mobile;//手机
	private String email;//邮箱地址
	private String location;//地区
	private String realName;//真实姓名
	private String cardType;//证件类型
	private String cardNumber;//证件号码
	private String nickName;//昵称
	private String googleCheckCode;//google验证码
	private String tradePassword;//交易密码
	private String emailStatus;//邮件激活状态: 0未激活，1激活
	private String mobileStatus;//手机激活状态: 0未激活，1激活
	
	private String mobileCheckCode; //手机验证码
	private String checkCode; //图片验证码
	private String regType; //注册类型 mobile/email
	
	private String oldPassword; //旧密码
	
	
	@Override
	public String toString() {
		return "FrontUserM [id=" + id + ", userName=" + userName + ", password=" + password + ", uid=" + uid + ", uuid="
				+ uuid + ", totalMoney=" + totalMoney + ", mobile=" + mobile + ", email=" + email + ", location="
				+ location + ", realName=" + realName + ", cardType=" + cardType + ", cardNumber=" + cardNumber
				+ ", nickName=" + nickName + ", googleCheckCode=" + googleCheckCode + ", tradePassword=" + tradePassword
				+ ", emailStatus=" + emailStatus + ", mobileStatus=" + mobileStatus + ", mobileCheckCode="
				+ mobileCheckCode + ", checkCode=" + checkCode + ", regType=" + regType + "]";
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
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public double getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(double totalMoney) {
		this.totalMoney = totalMoney;
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
	public String getEmailStatus() {
		return emailStatus;
	}
	public void setEmailStatus(String emailStatus) {
		this.emailStatus = emailStatus;
	}
	public String getMobileStatus() {
		return mobileStatus;
	}
	public void setMobileStatus(String mobileStatus) {
		this.mobileStatus = mobileStatus;
	}
	public String getMobileCheckCode() {
		return mobileCheckCode;
	}
	public void setMobileCheckCode(String mobileCheckCode) {
		this.mobileCheckCode = mobileCheckCode;
	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public String getRegType() {
		return regType;
	}
	public void setRegType(String regType) {
		this.regType = regType;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	
	
}
