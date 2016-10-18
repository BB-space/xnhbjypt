package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.RoleMenuDao;
import com.sykj.app.entity.system.Menu;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleMenu;
import com.sykj.common.dao.BaseDao;

@Repository("roleMenuDao")
public class RoleMenusDaoImpl  extends BaseDao<RoleMenu> implements RoleMenuDao{

	@Override
	public RoleMenu getRoleMenu(String id) {
		
		return this.get(RoleMenu.class, id);
	}

	@Override
	public void addRoleMenu(RoleMenu roleMenu) {
		this.add(roleMenu);
		
	}

	@Override
	public List<RoleMenu> findRoleMenu(Menu menu) {
		
		return this.list("from RoleMenu t where t.menu=?", menu);
	}

	@Override
	public List<RoleMenu> findRoleMenu(Role role) {
		
		return this.list("from RoleMenu t where t.role=?", role);
	}

	@Override
	public void deleteRoleMenu(String id) {
		this.delete(this.getRoleMenu(id));
		
	}

}
