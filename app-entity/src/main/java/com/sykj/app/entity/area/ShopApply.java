package com.sykj.app.entity.area;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 门店
 * @author swh
 *
 */
@SuppressWarnings("serial")
public class ShopApply implements java.io.Serializable  {

	private String id;//主键
	private String shopNumber;//门店架构编码
	private String shortNumber;//门店短编码
	private String shopName;//门店名称
	private String shortName;//门店简写
	private String cityId;//门店所属城市
	private String subcenterId;//门店所属分中心
	private Date createDateTime;//创建时间
	private String payUserId;//支付账号
	private String descript;//描述
	private BigDecimal seq;//排序
	private String address;//地址
	private String location;//位置
	private String mobile;//手机
	private String phone;//电话
	private String status;//状态
	private Integer bed;//床位数量
	private String photo;//头像
	private Integer minimumEarlyWorking;//最少上早班人数
	private Integer minimumNightWorking;//最少上晚班人数
	private Integer forDay;//早晚班循环天数
	private Double holiday;//每月员工休假天数
	private Integer code;	//二维码
	private String pictures;//存储图片
	private String provinceId;//省份编号

	private String shopType;//门店类型（直营/加盟/托管）

	private String codeAddress;//二维码地址
	private String shopOpenStatus;//该门店是否有开通预约功能
	private String cityName;//所属城市
	private String provinceName;
	
	private String belong; //门店所属：丝域、丝荟
	private String isReserve;//是否可预约（0：不可，1：可）
	
	private String meiTuanId;//美团商户ID

	public String getIsReserve() {
		return isReserve;
	}

	public void setIsReserve(String isReserve) {
		this.isReserve = isReserve;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getShopOpenStatus() {
		return shopOpenStatus;
	}

	public void setShopOpenStatus(String shopOpenStatus) {
		this.shopOpenStatus = shopOpenStatus;
	}

	public Double getHoliday() {
		return holiday;
	}

	public void setHoliday(Double holiday) {
		this.holiday = holiday;
	}

	public String getCodeAddress() {
		return codeAddress;
	}

	public void setCodeAddress(String codeAddress) {
		this.codeAddress = codeAddress;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public ShopApply(){
		
	}
	
	public ShopApply(String id, String shopNumber, String shopName, String cityId,
			Date createDateTime, String payUserId, String descript,
			BigDecimal seq, String address, String mobile, String phone,
			String status) {
		super();
		this.id = id;
		this.shopNumber = shopNumber;
		this.shopName = shopName;
		this.cityId = cityId;
		this.createDateTime = createDateTime;
		this.payUserId = payUserId;
		this.descript = descript;
		this.seq = seq;
		this.address = address;
		this.mobile = mobile;
		this.phone = phone;
		this.status = status;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getShopNumber() {
		return shopNumber;
	}

	public void setShopNumber(String shopNumber) {
		this.shopNumber = shopNumber;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getPayUserId() {
		return payUserId;
	}

	public void setPayUserId(String payUserId) {
		this.payUserId = payUserId;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public BigDecimal getSeq() {
		return seq;
	}

	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSubcenterId() {
		return subcenterId;
	}

	public void setSubcenterId(String subcenterId) {
		this.subcenterId = subcenterId;
	}

	public Integer getMinimumEarlyWorking() {
		return minimumEarlyWorking;
	}

	public void setMinimumEarlyWorking(Integer minimumEarlyWorking) {
		this.minimumEarlyWorking = minimumEarlyWorking;
	}

	public Integer getMinimumNightWorking() {
		return minimumNightWorking;
	}

	public void setMinimumNightWorking(Integer minimumNightWorking) {
		this.minimumNightWorking = minimumNightWorking;
	}

	public Integer getForDay() {
		return forDay;
	}

	public void setForDay(Integer forDay) {
		this.forDay = forDay;
	}

	

	public Integer getBed() {
		return bed;
	}

	public void setBed(Integer bed) {
		this.bed = bed;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getShopType() {
		return shopType;
	}

	public void setShopType(String shopType) {
		this.shopType = shopType;
	}

	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getShortNumber() {
		return shortNumber;
	}

	public void setShortNumber(String shortNumber) {
		this.shortNumber = shortNumber;
	}

	public String getBelong() {
		return belong;
	}

	public void setBelong(String belong) {
		this.belong = belong;
	}

	public String getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	public String getMeiTuanId() {
		return meiTuanId;
	}

	public void setMeiTuanId(String meiTuanId) {
		this.meiTuanId = meiTuanId;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

}
