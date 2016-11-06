package com.sykj.app.entity.finance;

/**
 * 人民币操作记录表
 * XnhbMoneyRmboperationrecord entity. @author MyEclipse Persistence Tools
 */

public class RmbOperationRecord implements java.io.Serializable {

	// Fields

	private String rmboperationrecordId;
	private String createdatetime;
	private String updatedatetime;
	private String createuser;
	private String updateuser;
	private String keyword;
	private String loginname;
	private String usernickname;
	private String userrealname;
	private String collectionbank;
	private String bankaccount;
	private String tradingtype;
	private String status;
	private Double money;
	private Double poundage;
	private String bankaddress;
	private String auditpeople;
	private String auditdatetime;
	private String discription;

	// Constructors

	/** default constructor */
	public RmbOperationRecord() {
	}

	/** minimal constructor */
	public RmbOperationRecord(String rmboperationrecordId,
			Double poundage) {
		this.rmboperationrecordId = rmboperationrecordId;
		this.poundage = poundage;
	}

	/** full constructor */
	public RmbOperationRecord(String rmboperationrecordId,
			String createdatetime, String updatedatetime,
			String createuser, String updateuser, String keyword,
			String loginname, String usernickname, String userrealname,
			String collectionbank, String bankaccount, String tradingtype,
			String status, Double money, Double poundage, String bankaddress,
			String auditpeople, String auditdatetime, String discription) {
		this.rmboperationrecordId = rmboperationrecordId;
		this.createdatetime = createdatetime;
		this.updatedatetime = updatedatetime;
		this.createuser = createuser;
		this.updateuser = updateuser;
		this.keyword = keyword;
		this.loginname = loginname;
		this.usernickname = usernickname;
		this.userrealname = userrealname;
		this.collectionbank = collectionbank;
		this.bankaccount = bankaccount;
		this.tradingtype = tradingtype;
		this.status = status;
		this.money = money;
		this.poundage = poundage;
		this.bankaddress = bankaddress;
		this.auditpeople = auditpeople;
		this.auditdatetime = auditdatetime;
		this.discription = discription;
	}

	// Property accessors

	public String getRmboperationrecordId() {
		return this.rmboperationrecordId;
	}

	public void setRmboperationrecordId(String rmboperationrecordId) {
		this.rmboperationrecordId = rmboperationrecordId;
	}

	public String getCreatedatetime() {
		return this.createdatetime;
	}

	public void setCreatedatetime(String createdatetime) {
		this.createdatetime = createdatetime;
	}

	public String getUpdatedatetime() {
		return this.updatedatetime;
	}

	public void setUpdatedatetime(String updatedatetime) {
		this.updatedatetime = updatedatetime;
	}

	public String getCreateuser() {
		return this.createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	public String getUpdateuser() {
		return this.updateuser;
	}

	public void setUpdateuser(String updateuser) {
		this.updateuser = updateuser;
	}

	public String getKeyword() {
		return this.keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getLoginname() {
		return this.loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getUsernickname() {
		return this.usernickname;
	}

	public void setUsernickname(String usernickname) {
		this.usernickname = usernickname;
	}

	public String getUserrealname() {
		return this.userrealname;
	}

	public void setUserrealname(String userrealname) {
		this.userrealname = userrealname;
	}

	public String getCollectionbank() {
		return this.collectionbank;
	}

	public void setCollectionbank(String collectionbank) {
		this.collectionbank = collectionbank;
	}

	public String getBankaccount() {
		return this.bankaccount;
	}

	public void setBankaccount(String bankaccount) {
		this.bankaccount = bankaccount;
	}

	public String getTradingtype() {
		return this.tradingtype;
	}

	public void setTradingtype(String tradingtype) {
		this.tradingtype = tradingtype;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Double getPoundage() {
		return this.poundage;
	}

	public void setPoundage(Double poundage) {
		this.poundage = poundage;
	}

	public String getBankaddress() {
		return this.bankaddress;
	}

	public void setBankaddress(String bankaddress) {
		this.bankaddress = bankaddress;
	}

	public String getAuditpeople() {
		return this.auditpeople;
	}

	public void setAuditpeople(String auditpeople) {
		this.auditpeople = auditpeople;
	}

	public String getAuditdatetime() {
		return this.auditdatetime;
	}

	public void setAuditdatetime(String auditdatetime) {
		this.auditdatetime = auditdatetime;
	}

	public String getDiscription() {
		return this.discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

}