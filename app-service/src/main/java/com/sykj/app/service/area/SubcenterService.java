package com.sykj.app.service.area;

import java.util.List;

import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.SystemContext;

public interface SubcenterService {

	/**
	 * 添加分中心
	 * @param Subcenter
	 */
	public Subcenter addSubcenter(Subcenter subcenter);
	
	/**
	 * 删除分中心
	 * @param Subcenter
	 */
	public void deleteSubcenter(String ids);
	
	/**
	 * 编辑分中心
	 */
	public Subcenter editSubcenter(Subcenter subcenter);
	
	/**
	 * 查询分中心列表
	 * @param dg
	 * @param Subcenter
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, Subcenter subcenter);
	
	/**
	 * 获得所有分中心
	 */
	public List<Subcenter> getAllSubcenter();
	
	public Subcenter getById(String id);
	
	/**
	 * 获得分中心树
	 */
	public List<EasyuiTreeNode> tree(String id);
}
