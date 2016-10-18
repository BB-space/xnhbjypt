package com.sykj.app.model;

import java.io.Serializable;

/**
 * 卡券说明模型，用于卡券使用说明
 */
public class ExplainM implements Serializable{

	private String id;
	private String content;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
