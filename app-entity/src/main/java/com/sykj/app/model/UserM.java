package com.sykj.app.model;

import java.util.Date;
import java.util.HashSet;

public class UserM implements java.io.Serializable {

	private String id;//用户ID
	private String userLevel;//会员等级
	private String position;//职务
	private String idCard;//身份证
	private String realname;//真实姓名
	private String roleId;//角色ID
	private String roleText;//角色名称
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
	private String userName;//用户名
	private String userPassword;//密码
	private Date createDateTime;//创建时间
	private String createTime;//创建时间(前台显示)
	private String userType;//用户类型(0:后台管理用户，1：门店店员，2：会员，3：游客)
	private String registeredStatus;//注册状态（0：成功，1：已被注册）
	private String mobileCode;//前台传递验证码
	private String qrcodeId;//二维码编号
	private String codeAddress;//二维码地址
	private String itsEmployees;//所属员工编号
	private String shopName;//门店名
	private String belongShopType; //所属门店：丝域、丝荟
	private String shortNumber; //门店编码
	
	private HashSet<String> roleMenuIdSet;//角色菜单Id列表
	private String cityId;//城市
	private String provinceId;//省份
	private String provinceName;//
	private String cityName;
	private Date editDateTime;//编辑使用时间
	private String cityGroup;//一卡通城市群组
	private String text;//角色
	
	private String employeeAccount;
	private String subcenterAccount;
	private Date lastModiTime;
	private String subcenter;
	
	private String businessId;//职务id
	private String businessText;//职务名称
	
	public String getItsEmployees() {
		return itsEmployees;
	}
	public void setItsEmployees(String itsEmployees) {
		this.itsEmployees = itsEmployees;
	}
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
	public UserM(){
		
	}
	

	public UserM(String id, String userLevel, String position, String idCard,
			String realname, String roleId, String roleText, Long nowCoin,
			Long totalCoin, String openId, String shopId, String mobile,
			String email, String avatar, String oldShopId, String sex,
			String address, String qq, Integer experience, String userName,
			String userPassword, Date createDateTime, String createTime,
			String userType, String registeredStatus, String mobileCode) {
		super();
		this.id = id;
		this.userLevel = userLevel;
		this.position = position;
		this.idCard = idCard;
		this.realname = realname;
		this.roleId = roleId;
		this.roleText = roleText;
		this.nowCoin = nowCoin;
		this.totalCoin = totalCoin;
		this.openId = openId;
		this.shopId = shopId;
		this.mobile = mobile;
		this.email = email;
		this.avatar = avatar;
		this.oldShopId = oldShopId;
		this.sex = sex;
		this.address = address;
		this.qq = qq;
		this.experience = experience;
		this.userName = userName;
		this.userPassword = userPassword;
		this.createDateTime = createDateTime;
		this.createTime = createTime;
		this.userType = userType;
		this.registeredStatus = registeredStatus;
		this.mobileCode = mobileCode;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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



	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getRoleText() {
		return roleText;
	}

	public void setRoleText(String roleText) {
		this.roleText = roleText;
	}

	public String getRegisteredStatus() {
		return registeredStatus;
	}

	public void setRegisteredStatus(String registeredStatus) {
		this.registeredStatus = registeredStatus;
	}

	public String getMobileCode() {
		return mobileCode;
	}

	public void setMobileCode(String mobileCode) {
		this.mobileCode = mobileCode;
	}
	public HashSet<String> getRoleMenuIdSet() {
		return roleMenuIdSet;
	}
	public void setRoleMenuIdSet(HashSet<String> roleMenuIdSet) {
		this.roleMenuIdSet = roleMenuIdSet;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getBelongShopType() {
		return belongShopType;
	}
	public void setBelongShopType(String belongShopType) {
		this.belongShopType = belongShopType;
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
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getShortNumber() {
		return shortNumber;
	}
	public void setShortNumber(String shortNumber) {
		this.shortNumber = shortNumber;
	}
	public Date getEditDateTime() {
		return editDateTime;
	}
	public void setEditDateTime(Date editDateTime) {
		this.editDateTime = editDateTime;
	}
	public String getCityGroup() {
		return cityGroup;
	}
	public void setCityGroup(String cityGroup) {
		this.cityGroup = cityGroup;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
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
	public String getSubcenter() {
		return subcenter;
	}
	public void setSubcenter(String subcenter) {
		this.subcenter = subcenter;
	}
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getBusinessText() {
		return businessText;
	}
	public void setBusinessText(String businessText) {
		this.businessText = businessText;
	}
	
}
