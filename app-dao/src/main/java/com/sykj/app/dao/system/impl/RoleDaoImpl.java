package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.RoleDao;
import com.sykj.app.entity.system.Role;
import com.sykj.common.dao.BaseDao;

@Repository("roleDao")
public class RoleDaoImpl  extends BaseDao<Role> implements RoleDao{

	@Override
	public List<Role> findRole(String id) {
		String hql = "from Role t where t.role is null order by t.seq";
		if (id != null && !id.trim().equals("")) {
			hql = "from Role t where t.role.id ='" + id + "' order by t.seq";
		}
		return this.list(hql);
	}

	@Override
	public Role getRole(String id) {
		
		return this.get(Role.class, id);
	}

	@Override
	public void addRole(Role role) {
		this.add(role);
		
	}

	@Override
	public void deleteRole(String id) {
		this.delete(this.getRole(id));
		
	}

	@Override
	public void updateRole(Role role) {
		this.update(role);
		
	}

	@Override
	public Role findByuserType(String userType) {
		
		return this.get("from Role r where r.userType='"+userType+"'");
	}

}
