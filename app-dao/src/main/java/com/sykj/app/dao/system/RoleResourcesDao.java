package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Resources;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleResources;
import com.sykj.common.dao.IBaseDao;

public interface RoleResourcesDao extends IBaseDao<RoleResources>{

	/**
	 * 获得RoleResources对象
	 */
	public RoleResources getRoleResources(String id);
	
	/**
	 * 根据roleId和src获得RoleResources对象
	 */
	public RoleResources getRoleResourcesByRS(String roleId,String src);
	
	/**
	 * 添加RoleResources
	 */
	public void addRoleResources(RoleResources roleResources);
	
	/**
	 * 查找RoleResources
	 */
	public List<RoleResources> findRoleResources(Resources resources);
	
	/**
	 * 查找RoleResources
	 */
	public List<RoleResources> findRoleResources(Role role);
	
	/**
	 * 删除RoleResources
	 */
	public void deleteRoleResources(String id);
}
