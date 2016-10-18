package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 用户信息表
 * @author swh
 *
 */
public class UserInformation implements java.io.Serializable  {

	private String id;//主键
	private String userId;//用户ID
	private String userLevel;//会员等级
	private String position;//职务
	private String idCard;//身份证
	private String realname;//真实姓名
	private String roleId;//角色ID
	private Long nowCoin;//当前拥有金币
	private Long totalCoin;//总金币
	private String openId;//微信OPENID
	private String shopId;//门店ID
	private String mobile;//手机
	private String email;//邮箱
	private String avatar;//照片
	private String oldShopId;//以前所在门店
	private String sex;//性别（1是男性，2是女性，0是未知）
	private String address;//地址
	private String qq;//QQ
	private Integer experience;//经验值
	private String itsEmployees;//所属员工编号
	private String qrcodeId;//二维码编号
	private String codeAddress;//二维码地址
	private String describes;//描述
	private String cityId;//城市
	private String provinceId;//省份
	private String status;//是否与erp同步（0.没有同步1.有同步(没有此数据)2.有同步（有此数据））
	private String cityGroup;//一卡通城市群组（有数据为区域门店管理员）
	
	private String employeeAccount;//员工账号
	private String subcenterAccount;//分中心管理员帐号
	private Date lastModiTime;//最后修改时间
	
	public String getQrcodeId() {
		return qrcodeId;
	}
	public void setQrcodeId(String qrcodeId) {
		this.qrcodeId = qrcodeId;
	}
	public String getCodeAddress() {
		return codeAddress;
	}
	public void setCodeAddress(String codeAddress) {
		this.codeAddress = codeAddress;
	}
	public String getItsEmployees() {
		return itsEmployees;
	}
	public void setItsEmployees(String itsEmployees) {
		this.itsEmployees = itsEmployees;
	}
	public UserInformation(){
		
	}
	public UserInformation(String id, String userId, String userLevel,
			String position, String idCard, String realname, String roleId,
			Long nowCoin, Long totalCoin, String openId, String shopId,
			String mobile, String email) {
		super();
		this.id = id;
		this.userId = userId;
		this.userLevel = userLevel;
		this.position = position;
		this.idCard = idCard;
		this.realname = realname;
		this.roleId = roleId;
		this.nowCoin = nowCoin;
		this.totalCoin = totalCoin;
		this.openId = openId;
		this.shopId = shopId;
		this.mobile = mobile;
		this.email = email;
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
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public Long getNowCoin() {
		return nowCoin;
	}
	public void setNowCoin(Long nowCoin) {
		this.nowCoin = nowCoin;
	}
	public Long getTotalCoin() {
		return totalCoin;
	}
	public void setTotalCoin(Long totalCoin) {
		this.totalCoin = totalCoin;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
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
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getOldShopId() {
		return oldShopId;
	}
	public void setOldShopId(String oldShopId) {
		this.oldShopId = oldShopId;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public Integer getExperience() {
		return experience;
	}
	public void setExperience(Integer experience) {
		this.experience = experience;
	}
	public String getDescribes() {
		return describes;
	}
	public void setDescribes(String describes) {
		this.describes = describes;
	}
	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	public String getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCityGroup() {
		return cityGroup;
	}
	public void setCityGroup(String cityGroup) {
		this.cityGroup = cityGroup;
	}
	public String getEmployeeAccount() {
		return employeeAccount;
	}
	public void setEmployeeAccount(String employeeAccount) {
		this.employeeAccount = employeeAccount;
	}
	public String getSubcenterAccount() {
		return subcenterAccount;
	}
	public void setSubcenterAccount(String subcenterAccount) {
		this.subcenterAccount = subcenterAccount;
	}
	public Date getLastModiTime() {
		return lastModiTime;
	}
	public void setLastModiTime(Date lastModiTime) {
		this.lastModiTime = lastModiTime;
	}
	
}
