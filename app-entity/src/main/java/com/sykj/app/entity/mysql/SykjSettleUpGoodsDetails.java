package com.sykj.app.entity.mysql;

/**
 * SykjErpSettleupgoodsdetails entity. @author MyEclipse Persistence Tools
 */

public class SykjSettleUpGoodsDetails implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldDocNo;
	private String fldGoodsCode;
	private Long fldUnitPrice;
	private Long fldLineDiscount;
	private Long fldQty;
	private Long fldAmount;

	// Constructors

	/** default constructor */
	public SykjSettleUpGoodsDetails() {
	}

	/** minimal constructor */
	public SykjSettleUpGoodsDetails(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjSettleUpGoodsDetails(String id, String fldCompanyCode,
			String fldDocNo, String fldGoodsCode, Long fldUnitPrice,
			Long fldLineDiscount, Long fldQty, Long fldAmount) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldDocNo = fldDocNo;
		this.fldGoodsCode = fldGoodsCode;
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

	public String getFldGoodsCode() {
		return this.fldGoodsCode;
	}

	public void setFldGoodsCode(String fldGoodsCode) {
		this.fldGoodsCode = fldGoodsCode;
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

}