package com.sykj.app.dao.system.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.MenuDao;
import com.sykj.app.entity.system.Menu;
import com.sykj.common.dao.BaseDao;

@Repository("menuDao")
public class MenuDaoImpl  extends BaseDao<Menu> implements MenuDao{

	@Override
	public List<Menu> find(String id) {
		String hql = "from Menu t where t.menu is null order by t.seq";
		if (id != null && !id.trim().equals("")) {
			hql = "from Menu t where t.menu.id ='" + id + "' order by t.seq";
		}
		return this.list(hql);
	}

	@Override
	public Menu getMenu(String id) {
		
		return this.get(Menu.class, id);
	}

	@Override
	public void addMenu(Menu menu) {
		this.add(menu);
		
	}

	@Override
	public void deleteMenu(String id) {
		this.delete(this.getMenu(id));
		
	}

	@Override
	public void updateMenu(Menu menu) {
		this.update(menu);
		
	}

	@Override
	public List<Menu> findByShowStatus(String id) {
		String hql = "from Menu t where t.menu is null and t.showStatus='0' order by t.seq";
		if (id != null && !id.trim().equals("")) {
			hql = "from Menu t where t.menu.id ='" + id + "' and t.showStatus='0' order by t.seq";
		}
		return this.list(hql);
	}

	@Override
	public List<Menu> findByUserMenus(String userId) {
		String sql="SELECT t.id,t.pid,t.text,t.seq,t.src,t.iconcls,t.descript,t.onoff,t.showstatus FROM sykj_system_menu t ,sykj_system_rolermenu t2 , sykj_system_role t3 , sykj_user_userrole t4"
				+ "	WHERE t.id = t2.menu_id AND  t2.role_id = t3.id AND  t3.id=t4.role_id AND"
				+ " t4.user_id='"+userId+"'";
		List<Object> list = this.findSQL(sql);
		List<Menu> menuList = new ArrayList<Menu>();
		if(list!=null&&list.size()>0){
			for(Object o:list){
				Object[] obj = (Object[]) o;
				Menu menu = new Menu();
				menu.setId(obj[0].toString());
				if(obj[1]!=null){
					menu.setMenu(this.get(Menu.class,obj[1].toString()));
				}
				if(obj[2]!=null){
					menu.setText(obj[2].toString());
				}
				if(obj[3]!=null){
					menu.setSeq( new BigDecimal(obj[3].toString()));
				}
				if(obj[4]!=null){
					menu.setSrc( obj[4].toString());
				}
				if(obj[5]!=null){
					menu.setIconcls(obj[5].toString());
				}
				if(obj[6]!=null){
					menu.setDescript(obj[6].toString());
				}
				if(obj[7]!=null){
					menu.setOnoff(obj[7].toString());
				}
				if(obj[8]!=null){
					menu.setShowStatus(obj[8].toString());
				}
				menuList.add(menu);
			}
		}
		return menuList;
	}

	@Override
	public List<Menu> findAllMenus() {
		String hql = " from Menu t where t.showStatus=0 and t.src is NOT NULL and t.src != ''";
		return this.list(hql);
	}
}
