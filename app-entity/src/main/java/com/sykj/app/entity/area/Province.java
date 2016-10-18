package com.sykj.app.entity.area;

import java.math.BigDecimal;
import java.util.Date;

public class Province implements java.io.Serializable  {

	private String id;//主键
	private String provinceNumber;//省份架构编码
	private String provinceName;//省份名称
	private BigDecimal seq;//排序
	private Date createDateTime;//创建时间
	private String status;
	
	public Province(){
		
	}

	public Province(String id, String provinceNumber, String provinceName,
			BigDecimal seq, Date createDateTime) {
		super();
		this.id = id;
		this.provinceNumber = provinceNumber;
		this.provinceName = provinceName;
		this.seq = seq;
		this.createDateTime = createDateTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getProvinceNumber() {
		return provinceNumber;
	}

	public void setProvinceNumber(String provinceNumber) {
		this.provinceNumber = provinceNumber;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
