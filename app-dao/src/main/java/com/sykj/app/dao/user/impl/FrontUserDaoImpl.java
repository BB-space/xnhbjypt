package com.sykj.app.dao.user.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.FrontUserDao;
import com.sykj.app.entity.user.FrontUser;
import com.sykj.common.dao.BaseDao;

@Repository("frontUserDao")
public class FrontUserDaoImpl extends BaseDao<FrontUser> implements FrontUserDao{

	@Override
	public void addUser(FrontUser user) {
		this.add(user);
		
	}

	@Override
	public FrontUser getUser(String id) {
		return this.get("from FrontUser t where t.id='"+id+"'");
	}

	@Override
	public FrontUser getUserByUserName(String userName) {
		return null;
	}

	@Override
	public FrontUser getUserByNamePassword(String userName, String password) {
		return this.get("from FrontUser t where t.userName='"+userName+"' and t.password='"+password+"'");	
	}

	@Override
	public FrontUser checkUserName(String userName) {
		
		return this.get("from FrontUser t where t.userName='"+userName+"'");
	}

	@Override
	public void updatePassword(String userName, String password, String updateTime) {
		this.updateByHql("update FrontUser t set t.password = '"+password+"',t.updateTime = '"+ updateTime 
				+"' where t.userName = '"+userName+"'");
	}


}
	
