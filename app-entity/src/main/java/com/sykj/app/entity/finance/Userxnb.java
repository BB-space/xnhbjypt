package com.sykj.app.entity.finance;

/**
 * 会员虚拟币表
 * XnhbMoneyUserxnb entity. @author MyEclipse Persistence Tools
 */

public class Userxnb implements java.io.Serializable {

	// Fields

	private String userxnbId;
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
	private Double userallnum;
	private Double userfreezenum;
	private String xnbtype;

	// Constructors

	/** default constructor */
	public Userxnb() {
	}

	/** minimal constructor */
	public Userxnb(String userxnbId, Integer seq, Double userallnum,
			Double userfreezenum) {
		this.userxnbId = userxnbId;
		this.seq = seq;
		this.userallnum = userallnum;
		this.userfreezenum = userfreezenum;
	}

	/** full constructor */
	public Userxnb(String userxnbId, String createdatetime,
			String updatedatetime, String createuser, String updateuser,
			String keyword, String description, Integer seq, String loginname,
			String usernickname, String userrealname, Double userallnum,
			Double userfreezenum, String xnbtype) {
		this.userxnbId = userxnbId;
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
		this.userallnum = userallnum;
		this.userfreezenum = userfreezenum;
		this.xnbtype = xnbtype;
	}

	// Property accessors

	public String getUserxnbId() {
		return this.userxnbId;
	}

	public void setUserxnbId(String userxnbId) {
		this.userxnbId = userxnbId;
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

	public Double getUserallnum() {
		return this.userallnum;
	}

	public void setUserallnum(Double userallnum) {
		this.userallnum = userallnum;
	}

	public Double getUserfreezenum() {
		return this.userfreezenum;
	}

	public void setUserfreezenum(Double userfreezenum) {
		this.userfreezenum = userfreezenum;
	}

	public String getXnbtype() {
		return this.xnbtype;
	}

	public void setXnbtype(String xnbtype) {
		this.xnbtype = xnbtype;
	}

}