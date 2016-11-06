package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.WaitAuditxnbt;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface WaitAuditxnbtDao extends IBaseDao<WaitAuditxnbt>{

	/**
	 * 查找待审核虚拟币提现
	 */
	public WaitAuditxnbt getWaitAuditxnbt(String id);
	/**
	 * 添加待审核虚拟币提现
	 */
	public void addWaitAuditxnbt(WaitAuditxnbt waitAuditxnbt);
	
	/**
	 * 获得所有待审核虚拟币提现（分页）
	 */
	public Pager<WaitAuditxnbt> findWaitAuditxnbt(SystemContext syct, WaitAuditxnbt waitAuditxnbt);
	
}
