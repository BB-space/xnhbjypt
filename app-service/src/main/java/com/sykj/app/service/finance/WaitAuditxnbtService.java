package com.sykj.app.service.finance;

import com.sykj.app.entity.finance.WaitAuditxnbt;


/**
 * 待审核提现虚拟币
 * @author lsq
 *
 */
public interface WaitAuditxnbtService {

	/**
	 * 添加待审核提现虚拟币
	 */
	public void addWaitAuditxnbt(WaitAuditxnbt xnb);
	
	/**
	 * 取消提现虚拟币
	 */
	public void cancelWaitAuditxnbtById(String id);
	
	
}
