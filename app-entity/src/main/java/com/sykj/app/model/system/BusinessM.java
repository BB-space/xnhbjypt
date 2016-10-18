package com.sykj.app.model.system;

import java.math.BigDecimal;

import com.sykj.app.entity.system.Business;

/**
 * @author wjl 2016年10月12日 上午11:10:58
 */
public class BusinessM {

	private String id;
	private String text;//职务名字
	private BigDecimal seq;//排序
	private String descript;//描述
	
	private String parentId;
	private String parentText;
	private String state;
	private String checked;
	private String resourcesId;
	private String resourcesText;
	private String menuId;
	private String menuText;
	
	public BusinessM(){
		
	}
	
	public BusinessM(String id, String text, BigDecimal seq, String descript,
			String parentId, String parentText, String state, String checked,
			String resourcesId, String resourcesText,String menuId,String menuText) {
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
		this.menuId = menuId;
		this.menuText = menuText;
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
