package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.MemberMoneyDao;
import com.sykj.app.entity.finance.MemberMoney;
import com.sykj.common.dao.BaseDao;

@Repository("memberMoneyDao")
public class MemberMoneyDaoImpl extends BaseDao<MemberMoney> implements MemberMoneyDao{

	@Override
	public MemberMoney getMemberMoney(String id) {
		return this.get("from MemberMoney t where t.membermomeyId='"+id+"'");
	}

	@Override
	public MemberMoney getMemberMoneyByLoginName(String loginName) {
		return this.get("from MemberMoney t where t.loginname='"+loginName+"'");
	}

	@Override
	public void addMemberMoney(MemberMoney memberMoney) {
		
		this.add(memberMoney);
	}
	
}
	
