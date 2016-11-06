package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface WaitAuditrmbtDao extends IBaseDao<WaitAuditrmbt>{

	/**
	 * 查找待审核人民币提现
	 */
	public WaitAuditrmbt getWaitAuditrmbt(String id);
	/**
	 * 添加待审核人民币提现
	 */
	public void addWaitAuditrmbt(WaitAuditrmbt waitAuditrmbt);
	
	/**
	 * 获得所有待审核人民币提现（分页）
	 */
	public Pager<WaitAuditrmbt> findWaitAuditrmbt(SystemContext syct, WaitAuditrmbt waitAuditrmbt);
	
}
