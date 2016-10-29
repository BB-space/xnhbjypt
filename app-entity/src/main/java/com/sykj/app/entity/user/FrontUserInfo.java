package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 用户信息表
 * @author lsq
 *
 */
public class FrontUserInfo implements java.io.Serializable  {

	private String id;//主键
	private Date createTime;//创建时间
	private Date updateTime;//更新时间
	private String createUser; //创建人
	private String updateUser;//修改人
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
	private String emailStatus; //邮件激活状态
	private String uuid; //邮箱验证码
	private String mobileStatus; //邮件激活状态
	private String  isCardSubmit; //证件是否提交
	private String  isCardAudit; //证件是否审核
	private String  recommendUID; //推荐人UID
	private Integer  membeLevel; //会员等级
	private String  merchantsID; //推荐人UID
	private String  withDrawalStatus; //提现状态
	private String  mentionMoneyStatus; //mentionMoneyStatus
	
	public FrontUserInfo() {
		super();
	}
	public FrontUserInfo(String id, Date createTime, Date updateTime, String createUser, String updateUser,
			String userId, String mobile, String email, double totalMoney, String location, String realName,
			String cardType, String cardNumber, String nickName, Integer uid, String googleCheckCode,
			String tradePassword, String emailStatus, String uuid, String mobileStatus,
			String isCardSubmit, String isCardAudit, String recommendUID, Integer membeLevel, String merchantsID,
			String withDrawalStatus, String mentionMoneyStatus) {
		super();
		this.id = id;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.createUser = createUser;
		this.updateUser = updateUser;
		this.userId = userId;
		this.mobile = mobile;
		this.email = email;
		this.totalMoney = totalMoney;
		this.location = location;
		this.realName = realName;
		this.cardType = cardType;
		this.cardNumber = cardNumber;
		this.nickName = nickName;
		this.uid = uid;
		this.googleCheckCode = googleCheckCode;
		this.tradePassword = tradePassword;
		this.emailStatus = emailStatus;
		this.uuid = uuid;
		this.mobileStatus = mobileStatus;
		this.isCardSubmit = isCardSubmit;
		this.isCardAudit = isCardAudit;
		this.recommendUID = recommendUID;
		this.membeLevel = membeLevel;
		this.merchantsID = merchantsID;
		this.withDrawalStatus = withDrawalStatus;
		this.mentionMoneyStatus = mentionMoneyStatus;
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
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public String getIsCardSubmit() {
		return isCardSubmit;
	}
	public void setIsCardSubmit(String isCardSubmit) {
		this.isCardSubmit = isCardSubmit;
	}
	public String getIsCardAudit() {
		return isCardAudit;
	}
	public void setIsCardAudit(String isCardAudit) {
		this.isCardAudit = isCardAudit;
	}
	public String getRecommendUID() {
		return recommendUID;
	}
	public void setRecommendUID(String recommendUID) {
		this.recommendUID = recommendUID;
	}
	public Integer getMembeLevel() {
		return membeLevel;
	}
	public void setMembeLevel(Integer membeLevel) {
		this.membeLevel = membeLevel;
	}
	public String getMerchantsID() {
		return merchantsID;
	}
	public void setMerchantsID(String merchantsID) {
		this.merchantsID = merchantsID;
	}
	public String getWithDrawalStatus() {
		return withDrawalStatus;
	}
	public void setWithDrawalStatus(String withDrawalStatus) {
		this.withDrawalStatus = withDrawalStatus;
	}
	public String getMentionMoneyStatus() {
		return mentionMoneyStatus;
	}
	public void setMentionMoneyStatus(String mentionMoneyStatus) {
		this.mentionMoneyStatus = mentionMoneyStatus;
	}
	
}
