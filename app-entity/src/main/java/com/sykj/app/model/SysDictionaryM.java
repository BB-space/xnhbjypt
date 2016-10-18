package com.sykj.app.model;

import java.util.Date;

public class SysDictionaryM{

	private String id;
	private String paramName;// 参数名称
	private String paramValue1;// 参数值
	private String paramValue2;// 参数值2
	private String paramValue3;
	private String paramValue4;
	private String paramValue5;
	private String paramValue6;
	private String paramDesc;// 描述
	private Integer paramStatus;
	private Date createTime;// 创建时间
	private String creator;// 创建人

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParamName() {
		return paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	public String getParamValue1() {
		return paramValue1;
	}

	public void setParamValue1(String paramValue1) {
		this.paramValue1 = paramValue1;
	}

	public String getParamValue2() {
		return paramValue2;
	}

	public void setParamValue2(String paramValue2) {
		this.paramValue2 = paramValue2;
	}

	public String getParamDesc() {
		return paramDesc;
	}

	public void setParamDesc(String paramDesc) {
		this.paramDesc = paramDesc;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Integer getParamStatus() {
		return paramStatus;
	}

	public void setParamStatus(Integer paramStatus) {
		this.paramStatus = paramStatus;
	}

	public String getParamValue3() {
		return paramValue3;
	}

	public void setParamValue3(String paramValue3) {
		this.paramValue3 = paramValue3;
	}

	public String getParamValue4() {
		return paramValue4;
	}

	public void setParamValue4(String paramValue4) {
		this.paramValue4 = paramValue4;
	}

	public String getParamValue5() {
		return paramValue5;
	}

	public void setParamValue5(String paramValue5) {
		this.paramValue5 = paramValue5;
	}

	public String getParamValue6() {
		return paramValue6;
	}

	public void setParamValue6(String paramValue6) {
		this.paramValue6 = paramValue6;
	}
	
}
