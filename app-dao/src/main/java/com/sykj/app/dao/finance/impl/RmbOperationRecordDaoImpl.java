package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.RmbOperationRecordDao;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("rmbOperationRecordDao")
public class RmbOperationRecordDaoImpl extends BaseDao<RmbOperationRecord> implements RmbOperationRecordDao{

	@Override
	public RmbOperationRecord getRmbOperationRecord(String id) {
		return this.get("from RmbOperationRecord t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addRmbOperationRecord(RmbOperationRecord rmbOperationRecord) {
		
		this.add(rmbOperationRecord);
	}
	
	@Override
	public Pager<RmbOperationRecord> findRmbOperationRecord(SystemContext syct, RmbOperationRecord rmbOperationRecord) {
		StringBuffer hql = new StringBuffer("from RmbOperationRecord t where 1=1");
		if(rmbOperationRecord !=null){// 添加查询条件
			if (rmbOperationRecord.getLoginname() != null && !rmbOperationRecord.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(rmbOperationRecord.getLoginname().trim()).append("' ");
			}
			if (rmbOperationRecord.getTradingtype() != null && !rmbOperationRecord.getTradingtype().trim().equals("")) {
				hql.append(" and t.tradingtype = '").append(rmbOperationRecord.getTradingtype().trim()).append("' ");
			}
		}
		hql.append("order by t.createdatetime desc");
		return this.find(hql.toString(),syct);
	}

}
	
