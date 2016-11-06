package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface XnbOperationRecordDao extends IBaseDao<XnbOperationRecord>{

	/**
	 * 查找虚拟币操作记录
	 */
	public XnbOperationRecord getXnbOperationRecord(String id);
	
	/**
	 * 添加虚拟币操作记录
	 */
	public void addXnbOperationRecord(XnbOperationRecord xnbOperationRecord);
	
	/**
	 * 获得所有虚拟币操作记录（分页）
	 */
	public Pager<XnbOperationRecord> findXnbOperationRecord(SystemContext syct, XnbOperationRecord xnbOperationRecord);
	
}
