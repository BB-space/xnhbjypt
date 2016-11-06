package com.sykj.app.dao.finance.impl;



import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.UserxnbDao;
import com.sykj.app.entity.finance.Userxnb;
import com.sykj.common.dao.BaseDao;

@Repository("userxnbDao")
public class UserxnbDaoImpl extends BaseDao<Userxnb> implements UserxnbDao{

	@Override
	public Userxnb getUserxnb(String id) {
		return this.get("from Userxnb t where t.userxnbId='"+id+"'");
	}

	@Override
	public List<Userxnb> getUserxnbByLoginName(String loginName) {
		return this.list("from Userxnb t where t.loginname = '"+ loginName + "'");
	}

	@Override
	public void addUserxnb(Userxnb userxnb) {
		
		this.add(userxnb);
	}
	
}
	
