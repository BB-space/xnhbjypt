package com.sykj.app.service.impl;

import java.util.UUID;

import javax.annotation.Resource;

import com.sykj.app.dao.system.RoleDao;
import com.sykj.app.dao.user.UserDao;
import com.sykj.app.dao.user.UserRoleDao;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserRole;
import com.sykj.app.service.BaseService;

public class BaseServiceImpl implements BaseService {
	
	@Resource
	private UserDao userDao;
	@Resource
	private RoleDao roleDao;
	@Resource
	private UserRoleDao userRoleDao;
	
	@Override
	public void addUserRole(User user) {
		Role role = roleDao.findByuserType(user.getUserType());
		UserRole ur = new UserRole();
		ur.setId(UUID.randomUUID().toString());
		ur.setRole(role);
		ur.setUser(user);
		userRoleDao.addUserRole(ur);
	}

}
