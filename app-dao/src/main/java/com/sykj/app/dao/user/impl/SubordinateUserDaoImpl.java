package com.sykj.app.dao.user.impl;



import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.SubordinateUserDao;
import com.sykj.app.entity.user.SubordinateUser;
import com.sykj.common.dao.BaseDao;

@Repository("subordinateUserDao")
public class SubordinateUserDaoImpl extends BaseDao<SubordinateUser> implements
		SubordinateUserDao {

	//根据openID查询所属用户信息
	@Override
	public SubordinateUser getOpenId(String openId) {
		String hql="from SubordinateUser t where t.openId='"+openId+"'";
		return this.get(hql);
	}

	//添加所属用户信息
	@Override
	public void addSubordinateUser(SubordinateUser s) {
		this.add(s);
	}

	@Override
	public List<SubordinateUser> getSubordinateUserByUserId(String userId) {
		String hql="from SubordinateUser t where t.userId='"+userId+"'";
		return this.list(hql);
	}
	
}
