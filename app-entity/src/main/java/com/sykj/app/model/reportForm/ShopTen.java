package com.sykj.app.model.reportForm;

import java.io.Serializable;
import java.util.Date;

/**
 * 门店核销10元券报表模型
 */
public class ShopTen implements Serializable{

	private String date;
	private String shopName;
	private String staffName;
	private Integer num;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
}
