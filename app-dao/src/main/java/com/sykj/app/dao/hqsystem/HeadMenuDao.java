package com.sykj.app.dao.hqsystem;

import java.util.List;

import com.sykj.app.entity.hqsystem.HeadMenu;
import com.sykj.common.dao.IBaseDao;

public interface HeadMenuDao extends IBaseDao<HeadMenu>{

	/**
	 * 根据ID查找Menu对象集合
	 */
	public List<HeadMenu> find(String id);
	
	/**
	 * 根据ID查找前后台Menu对象集合
	 */
	public List<HeadMenu> findByShowStatus(String id);
	
//	/**
//	 * 查找用户menu
//	 */
//	public List<Menu> findByUserMenus(String userId);
	/**
	 * 根据ID查找Menu对象
	 */
	public HeadMenu getMenu(String id);
	
	/**
	 * 添加Menu
	 */
	public void addMenu(HeadMenu menu);
	
	/**
	 * 删除Menu
	 */
	public void deleteMenu(String id);
	
	/**
	 * 修改Menu
	 */
	public void updateMenu(HeadMenu menu);
}
