package com.sykj.app.entity.mysql;

import java.sql.Timestamp;

/**
 * SykjErpMembercard entity. @author MyEclipse Persistence Tools
 */

public class SykjMemberCard implements java.io.Serializable {

	// Fields

	private String id;
	private String fldCompanyCode;
	private String fldMemberCardCode;
	private String fldMemberNo;
	private Timestamp fldCreateTime;
	private String fldDocNo;
	private Integer fldVirtualCategoryCode;
	private Long fldStandardPrice;
	private Long fldActualPrice;
	private Long fldAmount;
	private Long fldOutstanding;
	private Long fldExtraAmount;
	private Long fldExtraRemainAmount;
	private String fldUseOutstandingAs;
	private String fldUsePresentOutstandingAs;
	private Long fldMaxTimes;
	private Long fldUsedTimes;
	private Long fldOutstandingTimes;
	private Timestamp fldLastModiTime;

	// Constructors

	/** default constructor */
	public SykjMemberCard() {
	}

	/** minimal constructor */
	public SykjMemberCard(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjMemberCard(String id, String fldCompanyCode,
			String fldMemberCardCode, String fldMemberNo,
			Timestamp fldCreateTime, String fldDocNo,
			Integer fldVirtualCategoryCode, Long fldStandardPrice,
			Long fldActualPrice, Long fldAmount, Long fldOutstanding,
			Long fldExtraAmount, Long fldExtraRemainAmount,
			String fldUseOutstandingAs, String fldUsePresentOutstandingAs,
			Long fldMaxTimes, Long fldUsedTimes, Long fldOutstandingTimes,
			Timestamp fldLastModiTime) {
		this.id = id;
		this.fldCompanyCode = fldCompanyCode;
		this.fldMemberCardCode = fldMemberCardCode;
		this.fldMemberNo = fldMemberNo;
		this.fldCreateTime = fldCreateTime;
		this.fldDocNo = fldDocNo;
		this.fldVirtualCategoryCode = fldVirtualCategoryCode;
		this.fldStandardPrice = fldStandardPrice;
		this.fldActualPrice = fldActualPrice;
		this.fldAmount = fldAmount;
		this.fldOutstanding = fldOutstanding;
		this.fldExtraAmount = fldExtraAmount;
		this.fldExtraRemainAmount = fldExtraRemainAmount;
		this.fldUseOutstandingAs = fldUseOutstandingAs;
		this.fldUsePresentOutstandingAs = fldUsePresentOutstandingAs;
		this.fldMaxTimes = fldMaxTimes;
		this.fldUsedTimes = fldUsedTimes;
		this.fldOutstandingTimes = fldOutstandingTimes;
		this.fldLastModiTime = fldLastModiTime;
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

	public String getFldMemberCardCode() {
		return this.fldMemberCardCode;
	}

	public void setFldMemberCardCode(String fldMemberCardCode) {
		this.fldMemberCardCode = fldMemberCardCode;
	}

	public String getFldMemberNo() {
		return this.fldMemberNo;
	}

	public void setFldMemberNo(String fldMemberNo) {
		this.fldMemberNo = fldMemberNo;
	}

	public Timestamp getFldCreateTime() {
		return this.fldCreateTime;
	}

	public void setFldCreateTime(Timestamp fldCreateTime) {
		this.fldCreateTime = fldCreateTime;
	}

	public String getFldDocNo() {
		return this.fldDocNo;
	}

	public void setFldDocNo(String fldDocNo) {
		this.fldDocNo = fldDocNo;
	}

	public Integer getFldVirtualCategoryCode() {
		return this.fldVirtualCategoryCode;
	}

	public void setFldVirtualCategoryCode(Integer fldVirtualCategoryCode) {
		this.fldVirtualCategoryCode = fldVirtualCategoryCode;
	}

	public Long getFldStandardPrice() {
		return this.fldStandardPrice;
	}

	public void setFldStandardPrice(Long fldStandardPrice) {
		this.fldStandardPrice = fldStandardPrice;
	}

	public Long getFldActualPrice() {
		return this.fldActualPrice;
	}

	public void setFldActualPrice(Long fldActualPrice) {
		this.fldActualPrice = fldActualPrice;
	}

	public Long getFldAmount() {
		return this.fldAmount;
	}

	public void setFldAmount(Long fldAmount) {
		this.fldAmount = fldAmount;
	}

	public Long getFldOutstanding() {
		return this.fldOutstanding;
	}

	public void setFldOutstanding(Long fldOutstanding) {
		this.fldOutstanding = fldOutstanding;
	}

	public Long getFldExtraAmount() {
		return this.fldExtraAmount;
	}

	public void setFldExtraAmount(Long fldExtraAmount) {
		this.fldExtraAmount = fldExtraAmount;
	}

	public Long getFldExtraRemainAmount() {
		return this.fldExtraRemainAmount;
	}

	public void setFldExtraRemainAmount(Long fldExtraRemainAmount) {
		this.fldExtraRemainAmount = fldExtraRemainAmount;
	}

	public String getFldUseOutstandingAs() {
		return this.fldUseOutstandingAs;
	}

	public void setFldUseOutstandingAs(String fldUseOutstandingAs) {
		this.fldUseOutstandingAs = fldUseOutstandingAs;
	}

	public String getFldUsePresentOutstandingAs() {
		return this.fldUsePresentOutstandingAs;
	}

	public void setFldUsePresentOutstandingAs(String fldUsePresentOutstandingAs) {
		this.fldUsePresentOutstandingAs = fldUsePresentOutstandingAs;
	}

	public Long getFldMaxTimes() {
		return this.fldMaxTimes;
	}

	public void setFldMaxTimes(Long fldMaxTimes) {
		this.fldMaxTimes = fldMaxTimes;
	}

	public Long getFldUsedTimes() {
		return this.fldUsedTimes;
	}

	public void setFldUsedTimes(Long fldUsedTimes) {
		this.fldUsedTimes = fldUsedTimes;
	}

	public Long getFldOutstandingTimes() {
		return this.fldOutstandingTimes;
	}

	public void setFldOutstandingTimes(Long fldOutstandingTimes) {
		this.fldOutstandingTimes = fldOutstandingTimes;
	}

	public Timestamp getFldLastModiTime() {
		return this.fldLastModiTime;
	}

	public void setFldLastModiTime(Timestamp fldLastModiTime) {
		this.fldLastModiTime = fldLastModiTime;
	}
}