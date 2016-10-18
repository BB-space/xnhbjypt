package com.sykj.app.service.system;

import java.util.HashSet;
import java.util.List;

import com.sykj.app.entity.system.Menu;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.MenuM;
import com.sykj.app.model.UserM;

public interface MenuService {

	/**
	 * 获得菜单树
	 * 
	 * @param id
	 * @return
	 */
	public List<EasyuiTreeNode> tree(String id);
	/**
	 * 获得后台导航栏
	 * 
	 * @param id
	 * @return
	 */
	public List<EasyuiTreeNode> backgroundTree(UserM userM,String id);
	
	/**
	 * 获得菜单列表
	 * 
	 * @param id
	 * @return
	 */
	public List<MenuM> treegrid(String id);

	/**
	 * 添加
	 * @param menu
	 * @return
	 */
	public MenuM add(MenuM menu);

	/**
	 * 删除菜单
	 * @param menu
	 */
	public void del(MenuM menu);

	/**
	 * 修改菜单
	 * @param menu
	 * @return
	 */
	public MenuM edit(MenuM menu);
	
	public HashSet<String> roleMenuIdSet(UserM user);
	
	/**
	 * 查找menu
	 */
	public List<MenuM> findAllMenus();
	
}
