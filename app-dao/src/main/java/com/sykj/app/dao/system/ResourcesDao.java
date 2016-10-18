package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Resources;
import com.sykj.common.dao.IBaseDao;

public interface ResourcesDao extends IBaseDao<Resources>{

	/**
	 * 根据ID查找Resources对象集合
	 */
	public List<Resources> find(String id);
	
	/**
	 * 根据SRC查找Resources对象
	 */
	public Resources getResourcesBySrc(String src);
	/**
	 * 根据SRC查找ResourcesList
	 */
	public List<Resources> getListBySrc(String src);
	
	/**
	 * 根据SRC和parameter查找Resources对象
	 */
	public Resources getResourcesBySrc(String src,String paremeter);
	
	/**
	 * 根据ID查找Resources对象
	 */
	public Resources getResources(String id);
	
	/**
	 * 添加Resources
	 */
	public void addResources(Resources resources);
	
	/**
	 * 删除Resources
	 */
	public void deleteResources(String id);
	
	/**
	 * 修改Resources
	 */
	public void updateResources(Resources resources);
}
