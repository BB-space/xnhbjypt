package com.sykj.app.service.hqsystem;

import java.util.List;

import com.sykj.app.entity.hqsystem.HeadResources;

import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.HeadResourcesM;
import com.sykj.app.model.ShopResourcesM;

public interface HeadResourcesService {

	/**
	 * 资源树
	 * @param id
	 * @return
	 */
	public List<EasyuiTreeNode> tree(String id);
	
	/**
	 * 资源树列表
	 * @param id
	 * @return
	 */
	public List<HeadResourcesM> treegrid(String id);
	
	/**
	 * 添加资源
	 * @param resources
	 * @return
	 */
	public HeadResourcesM add(HeadResourcesM resources);
	
	/**
	 * 删除资源
	 * @param resources
	 */
	public void del(HeadResourcesM resources);
	
	/**
	 * 修改资源
	 * @param resources
	 * @return
	 */
	public HeadResourcesM edit(HeadResourcesM resources);
	
	/**
	 * 根据SRC查找资源对象
	 */
	public HeadResources getResourcesBySrc(String src);
	
//	/**
//	 * 根据userId和src验证资源权限
//	 */
//	public boolean checkAuth(String userId,String src);
}
