package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.WaitAuditxnbtDao;
import com.sykj.app.entity.finance.WaitAuditxnbt;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("waitAuditxnbtDao")
public class WaitAuditxnbtDaoImpl extends BaseDao<WaitAuditxnbt> implements WaitAuditxnbtDao{

	@Override
	public WaitAuditxnbt getWaitAuditxnbt(String id) {
		return this.get("from WaitAuditxnbt t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addWaitAuditxnbt(WaitAuditxnbt waitAuditxnbt) {
		
		this.add(waitAuditxnbt);
	}
	
	@Override
	public Pager<WaitAuditxnbt> findWaitAuditxnbt(SystemContext syct, WaitAuditxnbt waitAuditxnbt) {
		StringBuffer hql = new StringBuffer("from WaitAuditxnbt t where 1=1");
		if(waitAuditxnbt !=null){// 添加查询条件
			if (waitAuditxnbt.getLoginname() != null && !waitAuditxnbt.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(waitAuditxnbt.getLoginname().trim()).append("' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

}
	
