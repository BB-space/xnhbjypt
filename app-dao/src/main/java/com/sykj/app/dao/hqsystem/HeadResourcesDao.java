package com.sykj.app.dao.hqsystem;

import java.util.List;

import com.sykj.app.entity.hqsystem.HeadResources;
import com.sykj.common.dao.IBaseDao;

public interface HeadResourcesDao extends IBaseDao<HeadResources>{

	/**
	 * 根据ID查找Resources对象集合
	 */
	public List<HeadResources> find(String id);
	
	/**
	 * 根据SRC查找Resources对象
	 */
	public HeadResources getResourcesBySrc(String src);
	
	/**
	 * 根据ID查找Resources对象
	 */
	public HeadResources getResources(String id);
	
	/**
	 * 添加Resources
	 */
	public void addResources(HeadResources resources);
	
	/**
	 * 删除Resources
	 */
	public void deleteResources(String id);
	
	/**
	 * 修改Resources
	 */
	public void updateResources(HeadResources resources);
}
