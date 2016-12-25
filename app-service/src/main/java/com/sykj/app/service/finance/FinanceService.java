package com.sykj.app.service.finance;

import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.finance.PersonFinance;


/**
 * 
 * @author lsq
 *
 */
public interface FinanceService {

	/**
	 * 获取个人财务
	 */
	public PersonFinance getPersonFinance(String loginName);
	
	/**
	 * 添加虚拟币操作记录
	 */
	public void addXnbOperationRecord(XnbOperationRecord xnbOperationRecord);
	
	/**
	 * 获得所有虚拟币操作记录（分页）
	 */
	public Pager<XnbOperationRecord> findXnbOperationRecord(SystemContext syct, XnbOperationRecord xnbOperationRecord);
	
	/**
	 * 新增人民币提现
	 */
	public void addWithdrawCny(WaitAuditrmbw waitAuditrmbw);
	/**
	 * 新增人民币充值
	 */
	public void addWaitAuditrmbt(WaitAuditrmbt waitAuditrmbt);

	/**
	 * 获得所有人民币操作记录（分页）
	 */
	public Pager<RmbOperationRecord> findRmbOperationRecord(SystemContext syct, RmbOperationRecord rmbOperationRecord);
	
	/**
	 * 获得所有委托交易列表（分页）
	 */
	public Pager<EntrustTrading> findEntrustTrading(SystemContext syct, EntrustTrading entrustTrading);
	
	
	/**
	 * 买入虚拟币
	 */
	public void buyXnb(EntrustTrading entrustTrading);
	
	/**
	 * 卖出虚拟币
	 */
	public void sellXnb(EntrustTrading entrustTrading);
}
