package com.sykj.app.service.system;

import java.util.List;

import com.sykj.app.entity.system.Role;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.RoleM;

public interface RoleService {

	/**
	 * 获得角色树
	 */
	public List<EasyuiTreeNode> tree(String id);

	/**
	 * 获得角色表格
	 * @param id
	 * @return
	 */
	public List<RoleM> treegrid(String id);

	/**
	 * 添加角色
	 * @param role
	 * @return
	 */
	public RoleM add(RoleM role);

	/**
	 * 删除角色
	 * @param role
	 */
	public void del(RoleM role);

	/**
	 * 修改角色
	 * @param role
	 * @return
	 */
	public RoleM edit(RoleM role);
	
	/**
	 * 根据用户类型查询用户角色
	 * @param userType
	 * @return
	 */
	public Role getUserType(String userType);
}
