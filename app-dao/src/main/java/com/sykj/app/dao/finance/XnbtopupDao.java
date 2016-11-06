package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.Xnbtopup;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface XnbtopupDao extends IBaseDao<Xnbtopup>{

	/**
	 * 查找虚拟币充值
	 */
	public Xnbtopup getXnbtopup(String id);
	/**
	 * 添加虚拟币充值
	 */
	public void addXnbtopup(Xnbtopup xnbtopup);
	
	/**
	 * 获得所有虚拟币充值（分页）
	 */
	public Pager<Xnbtopup> findXnbtopup(SystemContext syct, Xnbtopup xnbtopup);
	
}
