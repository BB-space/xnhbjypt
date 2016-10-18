package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Role;
import com.sykj.common.dao.IBaseDao;

public interface RoleDao extends IBaseDao<Role>{

	/**
	 * 根据ID查找所有角色
	 * @return
	 */
	public List<Role> findRole(String id);
	
	/**
	 * 根据用户类型查找角色
	 */
	public Role findByuserType(String userType);
	
	/**
	 * 根据ID查找角色
	 * @return
	 */
	public Role getRole(String id);
	
	/**
	 * 添加角色
	 */
	public void addRole(Role role);
	
	/**
	 * 删除角色
	 */
	public void deleteRole(String id);
	
	/**
	 * 修改角色
	 */
	public void updateRole(Role role);
}
