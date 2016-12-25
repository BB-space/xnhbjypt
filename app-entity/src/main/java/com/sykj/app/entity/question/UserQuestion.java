package com.sykj.app.entity.question;

/**
 * 问题表
 * @author lisq
 *
 */
public class UserQuestion  implements java.io.Serializable {

	private String questionId;//
	private String createDateTime;//创建时间
	private String updateDateTime;//修改时间
	private String createUser;//创建人
	private String updateUser;//修改人
	private String questionUser;//提问人
	private String loginName;//登录名
	private String status;//状态
	private String questionType;//问题类型
	private String replyCentent;//回复内容
	private String questionCentent;//提问内容
	private String replyPeople;//回复人
	private String questionNumber;//问题编号
	private String replyDateTime; //回复时间
	private String mobile; //联系电话
	private Integer seq;
	
	public UserQuestion() {
		super();
	}
	
	public UserQuestion(String questionId, String createDateTime, String updateDateTime, String createUser,
			String updateUser, String questionUser, String loginName, String status, String questionType,
			String replyCentent, String questionCentent, String replyPeople, String questionNumber,
			String replyDateTime, String mobile) {
		super();
		this.questionId = questionId;
		this.createDateTime = createDateTime;
		this.updateDateTime = updateDateTime;
		this.createUser = createUser;
		this.updateUser = updateUser;
		this.questionUser = questionUser;
		this.loginName = loginName;
		this.status = status;
		this.questionType = questionType;
		this.replyCentent = replyCentent;
		this.questionCentent = questionCentent;
		this.replyPeople = replyPeople;
		this.questionNumber = questionNumber;
		this.replyDateTime = replyDateTime;
		this.mobile = mobile;
	}

	public String getQuestionId() {
		return questionId;
	}

	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}

	public String getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(String createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getUpdateDateTime() {
		return updateDateTime;
	}

	public void setUpdateDateTime(String updateDateTime) {
		this.updateDateTime = updateDateTime;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getQuestionUser() {
		return questionUser;
	}

	public void setQuestionUser(String questionUser) {
		this.questionUser = questionUser;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	public String getReplyCentent() {
		return replyCentent;
	}

	public void setReplyCentent(String replyCentent) {
		this.replyCentent = replyCentent;
	}

	public String getQuestionCentent() {
		return questionCentent;
	}

	public void setQuestionCentent(String questionCentent) {
		this.questionCentent = questionCentent;
	}

	public String getReplyPeople() {
		return replyPeople;
	}

	public void setReplyPeople(String replyPeople) {
		this.replyPeople = replyPeople;
	}

	public String getQuestionNumber() {
		return questionNumber;
	}

	public void setQuestionNumber(String questionNumber) {
		this.questionNumber = questionNumber;
	}

	public String getReplyDateTime() {
		return replyDateTime;
	}

	public void setReplyDateTime(String replyDateTime) {
		this.replyDateTime = replyDateTime;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	
}
