package com.sykj.app.entity.news;


public class ArticleType implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String id;
	private String description;
	private String createDateTime;
	private String createUser;
	private String updateDateTime;
	private String updateUser;
	private Integer seq;
	private String typename;
	private String language;
	private String keyword;
	private String typenumber;
	private String pid;
	
	public ArticleType(){
		
	}
	
	

	public ArticleType(String id, String description, String createDateTime, String createUser, String updateDateTime,
			String updateUser, Integer seq, String typename, String language, String keyword, String typenumber,
			String pid) {
		super();
		this.id = id;
		this.description = description;
		this.createDateTime = createDateTime;
		this.createUser = createUser;
		this.updateDateTime = updateDateTime;
		this.updateUser = updateUser;
		this.seq = seq;
		this.typename = typename;
		this.language = language;
		this.keyword = keyword;
		this.typenumber = typenumber;
		this.pid = pid;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
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

	public String getTypenumber() {
		return typenumber;
	}

	public void setTypenumber(String typenumber) {
		this.typenumber = typenumber;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
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
	
	
}
