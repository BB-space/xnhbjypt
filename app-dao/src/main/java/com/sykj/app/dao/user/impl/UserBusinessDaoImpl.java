package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserBusinessDao;
import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserBusiness;
import com.sykj.app.entity.user.UserRole;
import com.sykj.common.dao.BaseDao;

/**
 * @author wjl 2016年10月12日 下午2:49:41
 */
@Repository("userBusinessDao")
public class UserBusinessDaoImpl extends BaseDao<UserBusiness> implements UserBusinessDao{

	@Override
	public List<UserBusiness> findByBusiness(Business business) {
		return this.list("from UserBusiness t where t.business=?", business);
	}

	@Override
	public void deleteUserBusiness(String id) {
		this.delete(this.getUserBusiness(id));
	}

	@Override
	public UserBusiness getUserBusiness(String id) {
		return this.get(UserBusiness.class, id);
	}

	@Override
	public List<UserBusiness> findByUser(User user) {
		return this.list("from UserBusiness t where t.user=?", user);
	}

	@Override
	public void addUserBusiness(UserBusiness userBusiness) {
		this.add(userBusiness);
	}

	@Override
	public UserBusiness getUserBusinessByUserId(String userId) {
		return this.get("from UserBusiness t where t.user.id='"+userId+"'");
	}

}
