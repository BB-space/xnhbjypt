package com.sykj.app.entity.mysql;

/**
 * SykjErpSettleupitemdetails entity. @author MyEclipse Persistence Tools
 */

public class SykjSettleUpItemDetails implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldDocNo;
	private String fldItemCode;
	private Long fldUnitPrice;
	private Long fldLineDiscount;
	private Long fldQty;
	private Long fldAmount;
	private String nurse;
	private String hairStylist;
	private String note;
	
	
	// Constructors

	/** default constructor */
	public SykjSettleUpItemDetails() {
	}

	/** minimal constructor */
	public SykjSettleUpItemDetails(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjSettleUpItemDetails(String id, String fldCompanyCode,
			String fldDocNo, String fldItemCode, Long fldUnitPrice,
			Long fldLineDiscount, Long fldQty, Long fldAmount) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldDocNo = fldDocNo;
		this.fldItemCode = fldItemCode;
		this.fldUnitPrice = fldUnitPrice;
		this.fldLineDiscount = fldLineDiscount;
		this.fldQty = fldQty;
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

	public String getFldItemCode() {
		return this.fldItemCode;
	}

	public void setFldItemCode(String fldItemCode) {
		this.fldItemCode = fldItemCode;
	}

	public Long getFldUnitPrice() {
		return this.fldUnitPrice;
	}

	public void setFldUnitPrice(Long fldUnitPrice) {
		this.fldUnitPrice = fldUnitPrice;
	}

	public Long getFldLineDiscount() {
		return this.fldLineDiscount;
	}

	public void setFldLineDiscount(Long fldLineDiscount) {
		this.fldLineDiscount = fldLineDiscount;
	}

	public Long getFldQty() {
		return this.fldQty;
	}

	public void setFldQty(Long fldQty) {
		this.fldQty = fldQty;
	}

	public Long getFldAmount() {
		return this.fldAmount;
	}

	public void setFldAmount(Long fldAmount) {
		this.fldAmount = fldAmount;
	}

	public String getNurse() {
		return nurse;
	}

	public void setNurse(String nurse) {
		this.nurse = nurse;
	}

	public String getHairStylist() {
		return hairStylist;
	}

	public void setHairStylist(String hairStylist) {
		this.hairStylist = hairStylist;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}