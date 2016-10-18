package com.sykj.app.model;

public class EasyuiComboBox implements java.io.Serializable {

	private String id;
	private String text;
	
	public EasyuiComboBox(){
		
	}
	
	public EasyuiComboBox(String id, String text) {
		super();
		this.id = id;
		this.text = text;
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
	
}
