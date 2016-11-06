package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.XnbManual;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface XnbManualDao extends IBaseDao<XnbManual>{

	/**
	 * 查找虚拟币人工充值
	 */
	public XnbManual getXnbManual(String id);
	/**
	 * 添加虚拟币人工充值
	 */
	public void addXnbManual(XnbManual xnbManual);
	
	/**
	 * 获得所有虚拟币人工充值（分页）
	 */
	public Pager<XnbManual> findXnbManual(SystemContext syct, XnbManual xnbManual);
	
}
