package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.WaitAuditrmbtDao;
import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("waitAuditrmbtDao")
public class WaitAuditrmbtDaoImpl extends BaseDao<WaitAuditrmbt> implements WaitAuditrmbtDao{

	@Override
	public WaitAuditrmbt getWaitAuditrmbt(String id) {
		return this.get("from WaitAuditrmbt t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addWaitAuditrmbt(WaitAuditrmbt waitAuditrmbt) {
		
		this.add(waitAuditrmbt);
	}
	
	@Override
	public Pager<WaitAuditrmbt> findWaitAuditrmbt(SystemContext syct, WaitAuditrmbt waitAuditrmbt) {
		StringBuffer hql = new StringBuffer("from WaitAuditrmbt t where 1=1");
		if(waitAuditrmbt !=null){// 添加查询条件
			if (waitAuditrmbt.getLoginname() != null && !waitAuditrmbt.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(waitAuditrmbt.getLoginname().trim()).append("' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

}
	
