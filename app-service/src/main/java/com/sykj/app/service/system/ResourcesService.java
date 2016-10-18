package com.sykj.app.service.system;

import java.util.List;

import com.sykj.app.entity.system.Resources;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.ResourcesM;

public interface ResourcesService {

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
	public List<ResourcesM> treegrid(String id);
	
	/**
	 * 添加资源
	 * @param resources
	 * @return
	 */
	public ResourcesM add(ResourcesM resources);
	
	/**
	 * 删除资源
	 * @param resources
	 */
	public void del(ResourcesM resources);
	
	/**
	 * 修改资源
	 * @param resources
	 * @return
	 */
	public ResourcesM edit(ResourcesM resources);
	
	/**
	 * 根据SRC查找资源对象
	 */
	public Resources getResourcesBySrc(String src);
	/**
	 * 根据SRC查找资源List
	 */
	public List<Resources> getListBySrc(String src);
	/**
	 * 根据SRC和parameter查找资源对象
	 */
	public Resources getResourcesBySrc(String src,String parameter);
	/**
	 * 根据userId和src验证资源权限
	 */
	public boolean checkAuth(String userId,String src);
}
