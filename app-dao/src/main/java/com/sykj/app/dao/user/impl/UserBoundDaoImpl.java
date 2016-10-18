package com.sykj.app.dao.user.impl;



import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserBoundDao;
import com.sykj.app.entity.user.UserBound;
import com.sykj.common.dao.BaseDao;

@Repository("userBoundDao")
public class UserBoundDaoImpl extends BaseDao<UserBound> implements UserBoundDao{

	@Override
	public List<UserBound> getUserBound() {
		
		String hql = " from UserBound t where t.status in ('0','1')";
		return this.list(hql);
		
	}

	@Override
	public List<UserBound> getAll() {
		String hql = " from UserBound t";
		
		return this.list(hql);
	}
}
	
