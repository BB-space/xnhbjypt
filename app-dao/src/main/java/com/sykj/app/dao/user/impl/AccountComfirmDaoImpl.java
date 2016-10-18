package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.AccountComfirmDao;
import com.sykj.app.entity.user.AccountComfirm;
import com.sykj.common.dao.BaseDao;

@Repository("accountComfirmDao")
public class AccountComfirmDaoImpl extends BaseDao<AccountComfirm> implements AccountComfirmDao{

	@Override
	public List<AccountComfirm> getMonth(String shopId, String userId, int month) {
		String hql = "from AccountComfirm where 1=1 and month="+month+" ";
		if(shopId != null){
			hql += "and shopId='"+shopId+"'";
		}
		if(userId != null){
			hql += "and userId='"+userId+"'";
		}
		return this.list(hql);
	}

}
