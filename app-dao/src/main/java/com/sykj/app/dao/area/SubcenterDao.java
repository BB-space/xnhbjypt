package com.sykj.app.dao.area;

import java.util.List;

import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface SubcenterDao extends IBaseDao<Subcenter>{

	/**
	 * 查找分中心
	 */
	public Subcenter getSubcenter(String id);
	
	/**
	 * 删除分中心
	 */
	public void deleteSubcenter(String id);
	
	
	/**
	 * 获得所有分中心（分页）
	 */
	public Pager<Subcenter> findSubcenter(SystemContext syct, Subcenter Subcenter);
	
	/**
	 * 获得所有分中心
	 */
	public List<Subcenter> getAllSubcenter();
	
	public Subcenter getById(String id);
}
