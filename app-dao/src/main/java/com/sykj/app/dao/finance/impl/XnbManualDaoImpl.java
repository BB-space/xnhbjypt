package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.XnbManualDao;
import com.sykj.app.entity.finance.XnbManual;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("xnbManualDao")
public class XnbManualDaoImpl extends BaseDao<XnbManual> implements XnbManualDao{

	@Override
	public XnbManual getXnbManual(String id) {
		return this.get("from XnbManual t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addXnbManual(XnbManual xnbManual) {
		
		this.add(xnbManual);
	}
	
	@Override
	public Pager<XnbManual> findXnbManual(SystemContext syct, XnbManual xnbManual) {
		StringBuffer hql = new StringBuffer("from XnbManual t where 1=1");
		if(xnbManual !=null){// 添加查询条件
			if (xnbManual.getLoginname() != null && !xnbManual.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(xnbManual.getLoginname().trim()).append("' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

}
	
