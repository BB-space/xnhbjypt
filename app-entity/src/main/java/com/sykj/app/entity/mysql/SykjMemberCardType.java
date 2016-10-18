package com.sykj.app.entity.mysql;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 卡模版
 * 
 * @author lx
 */
public class SykjMemberCardType implements Serializable {

	private String id;
	private String fldMemberCardTypeCode;// 卡模版编号
	private String fldDescription1;// 卡模版名称
	private BigDecimal fldAmounts;// 金额
	private BigDecimal fldPresentAmount;// 原价赠送金额
	private BigDecimal extraAmoun;// 赠送金额
	private String fldMnemonicCode;// 助记码
	private BigDecimal fldLowestRechargeLimit;// 最低充值金额
	private BigDecimal fldFloorAmount;// 保底金额
	private BigDecimal fldSafeAmount;// 安全余额
	private BigDecimal fldMaxArrearageAmount;// 最大金额
	private Integer fldVirtualCategoryCode;// 卡种类
	private String fldUseOutstandingAs;// 储值限制
	private String fldUsePresentOutstandingAs;// 原价赠送储值限制
	private String fldPresentGoodsTypeAllow;// 赠送金额产品限制
	private String fldPresentItemTypeAllow;// 赠送金额项目限制
	private Integer fldStopSale;// 销售状态
	private BigDecimal fldExtraAmount;//赠送金额
	private String fldCreator;// 创建人
	private Timestamp fldCreateTime;// 创建时间
	private Integer fldNoOfModi;// 修改次数
	private String fldLastModifier;// 最后修改人
	private Timestamp fldLastModiTime;// 最后修改时间

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFldMemberCardTypeCode() {
		return fldMemberCardTypeCode;
	}

	public void setFldMemberCardTypeCode(String fldMemberCardTypeCode) {
		this.fldMemberCardTypeCode = fldMemberCardTypeCode;
	}

	public String getFldDescription1() {
		return fldDescription1;
	}

	public void setFldDescription1(String fldDescription1) {
		this.fldDescription1 = fldDescription1;
	}

	public BigDecimal getFldAmounts() {
		return fldAmounts;
	}

	public void setFldAmounts(BigDecimal fldAmounts) {
		this.fldAmounts = fldAmounts;
	}

	public BigDecimal getFldPresentAmount() {
		return fldPresentAmount;
	}

	public void setFldPresentAmount(BigDecimal fldPresentAmount) {
		this.fldPresentAmount = fldPresentAmount;
	}

	public BigDecimal getExtraAmoun() {
		return extraAmoun;
	}

	public void setExtraAmoun(BigDecimal extraAmoun) {
		this.extraAmoun = extraAmoun;
	}

	public String getFldMnemonicCode() {
		return fldMnemonicCode;
	}

	public void setFldMnemonicCode(String fldMnemonicCode) {
		this.fldMnemonicCode = fldMnemonicCode;
	}

	public BigDecimal getFldLowestRechargeLimit() {
		return fldLowestRechargeLimit;
	}

	public void setFldLowestRechargeLimit(BigDecimal fldLowestRechargeLimit) {
		this.fldLowestRechargeLimit = fldLowestRechargeLimit;
	}

	public BigDecimal getFldFloorAmount() {
		return fldFloorAmount;
	}

	public void setFldFloorAmount(BigDecimal fldFloorAmount) {
		this.fldFloorAmount = fldFloorAmount;
	}

	public BigDecimal getFldSafeAmount() {
		return fldSafeAmount;
	}

	public void setFldSafeAmount(BigDecimal fldSafeAmount) {
		this.fldSafeAmount = fldSafeAmount;
	}

	public BigDecimal getFldMaxArrearageAmount() {
		return fldMaxArrearageAmount;
	}

	public void setFldMaxArrearageAmount(BigDecimal fldMaxArrearageAmount) {
		this.fldMaxArrearageAmount = fldMaxArrearageAmount;
	}

	public String getFldCreator() {
		return fldCreator;
	}

	public void setFldCreator(String fldCreator) {
		this.fldCreator = fldCreator;
	}

	public Timestamp getFldCreateTime() {
		return fldCreateTime;
	}

	public void setFldCreateTime(Timestamp fldCreateTime) {
		this.fldCreateTime = fldCreateTime;
	}

	public String getFldLastModifier() {
		return fldLastModifier;
	}

	public void setFldLastModifier(String fldLastModifier) {
		this.fldLastModifier = fldLastModifier;
	}

	public String getFldUseOutstandingAs() {
		return fldUseOutstandingAs;
	}

	public void setFldUseOutstandingAs(String fldUseOutstandingAs) {
		this.fldUseOutstandingAs = fldUseOutstandingAs;
	}

	public String getFldUsePresentOutstandingAs() {
		return fldUsePresentOutstandingAs;
	}

	public void setFldUsePresentOutstandingAs(String fldUsePresentOutstandingAs) {
		this.fldUsePresentOutstandingAs = fldUsePresentOutstandingAs;
	}

	public String getFldPresentGoodsTypeAllow() {
		return fldPresentGoodsTypeAllow;
	}

	public void setFldPresentGoodsTypeAllow(String fldPresentGoodsTypeAllow) {
		this.fldPresentGoodsTypeAllow = fldPresentGoodsTypeAllow;
	}

	public String getFldPresentItemTypeAllow() {
		return fldPresentItemTypeAllow;
	}

	public void setFldPresentItemTypeAllow(String fldPresentItemTypeAllow) {
		this.fldPresentItemTypeAllow = fldPresentItemTypeAllow;
	}

	public Integer getFldStopSale() {
		return fldStopSale;
	}

	public void setFldStopSale(Integer fldStopSale) {
		this.fldStopSale = fldStopSale;
	}

	public Integer getFldNoOfModi() {
		return fldNoOfModi;
	}

	public void setFldNoOfModi(Integer fldNoOfModi) {
		this.fldNoOfModi = fldNoOfModi;
	}

	public Timestamp getFldLastModiTime() {
		return fldLastModiTime;
	}

	public void setFldLastModiTime(Timestamp fldLastModiTime) {
		this.fldLastModiTime = fldLastModiTime;
	}

	public Integer getFldVirtualCategoryCode() {
		return fldVirtualCategoryCode;
	}

	public void setFldVirtualCategoryCode(Integer fldVirtualCategoryCode) {
		this.fldVirtualCategoryCode = fldVirtualCategoryCode;
	}

	public BigDecimal getFldExtraAmount() {
		return fldExtraAmount;
	}

	public void setFldExtraAmount(BigDecimal fldExtraAmount) {
		this.fldExtraAmount = fldExtraAmount;
	}

}
