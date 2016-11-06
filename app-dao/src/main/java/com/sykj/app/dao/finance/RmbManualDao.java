package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.RmbManual;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface RmbManualDao extends IBaseDao<RmbManual>{

	/**
	 * 查找人民币手工充值
	 */
	public RmbManual getRmbManual(String id);
	/**
	 * 添加人民币手工充值
	 */
	public void addRmbManual(RmbManual rmbManual);
	
	/**
	 * 获得所有人民币手工充值（分页）
	 */
	public Pager<RmbManual> findRmbManual(SystemContext syct, RmbManual rmbManual);
	
}
