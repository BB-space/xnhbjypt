package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserRoleDao;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserRole;
import com.sykj.common.dao.BaseDao;

@Repository("userRoleDao")
public class UserRoleDaoImpl extends BaseDao<UserRole> implements UserRoleDao{

	@Override
	public UserRole getUserRole(String id) {
		
		return this.get(UserRole.class, id);
	}

	@Override
	public void addUserRole(UserRole userRole) {
		this.add(userRole);
		
	}

	@Override
	public void deleteUserRole(String id) {
		this.delete(this.getUserRole(id));
		
	}

	@Override
	public List<UserRole> findByUser(User user) {
		
		return this.list("from UserRole t where t.user=?", user);
	}

	@Override
	public List<UserRole> findByRole(Role role) {
		return this.list("from UserRole t where t.role=?", role);
	}

	@Override
	public UserRole getUserRoleByUserId(String userId) {
		
		return this.get("from UserRole t where t.user.id='"+userId+"'");
	}

}
