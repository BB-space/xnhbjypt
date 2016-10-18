package com.sykj.app.entity.user;

import java.util.Date;

/**
 * 会员等级表
 * @author swh
 *
 */

public class UserLevel implements java.io.Serializable{

	private Integer userLevelSeq;//用户等级排序
	private Date createDatetime;//创建时间
	private String id;
	private String level;//会员等级
	private String levelName;//等级名称
	private String privilege;//等级特权
	private String upLevelConditions;//升级条件
	private String description;//描述
	
	public UserLevel(){
		
	}

	public UserLevel(Integer userLevelSeq, Date createDatetime, String id,
			String level, String levelName, String privilege,
			String upLevelConditions, String description) {
		super();
		this.userLevelSeq = userLevelSeq;
		this.createDatetime = createDatetime;
		this.id = id;
		this.level = level;
		this.levelName = levelName;
		this.privilege = privilege;
		this.upLevelConditions = upLevelConditions;
		this.description = description;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLevelName() {
		return levelName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	public Integer getUserLevelSeq() {
		return userLevelSeq;
	}

	public void setUserLevelSeq(Integer userLevelSeq) {
		this.userLevelSeq = userLevelSeq;
	}

	public Date getCreateDatetime() {
		return createDatetime;
	}

	public void setCreateDatetime(Date createDatetime) {
		this.createDatetime = createDatetime;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getPrivilege() {
		return privilege;
	}

	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

	public String getUpLevelConditions() {
		return upLevelConditions;
	}

	public void setUpLevelConditions(String upLevelConditions) {
		this.upLevelConditions = upLevelConditions;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
	
}
