package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.EntrustTradingDao;
import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("entrustTradingDao")
public class EntrustTradingDaoImpl extends BaseDao<EntrustTrading> implements EntrustTradingDao{

	@Override
	public EntrustTrading getEntrustTrading(String id) {
		return this.get("from EntrustTrading t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addEntrustTrading(EntrustTrading entrustTrading) {
		
		this.add(entrustTrading);
	}
	
	@Override
	public Pager<EntrustTrading> findEntrustTrading(SystemContext syct, EntrustTrading entrustTrading) {
		StringBuffer hql = new StringBuffer("from EntrustTrading t where 1=1");
		if(entrustTrading !=null){// 添加查询条件
			if (entrustTrading.getLoginname() != null && !entrustTrading.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(entrustTrading.getLoginname().trim()).append("' ");
			}
			if (entrustTrading.getXnbtype() != null && !entrustTrading.getXnbtype().trim().equals("")) {
				hql.append(" and t.xnbtype = '").append(entrustTrading.getXnbtype().trim()).append("' ");
			}
		}
		hql.append(" order by t.createdatetime desc");
		return this.find(hql.toString(),syct);
	}

}
	
