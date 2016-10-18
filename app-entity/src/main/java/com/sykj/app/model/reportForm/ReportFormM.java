package com.sykj.app.model.reportForm;

import java.io.Serializable;
import java.util.Date;

public class ReportFormM implements Serializable{

	private String id ;
	private Date writeOffTime;         //核销日期
	private String memberName;         //会员名字
	private String writeOffShopName;   //划卡门店
	private String binddingShopName;   //绑定门店
	private String line;               //线上/线下
	private String type;               //卡类型
	private String scanerName;         //核销人名字（员工名字）
	private String memberMobile;       //会员手机号
	private String memberopenid;       //会员openId
	private Integer getNum1;           //获取数量1
	private Integer getNum2;           //获取数量2
	private Integer getNum3;           //获取数量3
	private Integer getNum4;           //获取数量4
	private Integer getNum5;           //获取数量5
	private Integer useNum1;           //使用数量1
	private Integer useNum2;           //使用数量2
	private Integer useNum3;           //使用数量3
	private Integer useNum4;           //使用数量4
	private Integer useNum5;           //使用数量5
	private Integer writeOffNum;       //核销数量
	private Integer giveNum;           //赠送数量
	private Integer receiveNum;        //已接收数量
	
	private String reportFormType;     //报表类型（1：10元券和18元券；2：亲友券；3：产品券和服务券；4：核销报表）

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getWriteOffTime() {
		return writeOffTime;
	}

	public void setWriteOffTime(Date writeOffTime) {
		this.writeOffTime = writeOffTime;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getWriteOffShopName() {
		return writeOffShopName;
	}

	public void setWriteOffShopName(String writeOffShopName) {
		this.writeOffShopName = writeOffShopName;
	}

	public String getBinddingShopName() {
		return binddingShopName;
	}

	public void setBinddingShopName(String binddingShopName) {
		this.binddingShopName = binddingShopName;
	}

	public String getLine() {
		return line;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getScanerName() {
		return scanerName;
	}

	public void setScanerName(String scanerName) {
		this.scanerName = scanerName;
	}

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

	public Integer getGetNum2() {
		return getNum2;
	}

	public void setGetNum2(Integer getNum2) {
		this.getNum2 = getNum2;
	}

	public Integer getGetNum3() {
		return getNum3;
	}

	public void setGetNum3(Integer getNum3) {
		this.getNum3 = getNum3;
	}

	public Integer getGetNum4() {
		return getNum4;
	}

	public void setGetNum4(Integer getNum4) {
		this.getNum4 = getNum4;
	}

	public Integer getGetNum5() {
		return getNum5;
	}

	public void setGetNum5(Integer getNum5) {
		this.getNum5 = getNum5;
	}

	public Integer getUseNum1() {
		return useNum1;
	}

	public void setUseNum1(Integer useNum1) {
		this.useNum1 = useNum1;
	}

	public Integer getUseNum2() {
		return useNum2;
	}

	public void setUseNum2(Integer useNum2) {
		this.useNum2 = useNum2;
	}

	public Integer getUseNum3() {
		return useNum3;
	}

	public void setUseNum3(Integer useNum3) {
		this.useNum3 = useNum3;
	}

	public Integer getUseNum4() {
		return useNum4;
	}

	public void setUseNum4(Integer useNum4) {
		this.useNum4 = useNum4;
	}

	public Integer getUseNum5() {
		return useNum5;
	}

	public void setUseNum5(Integer useNum5) {
		this.useNum5 = useNum5;
	}

	public Integer getWriteOffNum() {
		return writeOffNum;
	}

	public void setWriteOffNum(Integer writeOffNum) {
		this.writeOffNum = writeOffNum;
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

	public String getReportFormType() {
		return reportFormType;
	}

	public void setReportFormType(String reportFormType) {
		this.reportFormType = reportFormType;
	}
}
