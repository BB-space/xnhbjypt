package com.sykj.app.entity.hqsystem;


import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * 菜单
 * @author swh
 *
 */
public class HeadMenu  implements java.io.Serializable {

	private String id;//主键
	private HeadMenu menu;//父Id
	private String text;//菜单名
	private String iconcls;//图片
	private String descript;//描述
	private String src;//连接
	private BigDecimal seq;//排序
	private String onoff;//是否验证：1开启验证，0不开启验证
	private String showStatus;//前后台显示按钮（0：后台，1前台）
	private Set menus = new HashSet(0);//菜单集合
	
	public HeadMenu(){
		
	}
	

	public HeadMenu(String id, HeadMenu menu, String text, String iconcls, String src,
			BigDecimal seq, Set menus) {
		super();
		this.id = id;
		this.menu = menu;
		this.text = text;
		this.iconcls = iconcls;
		this.src = src;
		this.seq = seq;
		this.menus = menus;
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

	public HeadMenu getMenu() {
		return menu;
	}

	public void setMenu(HeadMenu menu) {
		this.menu = menu;
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
	
	
}
