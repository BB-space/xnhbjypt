package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.RmbManualDao;
import com.sykj.app.entity.finance.RmbManual;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("rmbManualDao")
public class RmbManualDaoImpl extends BaseDao<RmbManual> implements RmbManualDao{

	@Override
	public RmbManual getRmbManual(String id) {
		return this.get("from RmbManual t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addRmbManual(RmbManual rmbManual) {
		
		this.add(rmbManual);
	}
	
	@Override
	public Pager<RmbManual> findRmbManual(SystemContext syct, RmbManual rmbManual) {
		StringBuffer hql = new StringBuffer("from RmbManual t where 1=1");
		if(rmbManual !=null){// 添加查询条件
			if (rmbManual.getLoginname() != null && !rmbManual.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(rmbManual.getLoginname().trim()).append("' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

}
	
