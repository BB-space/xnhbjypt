package com.sykj.app.entity.user;

import java.util.Date;
import java.util.List;

public class WxUser implements java.io.Serializable{

	private String id;
	private String openId;//微信账号
	private Integer subscribe;// 关注状态（1是关注，0是未关注），未关注时获取不到其余信息
	// 用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间
	private String subscribeTime;
	// 昵称
	private String nickname;
	// 用户的性别（1是男性，2是女性，0是未知）
	private Integer sex;
	// 用户所在国家
	private String country;
	// 用户所在省份
	private String province;
	// 用户所在城市
	private String city;
	// 用户的语言，简体中文为zh_CN
	private String language;
	// 用户头像
	private String headImgUrl;
	// 用户特权信息
	private List<String> privilegeList;
	//创建时间
	private Date createDateTime;
	//修改时间
	private Date updateDateTime;
	//绑定到微信开放平台帐号后唯一标识
	private String unionid;
	
	//支付公共平台对应openId
	private String payOpenId;
	//对应appID
	private String appId;
	
	
	public WxUser(){
		
	}
	
	public WxUser(String id, String openId, Integer subscribe,
			String subscribeTime, String nickname, Integer sex, String country,
			String province, String city, String language, String headImgUrl,
			List<String> privilegeList, Date createDateTime,
			Date updateDateTime, String unionid, String payOpenId, String appId) {
		super();
		this.id = id;
		this.openId = openId;
		this.subscribe = subscribe;
		this.subscribeTime = subscribeTime;
		this.nickname = nickname;
		this.sex = sex;
		this.country = country;
		this.province = province;
		this.city = city;
		this.language = language;
		this.headImgUrl = headImgUrl;
		this.privilegeList = privilegeList;
		this.createDateTime = createDateTime;
		this.updateDateTime = updateDateTime;
		this.unionid = unionid;
		this.payOpenId = payOpenId;
		this.appId = appId;
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
	public String getSubscribeTime() {
		return subscribeTime;
	}
	public void setSubscribeTime(String subscribeTime) {
		this.subscribeTime = subscribeTime;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getHeadImgUrl() {
		return headImgUrl;
	}
	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}
	public List<String> getPrivilegeList() {
		return privilegeList;
	}
	public void setPrivilegeList(List<String> privilegeList) {
		this.privilegeList = privilegeList;
	}
	public Integer getSubscribe() {
		return subscribe;
	}
	public void setSubscribe(Integer subscribe) {
		this.subscribe = subscribe;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public String getPayOpenId() {
		return payOpenId;
	}
	public void setPayOpenId(String payOpenId) {
		this.payOpenId = payOpenId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getUnionid() {
		return unionid;
	}
	public void setUnionid(String unionid) {
		this.unionid = unionid;
	}

	public Date getUpdateDateTime() {
		return updateDateTime;
	}

	public void setUpdateDateTime(Date updateDateTime) {
		this.updateDateTime = updateDateTime;
	}
	
	
}
