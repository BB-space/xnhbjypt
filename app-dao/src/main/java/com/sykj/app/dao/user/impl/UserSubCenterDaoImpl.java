package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserSubCenterDao;
import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.common.dao.BaseDao;

/**
 * @author wjl 2016年9月22日 下午4:53:33
 */
@Repository("userSubCenterDao")
public class UserSubCenterDaoImpl extends BaseDao<UserSubCenter> implements UserSubCenterDao{

	@Override
	public void addUserSubCenter(UserSubCenter userSubCenter) {
		this.add(userSubCenter);
	}

	@Override
	public void editUserSubCenter(UserSubCenter userSubCenter) {
		this.update(userSubCenter);
	}

	@Override
	public void delUserSubCenter(UserSubCenter userSubCenter) {
		this.delete(userSubCenter);
	}

	@Override
	public List<UserSubCenter> getByUserId(String userId) {
		String hql = "from UserSubCenter t where t.userId = '"+userId+"'";
		return this.list(hql);
	}

}
