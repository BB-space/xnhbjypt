package com.sykj.app.entity.area;

import java.math.BigDecimal;
import java.util.Date;

public class City implements java.io.Serializable  {

	private String id;//主键
	private String cityName;//城市名
	private String cityNumber;//城市架构编码
	private String provinceId;//省份ID
	private BigDecimal seq;//排序
	private Date createDateTime;//创建时间
	private String status;
	private String cityGroup;//一卡通城市群组
	private String area;//到店城市区域
	
	public City(){
		
	}
	
	public City(String id, String cityName, String cityNumber,
			String provinceId, BigDecimal seq, Date createDateTime) {
		super();
		this.id = id;
		this.cityName = cityName;
		this.cityNumber = cityNumber;
		this.provinceId = provinceId;
		this.seq = seq;
		this.createDateTime = createDateTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getCityNumber() {
		return cityNumber;
	}

	public void setCityNumber(String cityNumber) {
		this.cityNumber = cityNumber;
	}

	public String getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	public BigDecimal getSeq() {
		return seq;
	}

	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
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

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

}
