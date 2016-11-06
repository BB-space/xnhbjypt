package com.sykj.app.entity.finance;


/**
 * 委托交易表
 * XnhbMoneyEntrusttrading entity. @author MyEclipse Persistence Tools
 */

public class EntrustTrading implements java.io.Serializable {

	// Fields

	private String entrusttradingId;
	private String createdatetime;
	private String updatedatetime;
	private String createuser;
	private String updateuser;
	private String keyword;
	private String loginname;
	private String usernickname;
	private String userrealname;
	private String xnbtype;
	private String tradingtype;
	private String status;
	private Double price;
	private Double num;
	private Double dealnum;
	private Double nodealnum;
	private Double allmoney;
	private Double alldealmoney;
	private String dealtype;

	// Constructors

	/** default constructor */
	public EntrustTrading() {
	}

	/** minimal constructor */
	public EntrustTrading(String entrusttradingId, Double price,
			Double num, Double dealnum, Double nodealnum, Double allmoney,
			Double alldealmoney) {
		this.entrusttradingId = entrusttradingId;
		this.price = price;
		this.num = num;
		this.dealnum = dealnum;
		this.nodealnum = nodealnum;
		this.allmoney = allmoney;
		this.alldealmoney = alldealmoney;
	}

	/** full constructor */
	public EntrustTrading(String entrusttradingId,
			String createdatetime, String updatedatetime,
			String createuser, String updateuser, String keyword,
			String loginname, String usernickname, String userrealname,
			String xnbtype, String tradingtype, String status, Double price,
			Double num, Double dealnum, Double nodealnum, Double allmoney,
			Double alldealmoney, String dealtype) {
		this.entrusttradingId = entrusttradingId;
		this.createdatetime = createdatetime;
		this.updatedatetime = updatedatetime;
		this.createuser = createuser;
		this.updateuser = updateuser;
		this.keyword = keyword;
		this.loginname = loginname;
		this.usernickname = usernickname;
		this.userrealname = userrealname;
		this.xnbtype = xnbtype;
		this.tradingtype = tradingtype;
		this.status = status;
		this.price = price;
		this.num = num;
		this.dealnum = dealnum;
		this.nodealnum = nodealnum;
		this.allmoney = allmoney;
		this.alldealmoney = alldealmoney;
		this.dealtype = dealtype;
	}

	// Property accessors

	public String getEntrusttradingId() {
		return this.entrusttradingId;
	}

	public void setEntrusttradingId(String entrusttradingId) {
		this.entrusttradingId = entrusttradingId;
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

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getNum() {
		return this.num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public Double getDealnum() {
		return this.dealnum;
	}

	public void setDealnum(Double dealnum) {
		this.dealnum = dealnum;
	}

	public Double getNodealnum() {
		return this.nodealnum;
	}

	public void setNodealnum(Double nodealnum) {
		this.nodealnum = nodealnum;
	}

	public Double getAllmoney() {
		return this.allmoney;
	}

	public void setAllmoney(Double allmoney) {
		this.allmoney = allmoney;
	}

	public Double getAlldealmoney() {
		return this.alldealmoney;
	}

	public void setAlldealmoney(Double alldealmoney) {
		this.alldealmoney = alldealmoney;
	}

	public String getDealtype() {
		return this.dealtype;
	}

	public void setDealtype(String dealtype) {
		this.dealtype = dealtype;
	}

}