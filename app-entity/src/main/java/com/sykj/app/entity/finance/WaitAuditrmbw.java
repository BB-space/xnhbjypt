package com.sykj.app.entity.finance;

/**
 * 待审核人民币提现表
 * XnhbMoneyWaitauditrmbw entity. @author MyEclipse Persistence Tools
 */

public class WaitAuditrmbw implements java.io.Serializable {

	// Fields

	private String waitauditrmbwId;
	private String createdatetime;
	private String updatedatetime;
	private String createuser;
	private String updateuser;
	private String keyword;
	private String loginname;
	private String usernickname;
	private String userrealname;
	private String type;
	private String status;
	private Double money;
	private Double poundage;
	private String bank;
	private String paymentaccount;
	private String bankaddress;
	private String description;

	// Constructors

	/** default constructor */
	public WaitAuditrmbw() {
	}

	/** minimal constructor */
	public WaitAuditrmbw(String waitauditrmbwId, Double money,
			Double poundage) {
		this.waitauditrmbwId = waitauditrmbwId;
		this.money = money;
		this.poundage = poundage;
	}

	/** full constructor */
	public WaitAuditrmbw(String waitauditrmbwId,
			String createdatetime, String updatedatetime,
			String createuser, String updateuser, String keyword,
			String loginname, String usernickname, String userrealname,
			String type, String status, Double money, Double poundage,
			String bank, String paymentaccount, String bankaddress,
			String description) {
		this.waitauditrmbwId = waitauditrmbwId;
		this.createdatetime = createdatetime;
		this.updatedatetime = updatedatetime;
		this.createuser = createuser;
		this.updateuser = updateuser;
		this.keyword = keyword;
		this.loginname = loginname;
		this.usernickname = usernickname;
		this.userrealname = userrealname;
		this.type = type;
		this.status = status;
		this.money = money;
		this.poundage = poundage;
		this.bank = bank;
		this.paymentaccount = paymentaccount;
		this.bankaddress = bankaddress;
		this.description = description;
	}

	// Property accessors

	public String getWaitauditrmbwId() {
		return this.waitauditrmbwId;
	}

	public void setWaitauditrmbwId(String waitauditrmbwId) {
		this.waitauditrmbwId = waitauditrmbwId;
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

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getPaymentaccount() {
		return this.paymentaccount;
	}

	public void setPaymentaccount(String paymentaccount) {
		this.paymentaccount = paymentaccount;
	}

	public String getBankaddress() {
		return this.bankaddress;
	}

	public void setBankaddress(String bankaddress) {
		this.bankaddress = bankaddress;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}