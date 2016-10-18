package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserRole;
import com.sykj.common.dao.IBaseDao;

public interface UserRoleDao extends IBaseDao<UserRole>{

	/**
	 * 根据user查找所有UserRole
	 */
	public List<UserRole> findByUser(User user);
	/**
	 * 根据role查找所有UserRole
	 */
	public List<UserRole> findByRole(Role role);
	/**
	 * 根据ID查找UserRole
	 * @return
	 */
	public UserRole getUserRole(String id);
	/**
	 * 根据userID查找UserRole
	 * @return
	 */
	public UserRole getUserRoleByUserId(String userId);
	
	/**
	 * 添加UserRole
	 */
	public void addUserRole(UserRole userRole);
	
	/**
	 * 删除UserRole
	 */
	public void deleteUserRole(String id);
}
