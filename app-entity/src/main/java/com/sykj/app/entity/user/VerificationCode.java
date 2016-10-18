package com.sykj.app.entity.user;

import java.util.Date;

/**
 * APP验证码表
 * @author swh
 *
 */
public class VerificationCode implements java.io.Serializable {

	private String id;
	private String code;//验证码
	private String mobile;//手机
	private String codeType;//验证码类型(0:注册，1:重置密码)
	private String codeStatus;//验证码状态(0:未使用，1：已使用，2：已过期)
	private Date createDateTime;//创建时间
	private Date usedDateTime;//使用日期
	
	public VerificationCode(){
		
	}
	
	public VerificationCode(String id, String code, String mobile,
			String codeType, String codeStatus, Date createDateTime) {
		super();
		this.id = id;
		this.code = code;
		this.mobile = mobile;
		this.codeType = codeType;
		this.codeStatus = codeStatus;
		this.createDateTime = createDateTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getCodeType() {
		return codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public String getCodeStatus() {
		return codeStatus;
	}

	public void setCodeStatus(String codeStatus) {
		this.codeStatus = codeStatus;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public Date getUsedDateTime() {
		return usedDateTime;
	}

	public void setUsedDateTime(Date usedDateTime) {
		this.usedDateTime = usedDateTime;
	}
	
}
