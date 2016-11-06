package com.sykj.app.entity.finance;

/**
 * 人民币手工充值表
 * XnhbMoneyRmbmanual entity. @author MyEclipse Persistence Tools
 */

public class RmbManual implements java.io.Serializable {

	// Fields

	private String rmbmanualId;
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
	private String remittancetype;
	private String status;
	private Double money;
	private String auditpeople;

	// Constructors

	/** default constructor */
	public RmbManual() {
	}

	/** minimal constructor */
	public RmbManual(String rmbmanualId, Integer seq, Double money) {
		this.rmbmanualId = rmbmanualId;
		this.seq = seq;
		this.money = money;
	}

	/** full constructor */
	public RmbManual(String rmbmanualId, String createdatetime,
			String updatedatetime, String createuser, String updateuser,
			String keyword, String description, Integer seq, String loginname,
			String usernickname, String userrealname, String remittancetype,
			String status, Double money, String auditpeople) {
		this.rmbmanualId = rmbmanualId;
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
		this.remittancetype = remittancetype;
		this.status = status;
		this.money = money;
		this.auditpeople = auditpeople;
	}

	// Property accessors

	public String getRmbmanualId() {
		return this.rmbmanualId;
	}

	public void setRmbmanualId(String rmbmanualId) {
		this.rmbmanualId = rmbmanualId;
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

	public String getRemittancetype() {
		return this.remittancetype;
	}

	public void setRemittancetype(String remittancetype) {
		this.remittancetype = remittancetype;
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

	public String getAuditpeople() {
		return this.auditpeople;
	}

	public void setAuditpeople(String auditpeople) {
		this.auditpeople = auditpeople;
	}

}