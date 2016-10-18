package com.sykj.app.model;

import java.math.BigDecimal;

public class ShopResourcesM implements java.io.Serializable {

	private String id;
	private String text;
	private BigDecimal seq;
	private String src;
	private String descript;
	private String onoff;

	private String parentId;
	private String parentText;
	private String state;
	private String checked;
	
	public ShopResourcesM(){
		
	}
	
	public ShopResourcesM(String id, String text, BigDecimal seq, String src,
			String descript, String onoff, String parentId, String parentText,
			String state, String checked) {
		super();
		this.id = id;
		this.text = text;
		this.seq = seq;
		this.src = src;
		this.descript = descript;
		this.onoff = onoff;
		this.parentId = parentId;
		this.parentText = parentText;
		this.state = state;
		this.checked = checked;
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
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getDescript() {
		return descript;
	}
	public void setDescript(String descript) {
		this.descript = descript;
	}
	public String getOnoff() {
		return onoff;
	}
	public void setOnoff(String onoff) {
		this.onoff = onoff;
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

	
	
}
