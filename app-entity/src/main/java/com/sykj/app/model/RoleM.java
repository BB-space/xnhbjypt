package com.sykj.app.model;

import java.math.BigDecimal;

public class RoleM implements java.io.Serializable {

	private String id;
	private String text;
	private BigDecimal seq;
	private String descript;

	private String parentId;
	private String parentText;
	private String state;
	private String checked;
	private String resourcesId;
	private String resourcesText;
	private String menuId;
	private String menuText;
	public RoleM(){
		
	}
	
	public RoleM(String id, String text, BigDecimal seq, String descript,
			String parentId, String parentText, String state, String checked,
			String resourcesId, String resourcesText) {
		super();
		this.id = id;
		this.text = text;
		this.seq = seq;
		this.descript = descript;
		this.parentId = parentId;
		this.parentText = parentText;
		this.state = state;
		this.checked = checked;
		this.resourcesId = resourcesId;
		this.resourcesText = resourcesText;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public BigDecimal getSeq() {
		return seq;
	}

	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getParentText() {
		return parentText;
	}

	public void setParentText(String parentText) {
		this.parentText = parentText;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getResourcesId() {
		return resourcesId;
	}

	public void setResourcesId(String resourcesId) {
		this.resourcesId = resourcesId;
	}

	public String getResourcesText() {
		return resourcesText;
	}

	public void setResourcesText(String resourcesText) {
		this.resourcesText = resourcesText;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getMenuText() {
		return menuText;
	}

	public void setMenuText(String menuText) {
		this.menuText = menuText;
	}
	
}
