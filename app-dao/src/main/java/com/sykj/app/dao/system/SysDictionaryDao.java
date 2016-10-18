package com.sykj.app.dao.system;

import com.sykj.app.entity.system.SysDictionary;
import com.sykj.common.dao.IBaseDao;

/**
 * 系统参数 
 */
public interface SysDictionaryDao extends IBaseDao<SysDictionary>{
	
	/**
	 * 添加
	 * @param t
	 */
	public void addSysDictionary(SysDictionary t);
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public SysDictionary getSysDictionary(String id);
}
