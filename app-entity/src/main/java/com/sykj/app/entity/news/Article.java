package com.sykj.app.entity.news;

import java.sql.Clob;
import java.sql.Timestamp;
import java.util.Date;

public class Article implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String id;
	private String description;
	private String createDateTime;
	private String createUser;
	private String updateDateTime;
	private String updateUser;
	private String typeId;
	private String title;
	private Integer click;
	private Clob content;
	private String seq;
	private String typeName;
	private String contentStr;
	private String newArticle;
	private String language;
	private String keyword;
	private String mdTime;
	
	
	public Article(){
		
	}





	public Article(String id, String description, String createDateTime, String createUser, String updateDateTime,
			String updateUser, String typeId, String title, Integer click, Clob content, String seq, String typeName,
			String contentStr, String newArticle, String language, String keyword) {
		super();
		this.id = id;
		this.description = description;
		this.createDateTime = createDateTime;
		this.createUser = createUser;
		this.updateDateTime = updateDateTime;
		this.updateUser = updateUser;
		this.typeId = typeId;
		this.title = title;
		this.click = click;
		this.content = content;
		this.seq = seq;
		this.typeName = typeName;
		this.contentStr = contentStr;
		this.newArticle = newArticle;
		this.language = language;
		this.keyword = keyword;
	}





	public String getCreateDateTime() {
		return createDateTime;
	}





	public void setCreateDateTime(String createDateTime) {
		this.createDateTime = createDateTime;
	}





	public String getUpdateDateTime() {
		return updateDateTime;
	}





	public void setUpdateDateTime(String updateDateTime) {
		this.updateDateTime = updateDateTime;
	}





	public String getId() {
		return id;
	}




	public void setId(String id) {
		this.id = id;
	}




	public String getTypeId() {
		return typeId;
	}




	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}




	public String getTitle() {
		return title;
	}




	public void setTitle(String title) {
		this.title = title;
	}




	public Integer getClick() {
		return click;
	}




	public void setClick(Integer click) {
		this.click = click;
	}




	public Clob getContent() {
		return content;
	}




	public void setContent(Clob content) {
		this.content = content;
	}









	public String getCreateUser() {
		return createUser;
	}




	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}






	public String getUpdateUser() {
		return updateUser;
	}




	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}




	public String getTypeName() {
		return typeName;
	}




	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}




	public String getContentStr() {
		return contentStr;
	}




	public void setContentStr(String contentStr) {
		this.contentStr = contentStr;
	}




	public String getNewArticle() {
		return newArticle;
	}




	public void setNewArticle(String newArticle) {
		this.newArticle = newArticle;
	}




	public String getLanguage() {
		return language;
	}




	public void setLanguage(String language) {
		this.language = language;
	}




	public String getKeyword() {
		return keyword;
	}




	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}




	public String getDescription() {
		return description;
	}




	public void setDescription(String description) {
		this.description = description;
	}




	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}





	public String getMdTime() {
		return mdTime;
	}





	public void setMdTime(String mdTime) {
		this.mdTime = mdTime;
	}
	
	
	
}
