package com.sykj.app.service.finance;

import com.sykj.app.entity.finance.WaitAuditrmbw;


/**
 * 待审核人民币充值
 * @author lsq
 *
 */
public interface WaitAuditrmbwService {

	/**
	 * 添加待审核人民币充值
	 */
	public void addWaitAuditrmbw(WaitAuditrmbw rmb);
	
	/**
	 * 取消人民币充值
	 */
	public void cancelWaitAuditrmbwById(String id);
	
	
}
