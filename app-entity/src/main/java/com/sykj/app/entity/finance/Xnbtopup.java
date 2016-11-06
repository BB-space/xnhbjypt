package com.sykj.app.entity.finance;

/**
 * 虚拟币充值表
 * XnhbMoneyXnbtopup entity. @author MyEclipse Persistence Tools
 */

public class Xnbtopup implements java.io.Serializable {

	// Fields

	private String xnbtopupId;
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

	// Constructors

	/** default constructor */
	public Xnbtopup() {
	}

	/** minimal constructor */
	public Xnbtopup(String xnbtopupId, Double num) {
		this.xnbtopupId = xnbtopupId;
		this.num = num;
	}

	/** full constructor */
	public Xnbtopup(String xnbtopupId, String createdatetime,
			String updatedatetime, String createuser, String updateuser,
			String keyword, String loginname, String usernickname,
			String userrealname, String xnbtype, String status,
			String tradingtype, Double num) {
		this.xnbtopupId = xnbtopupId;
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
	}

	// Property accessors

	public String getXnbtopupId() {
		return this.xnbtopupId;
	}

	public void setXnbtopupId(String xnbtopupId) {
		this.xnbtopupId = xnbtopupId;
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

}