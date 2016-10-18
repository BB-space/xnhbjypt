package com.sykj.app.model.reportForm;

import java.io.Serializable;

/**
 * 10元券和18元券报表模型
 */
public class TenAndEighteen implements Serializable{

	private String memberopenid;       //会员openId
	private String memberMobile;       //会员手机号
	private Integer getNum1;           //获取数量1
	private Integer useNum1;           //使用数量1
	private String type;               //卡类型
	public String getMemberMobile() {
		return memberMobile;
	}
	public void setMemberMobile(String memberMobile) {
		this.memberMobile = memberMobile;
	}
	public String getMemberopenid() {
		return memberopenid;
	}
	public void setMemberopenid(String memberopenid) {
		this.memberopenid = memberopenid;
	}
	public Integer getGetNum1() {
		return getNum1;
	}
	public void setGetNum1(Integer getNum1) {
		this.getNum1 = getNum1;
	}
	public Integer getUseNum1() {
		return useNum1;
	}
	public void setUseNum1(Integer useNum1) {
		this.useNum1 = useNum1;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
