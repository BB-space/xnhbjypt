package com.sykj.app.dao.user.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UnboundUserDao;
import com.sykj.app.entity.user.UnboundUser;
import com.sykj.common.dao.BaseDao;

@Repository("unboundUserDao")
public class UnboundUserDaoImpl extends BaseDao<UnboundUser> implements UnboundUserDao{

	@Override
	public void addUnboundUser(UnboundUser unboundUser) {
		// TODO Auto-generated method stub
		this.add(unboundUser);
	}

}
