package com.sykj.app.entity.mysql;

import java.io.Serializable;
import java.sql.Timestamp;

public class SykjMemberKfCard implements Serializable{

	private String id;
	private String fldMobileNo;
	private String cnt;
	private String fldMemberCardTypeCode;
	private String fldType;
	private Timestamp fldSaleDate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFldMobileNo() {
		return fldMobileNo;
	}

	public void setFldMobileNo(String fldMobileNo) {
		this.fldMobileNo = fldMobileNo;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getFldMemberCardTypeCode() {
		return fldMemberCardTypeCode;
	}

	public void setFldMemberCardTypeCode(String fldMemberCardTypeCode) {
		this.fldMemberCardTypeCode = fldMemberCardTypeCode;
	}

	public Timestamp getFldSaleDate() {
		return fldSaleDate;
	}

	public void setFldSaleDate(Timestamp fldSaleDate) {
		this.fldSaleDate = fldSaleDate;
	}

	public String getFldType() {
		return fldType;
	}

	public void setFldType(String fldType) {
		this.fldType = fldType;
	}

}
