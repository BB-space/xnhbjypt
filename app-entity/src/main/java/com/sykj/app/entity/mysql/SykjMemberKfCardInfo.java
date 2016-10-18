package com.sykj.app.entity.mysql;

import java.sql.Timestamp;

/**
 * 2015.11.12之前线下购买一卡通信息 SykjErpMembercard entity. @author MyEclipse Persistence
 * Tools
 */

public class SykjMemberKfCardInfo implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;// 公司编号
	private String fldCompanyName1;// 公司名称
	private String fldMemberNo;// 会员编号
	private String fldName1;// 会员姓名
	private String fldMemberCardCode;// 会员卡编号
	private String fldMobileNo;// 手机
	private String fldDescription1;// 卡类型
	private Timestamp fldCreateTime;// 创建时间
	private String fldFromERP;//类别
	
	public SykjMemberKfCardInfo() {
	}

	public SykjMemberKfCardInfo(String id, String fldCompanyCode,
			String fldCompanyName1, String fldMemberNo, String fldName1,
			String fldMemberCardCode, String fldMobileNo,
			String fldDescription1, Timestamp fldCreateTime) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldCompanyName1 = fldCompanyName1;
		this.fldMemberNo = fldMemberNo;
		this.fldName1 = fldName1;
		this.fldMemberCardCode = fldMemberCardCode;
		this.fldMobileNo = fldMobileNo;
		this.fldDescription1 = fldDescription1;
		this.fldCreateTime = fldCreateTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFldCompanyCode() {
		return fldCompanyCode;
	}

	public void setFldCompanyCode(String fldCompanyCode) {
		this.fldCompanyCode = fldCompanyCode;
	}

	public String getFldCompanyName1() {
		return fldCompanyName1;
	}

	public void setFldCompanyName1(String fldCompanyName1) {
		this.fldCompanyName1 = fldCompanyName1;
	}

	public String getFldMemberNo() {
		return fldMemberNo;
	}

	public void setFldMemberNo(String fldMemberNo) {
		this.fldMemberNo = fldMemberNo;
	}

	public String getFldName1() {
		return fldName1;
	}

	public void setFldName1(String fldName1) {
		this.fldName1 = fldName1;
	}

	public String getFldMemberCardCode() {
		return fldMemberCardCode;
	}

	public void setFldMemberCardCode(String fldMemberCardCode) {
		this.fldMemberCardCode = fldMemberCardCode;
	}

	public String getFldMobileNo() {
		return fldMobileNo;
	}

	public void setFldMobileNo(String fldMobileNo) {
		this.fldMobileNo = fldMobileNo;
	}

	public String getFldDescription1() {
		return fldDescription1;
	}

	public void setFldDescription1(String fldDescription1) {
		this.fldDescription1 = fldDescription1;
	}

	public Timestamp getFldCreateTime() {
		return fldCreateTime;
	}

	public void setFldCreateTime(Timestamp fldCreateTime) {
		this.fldCreateTime = fldCreateTime;
	}

	@Override
	public String toString() {
		return "SykjMemberKfCardInfo [id=" + id + ", fldCompanyCode="
				+ fldCompanyCode + ", fldCompanyName1=" + fldCompanyName1
				+ ", fldMemberNo=" + fldMemberNo + ", fldName1=" + fldName1
				+ ", fldMemberCardCode=" + fldMemberCardCode + ", fldMobileNo="
				+ fldMobileNo + ", fldDescription1=" + fldDescription1
				+ ", fldCreateTime=" + fldCreateTime + "]";
	}

	public String getFldFromERP() {
		return fldFromERP;
	}

	public void setFldFromERP(String fldFromERP) {
		this.fldFromERP = fldFromERP;
	}

}