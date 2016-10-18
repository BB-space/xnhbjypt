package com.sykj.app.entity.mysql;

import java.sql.Timestamp;

/**
 * SykjErpSettleup entity. @author MyEclipse Persistence Tools
 */

public class SykjSettleUp implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldDocNo;
	private Timestamp fldDocDate;
	private String fldMemberNo;
	private String fldMemberCardCode;
	private Integer fldStatus;

	// Constructors

	/** default constructor */
	public SykjSettleUp() {
	}

	/** minimal constructor */
	public SykjSettleUp(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjSettleUp(String id, String fldCompanyCode, String fldDocNo,
			Timestamp fldDocDate, String fldMemberNo, String fldMemberCardCode) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldDocNo = fldDocNo;
		this.fldDocDate = fldDocDate;
		this.fldMemberNo = fldMemberNo;
		this.fldMemberCardCode = fldMemberCardCode;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFldCompanyCode() {
		return this.fldCompanyCode;
	}

	public void setFldCompanyCode(String fldCompanyCode) {
		this.fldCompanyCode = fldCompanyCode;
	}

	public String getFldDocNo() {
		return this.fldDocNo;
	}

	public void setFldDocNo(String fldDocNo) {
		this.fldDocNo = fldDocNo;
	}

	public Timestamp getFldDocDate() {
		return this.fldDocDate;
	}

	public void setFldDocDate(Timestamp fldDocDate) {
		this.fldDocDate = fldDocDate;
	}

	public String getFldMemberNo() {
		return this.fldMemberNo;
	}

	public void setFldMemberNo(String fldMemberNo) {
		this.fldMemberNo = fldMemberNo;
	}

	public String getFldMemberCardCode() {
		return this.fldMemberCardCode;
	}

	public void setFldMemberCardCode(String fldMemberCardCode) {
		this.fldMemberCardCode = fldMemberCardCode;
	}

	public Integer getFldStatus() {
		return fldStatus;
	}

	public void setFldStatus(Integer fldStatus) {
		this.fldStatus = fldStatus;
	}

	@Override
	public String toString() {
		return "SykjSettleUp [id=" + id + ", fldCompanyCode=" + fldCompanyCode
				+ ", fldDocNo=" + fldDocNo + ", fldDocDate=" + fldDocDate
				+ ", fldMemberNo=" + fldMemberNo + ", fldMemberCardCode="
				+ fldMemberCardCode + ", fldStatus=" + fldStatus + "]";
	}

}