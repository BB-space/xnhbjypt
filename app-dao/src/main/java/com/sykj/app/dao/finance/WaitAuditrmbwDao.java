package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface WaitAuditrmbwDao extends IBaseDao<WaitAuditrmbw>{

	/**
	 * 查找待审核人民币充值
	 */
	public WaitAuditrmbw getWaitAuditrmbw(String id);
	/**
	 * 添加待审核人民币充值
	 */
	public void addWaitAuditrmbw(WaitAuditrmbw waitAuditrmbw);
	
	/**
	 * 获得所有待审核人民币充值（分页）
	 */
	public Pager<WaitAuditrmbw> findWaitAuditrmbw(SystemContext syct, WaitAuditrmbw waitAuditrmbw);
	
}
