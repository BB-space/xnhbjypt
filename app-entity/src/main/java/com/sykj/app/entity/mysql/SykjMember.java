package com.sykj.app.entity.mysql;

import java.sql.Timestamp;

/**
 * SykjErpMember entity. @author MyEclipse Persistence Tools
 */

public class SykjMember implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldMemberNo;
	private String fldMobileNo;
	private Timestamp fldCreateTime;
	private Integer fldIsStop;
	private Timestamp fldLastModiTime;
	private String fldCardName1;
	private String fldName1;

	// Constructors

	/** default constructor */
	public SykjMember() {
	}

	/** minimal constructor */
	public SykjMember(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjMember(String id, String fldCompanyCode, String fldMemberNo,
			String fldMobileNo, Timestamp fldCreateTime, Integer fldIsStop,
			Timestamp fldLastModiTime, String fldCardName1, String fldName1) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldMemberNo = fldMemberNo;
		this.fldMobileNo = fldMobileNo;
		this.fldCreateTime = fldCreateTime;
		this.fldIsStop = fldIsStop;
		this.fldLastModiTime = fldLastModiTime;
		this.fldCardName1 = fldCardName1;
		this.fldName1 = fldName1;
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

	public String getFldMemberNo() {
		return this.fldMemberNo;
	}

	public void setFldMemberNo(String fldMemberNo) {
		this.fldMemberNo = fldMemberNo;
	}

	public String getFldMobileNo() {
		return this.fldMobileNo;
	}

	public void setFldMobileNo(String fldMobileNo) {
		this.fldMobileNo = fldMobileNo;
	}

	public Timestamp getFldCreateTime() {
		return this.fldCreateTime;
	}

	public void setFldCreateTime(Timestamp fldCreateTime) {
		this.fldCreateTime = fldCreateTime;
	}

	public Integer getFldIsStop() {
		return this.fldIsStop;
	}

	public void setFldIsStop(Integer fldIsStop) {
		this.fldIsStop = fldIsStop;
	}

	public Timestamp getFldLastModiTime() {
		return this.fldLastModiTime;
	}

	public void setFldLastModiTime(Timestamp fldLastModiTime) {
		this.fldLastModiTime = fldLastModiTime;
	}

	public String getFldCardName1() {
		return this.fldCardName1;
	}

	public void setFldCardName1(String fldCardName1) {
		this.fldCardName1 = fldCardName1;
	}

	public String getFldName1() {
		return this.fldName1;
	}

	public void setFldName1(String fldName1) {
		this.fldName1 = fldName1;
	}

}