package com.sykj.app.entity.system;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * 资源
 * @author swh
 *
 */
public class Resources implements java.io.Serializable  {

	private String id;//主键
	private Resources resources;//父ID
	private String text;//资源名
	private BigDecimal seq;//排序
	private String src;//连接地址
	private String parameter;//连接参数
	private String descript;//描述
	private String jsp;//所跳转页面
	private String onoff;//是否验证：1开启验证，0不开启验证
	private Set roleResourceses = new HashSet(0);//角色资源集合
	private Set resourceses = new HashSet(0);//父ID
	private Set businessResourceses = new HashSet(0);//职务资源集合
	
	public Resources(){
		
	}
	
	public Resources(String id, Resources resources, String text,
			BigDecimal seq, String src, String descript, String onoff,
			Set roleResourceses, Set resourceses,Set businessResourceses) {
		super();
		this.id = id;
		this.resources = resources;
		this.text = text;
		this.seq = seq;
		this.src = src;
		this.descript = descript;
		this.onoff = onoff;
		this.roleResourceses = roleResourceses;
		this.resourceses = resourceses;
		this.businessResourceses = businessResourceses;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Resources getResources() {
		return resources;
	}

	public void setResources(Resources resources) {
		this.resources = resources;
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

	public Set getRoleResourceses() {
		return roleResourceses;
	}

	public void setRoleResourceses(Set roleResourceses) {
		this.roleResourceses = roleResourceses;
	}

	public Set getResourceses() {
		return resourceses;
	}

	public void setResourceses(Set resourceses) {
		this.resourceses = resourceses;
	}

	public String getJsp() {
		return jsp;
	}

	public void setJsp(String jsp) {
		this.jsp = jsp;
	}

	public String getParameter() {
		return parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public Set getBusinessResourceses() {
		return businessResourceses;
	}

	public void setBusinessResourceses(Set businessResourceses) {
		this.businessResourceses = businessResourceses;
	}
	
	
}
