package com.sykj.app.entity.finance;

/**
 * 虚拟币操作记录表
 * XnhbMoneyXnboperationrecord entity. @author MyEclipse Persistence Tools
 */

public class XnbOperationRecord implements java.io.Serializable {

	// Fields

	private String xnboperationrecordId;
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
	private String topupaddress;
	private String tradingid;

	// Constructors

	/** default constructor */
	public XnbOperationRecord() {
	}

	/** minimal constructor */
	public XnbOperationRecord(String xnboperationrecordId, Double num,
			Double poundage) {
		this.xnboperationrecordId = xnboperationrecordId;
		this.num = num;
		this.poundage = poundage;
	}

	/** full constructor */
	public XnbOperationRecord(String xnboperationrecordId,
			String createdatetime, String updatedatetime,
			String createuser, String updateuser, String keyword,
			String loginname, String usernickname, String userrealname,
			String xnbtype, String status, String tradingtype, Double num,
			Double poundage, String withdrawaladdress, String topupaddress,
			String tradingid) {
		this.xnboperationrecordId = xnboperationrecordId;
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
		this.topupaddress = topupaddress;
		this.tradingid = tradingid;
	}

	// Property accessors

	public String getXnboperationrecordId() {
		return this.xnboperationrecordId;
	}

	public void setXnboperationrecordId(String xnboperationrecordId) {
		this.xnboperationrecordId = xnboperationrecordId;
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

	public String getTopupaddress() {
		return this.topupaddress;
	}

	public void setTopupaddress(String topupaddress) {
		this.topupaddress = topupaddress;
	}

	public String getTradingid() {
		return this.tradingid;
	}

	public void setTradingid(String tradingid) {
		this.tradingid = tradingid;
	}

}