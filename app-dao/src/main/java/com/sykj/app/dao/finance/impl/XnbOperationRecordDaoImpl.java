package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.XnbOperationRecordDao;
import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("xnbOperationRecordDao")
public class XnbOperationRecordDaoImpl extends BaseDao<XnbOperationRecord> implements XnbOperationRecordDao{

	@Override
	public XnbOperationRecord getXnbOperationRecord(String id) {
		return this.get("from XnbOperationRecord t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addXnbOperationRecord(XnbOperationRecord xnbOperationRecord) {
		
		this.add(xnbOperationRecord);
	}
	
	@Override
	public Pager<XnbOperationRecord> findXnbOperationRecord(SystemContext syct, XnbOperationRecord xnbOperationRecord) {
		StringBuffer hql = new StringBuffer("from XnbOperationRecord t where 1=1 ");
		if(xnbOperationRecord !=null){// 添加查询条件
			if (xnbOperationRecord.getLoginname() != null && !xnbOperationRecord.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(xnbOperationRecord.getLoginname().trim()).append("' ");
			}
			if (xnbOperationRecord.getXnbtype() != null && !xnbOperationRecord.getXnbtype().trim().equals("")) {
				hql.append(" and t.xnbtype = '").append(xnbOperationRecord.getXnbtype().trim()).append("' ");
			}
		}
		hql.append(" order by t.createdatetime desc ");
		return this.find(hql.toString(),syct);
	}
}
	
