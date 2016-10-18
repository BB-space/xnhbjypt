package com.sykj.app.entity.mysql;

/**
 * SykjErpItempricedetails entity. @author MyEclipse Persistence Tools
 */

public class SykjItemPriceDetails implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldItemCode;
	private Integer fldCategory;
	private Long fldStandardPrice;
	private Long fldExperiencePrice;

	// Constructors

	/** default constructor */
	public SykjItemPriceDetails() {
	}

	/** minimal constructor */
	public SykjItemPriceDetails(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjItemPriceDetails(String id, String fldCompanyCode,
			String fldItemCode, Integer fldCategory, Long fldStandardPrice,
			Long fldExperiencePrice) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldItemCode = fldItemCode;
		this.fldCategory = fldCategory;
		this.fldStandardPrice = fldStandardPrice;
		this.fldExperiencePrice = fldExperiencePrice;
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

	public String getFldItemCode() {
		return this.fldItemCode;
	}

	public void setFldItemCode(String fldItemCode) {
		this.fldItemCode = fldItemCode;
	}

	public Integer getFldCategory() {
		return this.fldCategory;
	}

	public void setFldCategory(Integer fldCategory) {
		this.fldCategory = fldCategory;
	}

	public Long getFldStandardPrice() {
		return this.fldStandardPrice;
	}

	public void setFldStandardPrice(Long fldStandardPrice) {
		this.fldStandardPrice = fldStandardPrice;
	}

	public Long getFldExperiencePrice() {
		return this.fldExperiencePrice;
	}

	public void setFldExperiencePrice(Long fldExperiencePrice) {
		this.fldExperiencePrice = fldExperiencePrice;
	}

}