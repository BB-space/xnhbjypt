package com.sykj.app.entity.finance;

/**
 * 会员资金表
 * XnhbMoneyMembermomey entity. @author MyEclipse Persistence Tools
 */

public class MemberMoney implements java.io.Serializable {

	// Fields

	private String membermomeyId;
	private String createdatetime;
	private String updatedatetime;
	private String createuser;
	private String updateuser;
	private String keyword;
	private String description;
	private Integer seq;
	private String loginname;
	private String usernickname;
	private String userrealname;
	private Double userallmoney;
	private Double userfreezemoney;

	// Constructors

	/** default constructor */
	public MemberMoney() {
	}

	/** minimal constructor */
	public MemberMoney(String membermomeyId, Integer seq,
			Double userallmoney, Double userfreezemoney) {
		this.membermomeyId = membermomeyId;
		this.seq = seq;
		this.userallmoney = userallmoney;
		this.userfreezemoney = userfreezemoney;
	}

	/** full constructor */
	public MemberMoney(String membermomeyId, String createdatetime,
			String updatedatetime, String createuser, String updateuser,
			String keyword, String description, Integer seq, String loginname,
			String usernickname, String userrealname, Double userallmoney,
			Double userfreezemoney) {
		this.membermomeyId = membermomeyId;
		this.createdatetime = createdatetime;
		this.updatedatetime = updatedatetime;
		this.createuser = createuser;
		this.updateuser = updateuser;
		this.keyword = keyword;
		this.description = description;
		this.seq = seq;
		this.loginname = loginname;
		this.usernickname = usernickname;
		this.userrealname = userrealname;
		this.userallmoney = userallmoney;
		this.userfreezemoney = userfreezemoney;
	}

	// Property accessors

	public String getMembermomeyId() {
		return this.membermomeyId;
	}

	public void setMembermomeyId(String membermomeyId) {
		this.membermomeyId = membermomeyId;
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

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getSeq() {
		return this.seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
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

	public Double getUserallmoney() {
		return this.userallmoney;
	}

	public void setUserallmoney(Double userallmoney) {
		this.userallmoney = userallmoney;
	}

	public Double getUserfreezemoney() {
		return this.userfreezemoney;
	}

	public void setUserfreezemoney(Double userfreezemoney) {
		this.userfreezemoney = userfreezemoney;
	}

}