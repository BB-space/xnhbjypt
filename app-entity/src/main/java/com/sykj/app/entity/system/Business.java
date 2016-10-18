package com.sykj.app.entity.system;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * 职务
 * @author wjl 2016年10月12日 上午9:32:07
 */
public class Business implements java.io.Serializable {

	private String id;
	private Business business;//父ID
	private String text;//职务名字
	private BigDecimal seq;//排序
	private String descript;//描述
	private Set userBusiness = new HashSet(0);//用户职务集合
	private Set businesses = new HashSet(0);//父ID
	private Set businessResourceses = new HashSet(0);//职务资源集合
	private Set businessMenus = new HashSet(0);//职务菜单集合
	
	public Business(){
		
	}
	
	public Business(String id, Business business, String text, BigDecimal seq,
			String descript, Set userBusiness, Set businesses, Set businessResourceses,
			Set businessMenus) {
		super();
		this.id = id;
		this.business = business;
		this.text = text;
		this.seq = seq;
		this.descript = descript;
		this.userBusiness = userBusiness;
		this.businesses = businesses;
		this.businessResourceses = businessResourceses;
		this.businessMenus = businessMenus;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Business getBusiness() {
		return business;
	}

	public void setBusiness(Business business) {
		this.business = business;
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

	public Set getUserBusiness() {
		return userBusiness;
	}

	public void setUserBusiness(Set userBusiness) {
		this.userBusiness = userBusiness;
	}

	public Set getBusinesses() {
		return businesses;
	}

	public void setBusinesses(Set businesses) {
		this.businesses = businesses;
	}

	public Set getBusinessResourceses() {
		return businessResourceses;
	}

	public void setBusinessResourceses(Set businessResourceses) {
		this.businessResourceses = businessResourceses;
	}

	public Set getBusinessMenus() {
		return businessMenus;
	}

	public void setBusinessMenus(Set businessMenus) {
		this.businessMenus = businessMenus;
	}
	
}
