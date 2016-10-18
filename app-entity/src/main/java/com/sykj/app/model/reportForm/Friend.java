package com.sykj.app.model.reportForm;

import java.io.Serializable;

/**
 * 亲友券报表模型
 */
public class Friend implements Serializable{

	private String openId;
	private String mobile;
	private Integer getNum;
	private Integer giveNum;
	private Integer receiveNum;
	private Integer useNum;
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Integer getGetNum() {
		return getNum;
	}
	public void setGetNum(Integer getNum) {
		this.getNum = getNum;
	}
	public Integer getGiveNum() {
		return giveNum;
	}
	public void setGiveNum(Integer giveNum) {
		this.giveNum = giveNum;
	}
	public Integer getReceiveNum() {
		return receiveNum;
	}
	public void setReceiveNum(Integer receiveNum) {
		this.receiveNum = receiveNum;
	}
	public Integer getUseNum() {
		return useNum;
	}
	public void setUseNum(Integer useNum) {
		this.useNum = useNum;
	}
}
