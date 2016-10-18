package com.sykj.app.entity.area;

import java.math.BigDecimal;
import java.util.Date;

public class Subcenter implements java.io.Serializable  {

	private String id;//主键
	private String subcenterNumber;//分中心架构编码
	private String subcenterName;//分中心名
	private BigDecimal seq;//排序
	private Date createDateTime;//创建时间
	
	public Subcenter(){
		
	}
	
	public Subcenter(String id, String subcenterNumber, String subcenterName,
			BigDecimal seq, Date createDateTime) {
		super();
		this.id = id;
		this.subcenterNumber = subcenterNumber;
		this.subcenterName = subcenterName;
		this.seq = seq;
		this.createDateTime = createDateTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSubcenterNumber() {
		return subcenterNumber;
	}

	public void setSubcenterNumber(String subcenterNumber) {
		this.subcenterNumber = subcenterNumber;
	}

	public String getSubcenterName() {
		return subcenterName;
	}

	public void setSubcenterName(String subcenterName) {
		this.subcenterName = subcenterName;
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
	
	
}
