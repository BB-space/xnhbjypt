package com.sykj.app.entity.finance;

/**
 * 待审核人民币充值表
 * XnhbMoneyWaitauditrmbt entity. @author MyEclipse Persistence Tools
 */

public class WaitAuditrmbt implements java.io.Serializable {

	// Fields

	private String waitauditrmbtId;
	private String createdatetime;
	private String updatedatetime;
	private String createuser;
	private String updateuser;
	private String keyword;
	private String loginname;
	private String usernickname;
	private String userrealname;
	private String cztype;
	private String status;
	private Double money;
	private Double poundage;
	private String bank;
	private String remittanceaccount;
	private String remittancepeople;
	private String description;
	private String topupid;

	// Constructors

	/** default constructor */
	public WaitAuditrmbt() {
	}

	/** minimal constructor */
	public WaitAuditrmbt(String waitauditrmbtId) {
		this.waitauditrmbtId = waitauditrmbtId;
	}

	/** full constructor */
	public WaitAuditrmbt(String waitauditrmbtId,
			String createdatetime, String updatedatetime,
			String createuser, String updateuser, String keyword,
			String loginname, String usernickname, String userrealname,
			String cztype, String status, Double money, Double poundage,
			String bank, String remittanceaccount, String remittancepeople,
			String description, String topupid) {
		this.waitauditrmbtId = waitauditrmbtId;
		this.createdatetime = createdatetime;
		this.updatedatetime = updatedatetime;
		this.createuser = createuser;
		this.updateuser = updateuser;
		this.keyword = keyword;
		this.loginname = loginname;
		this.usernickname = usernickname;
		this.userrealname = userrealname;
		this.cztype = cztype;
		this.status = status;
		this.money = money;
		this.poundage = poundage;
		this.bank = bank;
		this.remittanceaccount = remittanceaccount;
		this.remittancepeople = remittancepeople;
		this.description = description;
		this.topupid = topupid;
	}

	// Property accessors

	public String getWaitauditrmbtId() {
		return this.waitauditrmbtId;
	}

	public void setWaitauditrmbtId(String waitauditrmbtId) {
		this.waitauditrmbtId = waitauditrmbtId;
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

	public String getCztype() {
		return this.cztype;
	}

	public void setCztype(String cztype) {
		this.cztype = cztype;
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

	public String getBank() {
		return this.bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getRemittanceaccount() {
		return this.remittanceaccount;
	}

	public void setRemittanceaccount(String remittanceaccount) {
		this.remittanceaccount = remittanceaccount;
	}

	public String getRemittancepeople() {
		return this.remittancepeople;
	}

	public void setRemittancepeople(String remittancepeople) {
		this.remittancepeople = remittancepeople;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTopupid() {
		return this.topupid;
	}

	public void setTopupid(String topupid) {
		this.topupid = topupid;
	}

}