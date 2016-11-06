package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.Wdlevel;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface WdlevelDao extends IBaseDao<Wdlevel>{

	/**
	 * 查找人民币提现手续费
	 */
	public Wdlevel getWdlevel(String id);
	/**
	 * 添加人民币提现手续费
	 */
	public void addWdlevel(Wdlevel Wdlevel);
	
	/**
	 * 获得所有人民币提现手续费（分页）
	 */
	public Pager<Wdlevel> findWdlevel(SystemContext syct, Wdlevel Wdlevel);
	
}
