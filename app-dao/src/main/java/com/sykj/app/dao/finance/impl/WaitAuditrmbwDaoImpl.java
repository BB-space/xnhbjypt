package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.WaitAuditrmbwDao;
import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("waitAuditrmbwDao")
public class WaitAuditrmbwDaoImpl extends BaseDao<WaitAuditrmbw> implements WaitAuditrmbwDao{

	@Override
	public WaitAuditrmbw getWaitAuditrmbw(String id) {
		return this.get("from WaitAuditrmbw t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addWaitAuditrmbw(WaitAuditrmbw waitAuditrmbw) {
		
		this.add(waitAuditrmbw);
	}
	
	@Override
	public Pager<WaitAuditrmbw> findWaitAuditrmbw(SystemContext syct, WaitAuditrmbw waitAuditrmbw) {
		StringBuffer hql = new StringBuffer("from WaitAuditrmbw t where 1=1");
		if(waitAuditrmbw !=null){// 添加查询条件
			if (waitAuditrmbw.getLoginname() != null && !waitAuditrmbw.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(waitAuditrmbw.getLoginname().trim()).append("' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

}
	
