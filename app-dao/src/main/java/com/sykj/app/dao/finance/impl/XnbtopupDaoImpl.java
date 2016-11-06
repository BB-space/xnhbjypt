package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.XnbtopupDao;
import com.sykj.app.entity.finance.Xnbtopup;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("xnbtopupDao")
public class XnbtopupDaoImpl extends BaseDao<Xnbtopup> implements XnbtopupDao{

	@Override
	public Xnbtopup getXnbtopup(String id) {
		return this.get("from Xnbtopup t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addXnbtopup(Xnbtopup xnbtopup) {
		
		this.add(xnbtopup);
	}
	
	@Override
	public Pager<Xnbtopup> findXnbtopup(SystemContext syct, Xnbtopup xnbtopup) {
		StringBuffer hql = new StringBuffer("from Xnbtopup t where 1=1");
		if(xnbtopup !=null){// 添加查询条件
			if (xnbtopup.getLoginname() != null && !xnbtopup.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(xnbtopup.getLoginname().trim()).append("' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

}
	
