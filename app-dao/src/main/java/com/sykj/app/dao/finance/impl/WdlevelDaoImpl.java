package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.WdlevelDao;
import com.sykj.app.entity.finance.Wdlevel;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("wdlevelDao")
public class WdlevelDaoImpl extends BaseDao<Wdlevel> implements WdlevelDao{

	@Override
	public Wdlevel getWdlevel(String id) {
		return this.get("from Wdlevel t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addWdlevel(Wdlevel wdlevel) {
		
		this.add(wdlevel);
	}
	
	@Override
	public Pager<Wdlevel> findWdlevel(SystemContext syct, Wdlevel wdlevel) {
		StringBuffer hql = new StringBuffer("from Wdlevel t where 1=1");
		if(wdlevel !=null){// 添加查询条件
			/*if (wdlevel.getLoginname() != null && !wdlevel.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(wdlevel.getLoginname().trim()).append("' ");
			}*/
		}
		return this.find(hql.toString(),syct);
	}

}
	
