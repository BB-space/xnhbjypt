package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Menu;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleMenu;
import com.sykj.common.dao.IBaseDao;

public interface RoleMenuDao extends IBaseDao<RoleMenu>{

	/**
	 * 获得RoleMenu对象
	 */
	public RoleMenu getRoleMenu(String id);
	/**
	 * 添加RoleMenu
	 */
	public void addRoleMenu(RoleMenu roleMenu);
	
	/**
	 * 查找RoleMenu
	 */
	public List<RoleMenu> findRoleMenu(Menu Menu);
	
	/**
	 * 查找RoleMenu
	 */
	public List<RoleMenu> findRoleMenu(Role role);
	
	/**
	 * 删除RoleMenu
	 */
	public void deleteRoleMenu(String id);
}
