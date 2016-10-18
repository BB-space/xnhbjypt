package com.sykj.app.entity.mysql;

/**
 * SykjErpSettleuppaybydetail entity. @author MyEclipse Persistence Tools
 */

public class SykjSettleUpPayByDetail implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldDocNo;
	private String fldCode;
	private Long fldAmount;

	// Constructors

	/** default constructor */
	public SykjSettleUpPayByDetail() {
	}

	/** minimal constructor */
	public SykjSettleUpPayByDetail(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjSettleUpPayByDetail(String id, String fldCompanyCode,
			String fldDocNo, String fldCode, Long fldAmount) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldDocNo = fldDocNo;
		this.fldCode = fldCode;
		this.fldAmount = fldAmount;
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

	public String getFldCode() {
		return this.fldCode;
	}

	public void setFldCode(String fldCode) {
		this.fldCode = fldCode;
	}

	public Long getFldAmount() {
		return this.fldAmount;
	}

	public void setFldAmount(Long fldAmount) {
		this.fldAmount = fldAmount;
	}

	@Override
	public String toString() {
		return "SykjSettleUpPayByDetail [id=" + id + ", fldCompanyCode="
				+ fldCompanyCode + ", fldDocNo=" + fldDocNo + ", fldCode="
				+ fldCode + ", fldAmount=" + fldAmount + "]";
	}

}