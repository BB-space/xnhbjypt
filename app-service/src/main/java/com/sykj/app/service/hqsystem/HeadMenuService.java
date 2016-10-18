package com.sykj.app.service.hqsystem;

import java.util.List;

import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.HeadMenuM;

public interface HeadMenuService {

	/**
	 * 获得菜单树
	 * 
	 * @param id
	 * @return
	 */
	public List<EasyuiTreeNode> tree(String id);
	/**
	 * 获得后台导航栏
	 * 
	 * @param id
	 * @return
	 */
	public List<EasyuiTreeNode> backgroundTree(String id);
	
	/**
	 * 获得菜单列表
	 * 
	 * @param id
	 * @return
	 */
	public List<HeadMenuM> treegrid(String id);

	/**
	 * 添加
	 * @param menu
	 * @return
	 */
	public HeadMenuM add(HeadMenuM menu);

	/**
	 * 删除菜单
	 * @param menu
	 */
	public void del(HeadMenuM menu);

	/**
	 * 修改菜单
	 * @param menu
	 * @return
	 */
	public HeadMenuM edit(HeadMenuM menu);
	
	//public HashSet<String> roleMenuIdSet(StoreUser store);
}
