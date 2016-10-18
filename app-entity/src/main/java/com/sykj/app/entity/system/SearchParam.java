package com.sykj.app.entity.system;

import java.io.Serializable;
import java.util.Date;

public class SearchParam implements Serializable {

	private String id;
	private String mobile;
	private String menuId;
	private String cityNames;
	private Date createDateTime;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getCityNames() {
		return cityNames;
	}

	public void setCityNames(String cityNames) {
		this.cityNames = cityNames;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	@Override
	public String toString() {
		return "SearchParam [id=" + id + ", mobile=" + mobile + ", menuId="
				+ menuId + ", cityNames=" + cityNames + ", createDateTime="
				+ createDateTime + "]";
	}
	
}
