/**
 * 
 */
package com.sykj.app.model.reportForm;

import java.io.Serializable;

/**
 * @author wjl 2016年1月9日 下午3:26:37
 */
public class ShopCityM implements Serializable{

	private String shopId ;
	private String shortNumber;
	private String shopName;
	private String cityName;
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public String getShortNumber() {
		return shortNumber;
	}
	public void setShortNumber(String shortNumber) {
		this.shortNumber = shortNumber;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
}
