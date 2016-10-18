package com.sykj.app.entity.system;


import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * 菜单
 * @author swh
 *
 */
public class Menu  implements java.io.Serializable {

	private String id;//主键
	private Menu menu;//父Id
	private String text;//菜单名
	private String iconcls;//图片
	private String descript;//描述
	private String src;//连接
	private BigDecimal seq;//排序
	private String onoff;//是否验证：1开启验证，0不开启验证
	private String showStatus;//前后台显示按钮（0：后台，1前台）
	private Set menus = new HashSet(0);//菜单集合
	private Set roleMenus = new HashSet(0);//
	private Set businessMenus = new HashSet(0);//职务菜单集合
	
	public Menu(){
		
	}
	

	public Menu(String id, Menu menu, String text, String iconcls, String src,
			BigDecimal seq, Set menus, Set roleMenus,Set businessMenus) {
		super();
		this.id = id;
		this.menu = menu;
		this.text = text;
		this.iconcls = iconcls;
		this.src = src;
		this.seq = seq;
		this.menus = menus;
		this.roleMenus = roleMenus;
		this.businessMenus = businessMenus;
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

	public String getIconcls() {
		return iconcls;
	}

	public void setIconcls(String iconcls) {
		this.iconcls = iconcls;
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

	public Set getMenus() {
		return menus;
	}

	public void setMenus(Set menus) {
		this.menus = menus;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}


	public Set getRoleMenus() {
		return roleMenus;
	}


	public void setRoleMenus(Set roleMenus) {
		this.roleMenus = roleMenus;
	}


	public String getOnoff() {
		return onoff;
	}


	public void setOnoff(String onoff) {
		this.onoff = onoff;
	}


	public String getDescript() {
		return descript;
	}


	public void setDescript(String descript) {
		this.descript = descript;
	}


	public String getShowStatus() {
		return showStatus;
	}


	public void setShowStatus(String showStatus) {
		this.showStatus = showStatus;
	}


	public Set getBusinessMenus() {
		return businessMenus;
	}


	public void setBusinessMenus(Set businessMenus) {
		this.businessMenus = businessMenus;
	}
	
	
}
