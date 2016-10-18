package com.sykj.app.entity.hqsystem;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * 资源
 * @author swh
 *
 */
public class HeadResources implements java.io.Serializable  {

	private String id;//主键
	private HeadResources resources;//父ID
	private String text;//资源名
	private BigDecimal seq;//排序
	private String src;//连接地址
	private String descript;//描述
	private String onoff;//是否验证：1开启验证，0不开启验证
	private Set roleResourceses = new HashSet(0);//角色资源集合
	private Set resourceses = new HashSet(0);//父ID
	
	public HeadResources(){
		
	}
	
	public HeadResources(String id, HeadResources resources, String text,
			BigDecimal seq, String src, String descript, String onoff,
			Set roleResourceses, Set resourceses) {
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
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public HeadResources getResources() {
		return resources;
	}

	public void setResources(HeadResources resources) {
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
	
	
}
