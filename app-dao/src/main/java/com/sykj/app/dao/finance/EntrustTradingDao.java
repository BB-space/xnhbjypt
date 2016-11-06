package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface EntrustTradingDao extends IBaseDao<EntrustTrading>{

	/**
	 * 查找委托交易
	 */
	public EntrustTrading getEntrustTrading(String id);
	/**
	 * 添加委托交易
	 */
	public void addEntrustTrading(EntrustTrading entrustTrading);
	
	/**
	 * 获得所有委托交易（分页）
	 */
	public Pager<EntrustTrading> findEntrustTrading(SystemContext syct, EntrustTrading entrustTrading);
	
}
