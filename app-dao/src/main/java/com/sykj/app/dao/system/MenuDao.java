package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Menu;
import com.sykj.common.dao.IBaseDao;

public interface MenuDao extends IBaseDao<Menu>{

	/**
	 * 根据ID查找Menu对象集合
	 */
	public List<Menu> find(String id);
	
	/**
	 * 根据ID查找前后台Menu对象集合
	 */
	public List<Menu> findByShowStatus(String id);
	
	/**
	 * 查找用户menu
	 */
	public List<Menu> findByUserMenus(String userId);
	/**
	 * 根据ID查找Menu对象
	 */
	public Menu getMenu(String id);
	
	/**
	 * 添加Menu
	 */
	public void addMenu(Menu menu);
	
	/**
	 * 删除Menu
	 */
	public void deleteMenu(String id);
	
	/**
	 * 修改Menu
	 */
	public void updateMenu(Menu menu);
	
	/**
	 * 查找menu
	 */
	public List<Menu> findAllMenus();
	
}
