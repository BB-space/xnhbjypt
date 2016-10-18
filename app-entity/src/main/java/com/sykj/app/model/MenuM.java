package com.sykj.app.model;

import java.math.BigDecimal;

public class MenuM implements java.io.Serializable {

	private String id;
	private String text;
	private String iconCls;
	private String state;
	private String checked;
	private String src;
	private BigDecimal seq;
	private String showStatus;//前后台显示按钮（0：后台，1前台）
	private String parentId;
	private String parentText;
	
	public MenuM(){
		
	}
	
	public MenuM(String id, String text, String iconCls, String state,
			String checked, String src, BigDecimal seq, String parentId,
			String parentText) {
		super();
		this.id = id;
		this.text = text;
		this.iconCls = iconCls;
		this.state = state;
		this.checked = checked;
		this.src = src;
		this.seq = seq;
		this.parentId = parentId;
		this.parentText = parentText;
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

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
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

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public BigDecimal getSeq() {
		return seq;
	}

	public void setSeq(BigDecimal seq) {
		this.seq = seq;
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

	public String getShowStatus() {
		return showStatus;
	}

	public void setShowStatus(String showStatus) {
		this.showStatus = showStatus;
	}
	
	
}
