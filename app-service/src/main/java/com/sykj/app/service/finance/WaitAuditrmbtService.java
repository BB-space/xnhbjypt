package com.sykj.app.service.finance;

import com.sykj.app.entity.finance.WaitAuditrmbt;


/**
 * 待审核人民币充值
 * @author lsq
 *
 */
public interface WaitAuditrmbtService {

	/**
	 * 添加待审核人民币充值
	 */
	public void addWaitAuditrmbt(WaitAuditrmbt rmb);
	
	/**
	 * 取消人民币充值
	 */
	public void cancelWaitAuditrmbtById(String id);
	
	
}
