package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 会员申请成为员工
 * @author swh
 *
 */
public class MemberToEmployees implements java.io.Serializable{

	private String id;
	private String memberName;//申请人姓名
	private String shopId;//申请门店
	private Date createDateTime;//申请时间
	private String mobile;//申请账号
	private String status;//处理状态(0:未处理，1:已通过，2：已拒绝)
	private String cityId;//申请城市
	private String provinceId;//申请省份
	
	public MemberToEmployees(){
		
	}
	
	public MemberToEmployees(String id, String memberName,
			String shopId, Date createDateTime, String mobile) {
		super();
		this.id = id;
		this.memberName = memberName;
		this.shopId = shopId;
		this.createDateTime = createDateTime;
		this.mobile = mobile;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getShopId() {
		return shopId;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
	
	
}
