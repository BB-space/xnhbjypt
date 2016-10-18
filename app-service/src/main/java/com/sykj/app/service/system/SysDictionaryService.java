package com.sykj.app.service.system;

import com.sykj.app.entity.system.SysDictionary;

/**
 * 系统参数
 */
public interface SysDictionaryService {
	
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
