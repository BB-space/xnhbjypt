package com.sykj.app.entity.finance;

/**
 * 待审核虚拟币提现表
 * XnhbMoneyWaitauditxnbt entity. @author MyEclipse Persistence Tools
 */

public class WaitAuditxnbt implements java.io.Serializable {

	// Fields

	private String waitauditxnbtId;
	private String createdatetime;
	private String updatedatetime;
	private String createuser;
	private String updateuser;
	private String keyword;
	private String loginname;
	private String usernickname;
	private String userrealname;
	private String xnbtype;
	private String status;
	private String tradingtype;
	private Double num;
	private Double poundage;
	private String withdrawaladdress;

	// Constructors

	/** default constructor */
	public WaitAuditxnbt() {
	}

	/** minimal constructor */
	public WaitAuditxnbt(String waitauditxnbtId, Double num,
			Double poundage) {
		this.waitauditxnbtId = waitauditxnbtId;
		this.num = num;
		this.poundage = poundage;
	}

	/** full constructor */
	public WaitAuditxnbt(String waitauditxnbtId,
			String createdatetime, String updatedatetime,
			String createuser, String updateuser, String keyword,
			String loginname, String usernickname, String userrealname,
			String xnbtype, String status, String tradingtype, Double num,
			Double poundage, String withdrawaladdress) {
		this.waitauditxnbtId = waitauditxnbtId;
		this.createdatetime = createdatetime;
		this.updatedatetime = updatedatetime;
		this.createuser = createuser;
		this.updateuser = updateuser;
		this.keyword = keyword;
		this.loginname = loginname;
		this.usernickname = usernickname;
		this.userrealname = userrealname;
		this.xnbtype = xnbtype;
		this.status = status;
		this.tradingtype = tradingtype;
		this.num = num;
		this.poundage = poundage;
		this.withdrawaladdress = withdrawaladdress;
	}

	// Property accessors

	public String getWaitauditxnbtId() {
		return this.waitauditxnbtId;
	}

	public void setWaitauditxnbtId(String waitauditxnbtId) {
		this.waitauditxnbtId = waitauditxnbtId;
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

	public String getXnbtype() {
		return this.xnbtype;
	}

	public void setXnbtype(String xnbtype) {
		this.xnbtype = xnbtype;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTradingtype() {
		return this.tradingtype;
	}

	public void setTradingtype(String tradingtype) {
		this.tradingtype = tradingtype;
	}

	public Double getNum() {
		return this.num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public Double getPoundage() {
		return this.poundage;
	}

	public void setPoundage(Double poundage) {
		this.poundage = poundage;
	}

	public String getWithdrawaladdress() {
		return this.withdrawaladdress;
	}

	public void setWithdrawaladdress(String withdrawaladdress) {
		this.withdrawaladdress = withdrawaladdress;
	}

}