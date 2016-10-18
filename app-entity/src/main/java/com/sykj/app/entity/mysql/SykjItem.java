package com.sykj.app.entity.mysql;

import java.sql.Timestamp;

/**
 * SykjErpItem entity. @author MyEclipse Persistence Tools
 */

public class SykjItem implements java.io.Serializable {

	// Fields

	private String id;
	private String fldItemCode;
	private String fldItemName1;
	private Integer fldItemType;
	private Timestamp fldCreateTime;
	private Timestamp fldLastModiTime;
	private String fldMnemonicCode;

	// Constructors

	/** default constructor */
	public SykjItem() {
	}

	/** minimal constructor */
	public SykjItem(String id) {
		this.id = id;
	}

	/** full constructor */
	public SykjItem(String id, String fldItemCode, String fldItemName1,
			Integer fldItemType, Timestamp fldCreateTime,
			Timestamp fldLastModiTime, String fldMnemonicCode) {
		this.id = id;
		this.fldItemCode = fldItemCode;
		this.fldItemName1 = fldItemName1;
		this.fldItemType = fldItemType;
		this.fldCreateTime = fldCreateTime;
		this.fldLastModiTime = fldLastModiTime;
		this.fldMnemonicCode = fldMnemonicCode;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFldItemCode() {
		return this.fldItemCode;
	}

	public void setFldItemCode(String fldItemCode) {
		this.fldItemCode = fldItemCode;
	}

	public String getFldItemName1() {
		return this.fldItemName1;
	}

	public void setFldItemName1(String fldItemName1) {
		this.fldItemName1 = fldItemName1;
	}

	public Integer getFldItemType() {
		return this.fldItemType;
	}

	public void setFldItemType(Integer fldItemType) {
		this.fldItemType = fldItemType;
	}

	public Timestamp getFldCreateTime() {
		return this.fldCreateTime;
	}

	public void setFldCreateTime(Timestamp fldCreateTime) {
		this.fldCreateTime = fldCreateTime;
	}

	public Timestamp getFldLastModiTime() {
		return this.fldLastModiTime;
	}

	public void setFldLastModiTime(Timestamp fldLastModiTime) {
		this.fldLastModiTime = fldLastModiTime;
	}

	public String getFldMnemonicCode() {
		return this.fldMnemonicCode;
	}

	public void setFldMnemonicCode(String fldMnemonicCode) {
		this.fldMnemonicCode = fldMnemonicCode;
	}

}