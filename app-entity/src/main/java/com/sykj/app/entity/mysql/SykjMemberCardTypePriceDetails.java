package com.sykj.app.entity.mysql;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 卡模版价格表
 * 
 * @author lx
 */
public class SykjMemberCardTypePriceDetails implements Serializable {

	private String id;
	private String fldCompanyCode;
	private String fldMemberCardTypeCode;
	private BigDecimal fldStandardPrice;
	private Integer fldIsInherited;
	private BigDecimal fldActualPrice;
	private Integer fldAllowModify;

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

	public String getFldMemberCardTypeCode() {
		return fldMemberCardTypeCode;
	}

	public void setFldMemberCardTypeCode(String fldMemberCardTypeCode) {
		this.fldMemberCardTypeCode = fldMemberCardTypeCode;
	}

	public BigDecimal getFldStandardPrice() {
		return fldStandardPrice;
	}

	public void setFldStandardPrice(BigDecimal fldStandardPrice) {
		this.fldStandardPrice = fldStandardPrice;
	}

	public Integer getFldIsInherited() {
		return fldIsInherited;
	}

	public void setFldIsInherited(Integer fldIsInherited) {
		this.fldIsInherited = fldIsInherited;
	}

	public BigDecimal getFldActualPrice() {
		return fldActualPrice;
	}

	public void setFldActualPrice(BigDecimal fldActualPrice) {
		this.fldActualPrice = fldActualPrice;
	}

	public Integer getFldAllowModify() {
		return fldAllowModify;
	}

	public void setFldAllowModify(Integer fldAllowModify) {
		this.fldAllowModify = fldAllowModify;
	}

}
