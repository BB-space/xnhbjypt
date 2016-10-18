package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.RoleResourcesDao;
import com.sykj.app.entity.system.Resources;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleResources;
import com.sykj.common.dao.BaseDao;

@Repository("roleResourcesDao")
public class RoleResourcesDaoImpl extends BaseDao<RoleResources> implements RoleResourcesDao{

	/**
	 * 添加RoleResources
	 */
	public void addRoleResources(RoleResources roleResources){
		this.add(roleResources);
	}

	@Override
	public List<RoleResources> findRoleResources(Resources resources) {
		
		return this.list("from RoleResources t where t.resources=?", resources);
	}

	@Override
	public void deleteRoleResources(String id) {
		this.delete(this.getRoleResources(id));
		
	}

	@Override
	public RoleResources getRoleResources(String id) {
		return this.get(RoleResources.class, id);
	}

	@Override
	public List<RoleResources> findRoleResources(Role role) {
		
		return this.list("from RoleResources t where t.role=?", role);
	}

	@Override
	public RoleResources getRoleResourcesByRS(String roleId,String src) {
		
		return this.get("from RoleResources t where t.role.id='"+roleId+"' and t.resources.src='"+src+"'");
	}
}
