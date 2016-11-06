package com.sykj.app.entity.finance;

/**
 * 虚拟币人工充值表
 * XnhbMoneyXnbmanual entity. @author MyEclipse Persistence Tools
 */

public class XnbManual implements java.io.Serializable {

	// Fields

	private String xnbmanualId;
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
	private String xnbtype;
	private String status;
	private Double num;
	private String auditdatetime;
	private String auditpeople;
	private String sendmessage;

	// Constructors

	/** default constructor */
	public XnbManual() {
	}

	/** minimal constructor */
	public XnbManual(String xnbmanualId, Integer seq, Double num) {
		this.xnbmanualId = xnbmanualId;
		this.seq = seq;
		this.num = num;
	}

	/** full constructor */
	public XnbManual(String xnbmanualId, String createdatetime,
			String updatedatetime, String createuser, String updateuser,
			String keyword, String description, Integer seq, String loginname,
			String usernickname, String userrealname, String xnbtype,
			String status, Double num, String auditdatetime,
			String auditpeople, String sendmessage) {
		this.xnbmanualId = xnbmanualId;
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
		this.xnbtype = xnbtype;
		this.status = status;
		this.num = num;
		this.auditdatetime = auditdatetime;
		this.auditpeople = auditpeople;
		this.sendmessage = sendmessage;
	}

	// Property accessors

	public String getXnbmanualId() {
		return this.xnbmanualId;
	}

	public void setXnbmanualId(String xnbmanualId) {
		this.xnbmanualId = xnbmanualId;
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

	public Double getNum() {
		return this.num;
	}

	public void setNum(Double num) {
		this.num = num;
	}

	public String getAuditdatetime() {
		return this.auditdatetime;
	}

	public void setAuditdatetime(String auditdatetime) {
		this.auditdatetime = auditdatetime;
	}

	public String getAuditpeople() {
		return this.auditpeople;
	}

	public void setAuditpeople(String auditpeople) {
		this.auditpeople = auditpeople;
	}

	public String getSendmessage() {
		return this.sendmessage;
	}

	public void setSendmessage(String sendmessage) {
		this.sendmessage = sendmessage;
	}

}