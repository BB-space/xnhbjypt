package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface RmbOperationRecordDao extends IBaseDao<RmbOperationRecord>{

	/**
	 * 查找人民币操作记录
	 */
	public RmbOperationRecord getRmbOperationRecord(String id);
	/**
	 * 添加人民币操作记录
	 */
	public void addRmbOperationRecord(RmbOperationRecord rmbOperationRecord);
	
	/**
	 * 获得所有人民币操作记录（分页）
	 */
	public Pager<RmbOperationRecord> findRmbOperationRecord(SystemContext syct, RmbOperationRecord rmbOperationRecord);
	
}
