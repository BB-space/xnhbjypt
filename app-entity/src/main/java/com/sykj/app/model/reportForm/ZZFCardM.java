/**
 * 
 */
package com.sykj.app.model.reportForm;

import java.io.Serializable;

/**
 * @author wjl 2016年1月9日 下午3:06:44
 */
public class ZZFCardM implements Serializable{

	private String nowDate;
	private String shopName;
	private Integer lineCardNum1;
	private Integer lineCardNum2;
	private Integer onLineCardNum;
	private Integer onLineCardNum2;
	private Integer friendNum1;
	private Integer friendNum2;
	private Integer friendNum3;
	private Integer friendNum4;
	public String getNowDate() {
		return nowDate;
	}
	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public Integer getLineCardNum1() {
		return lineCardNum1;
	}
	public void setLineCardNum1(Integer lineCardNum1) {
		this.lineCardNum1 = lineCardNum1;
	}
	public Integer getLineCardNum2() {
		return lineCardNum2;
	}
	public void setLineCardNum2(Integer lineCardNum2) {
		this.lineCardNum2 = lineCardNum2;
	}
	public Integer getOnLineCardNum() {
		return onLineCardNum;
	}
	public void setOnLineCardNum(Integer onLineCardNum) {
		this.onLineCardNum = onLineCardNum;
	}
	public Integer getOnLineCardNum2() {
		return onLineCardNum2;
	}
	public void setOnLineCardNum2(Integer onLineCardNum2) {
		this.onLineCardNum2 = onLineCardNum2;
	}
	public Integer getFriendNum1() {
		return friendNum1;
	}
	public void setFriendNum1(Integer friendNum1) {
		this.friendNum1 = friendNum1;
	}
	public Integer getFriendNum2() {
		return friendNum2;
	}
	public void setFriendNum2(Integer friendNum2) {
		this.friendNum2 = friendNum2;
	}
	public Integer getFriendNum3() {
		return friendNum3;
	}
	public void setFriendNum3(Integer friendNum3) {
		this.friendNum3 = friendNum3;
	}
	public Integer getFriendNum4() {
		return friendNum4;
	}
	public void setFriendNum4(Integer friendNum4) {
		this.friendNum4 = friendNum4;
	}
}
