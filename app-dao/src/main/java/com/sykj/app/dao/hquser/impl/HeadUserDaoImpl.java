package com.sykj.app.dao.hquser.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.hquser.HeadUserDao;
import com.sykj.app.entity.hquser.HeadUser;
import com.sykj.common.dao.BaseDao;

@Repository("headUserDao")
public class HeadUserDaoImpl extends BaseDao<HeadUser> implements HeadUserDao {

	//根据用户名查询用户
	@Override
	public HeadUser findByName(String name) {
		String hql="from HeadUser t where t.name='"+name+"'";
		return this.get(hql);
	}

}
