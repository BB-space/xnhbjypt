package com.sykj.app.service.system;

import java.util.List;

import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.RoleM;
import com.sykj.app.model.system.BusinessM;

/**
 * @author wjl 2016年10月12日 上午11:15:42
 */
public interface BusinessService {

	/**
	 * 获得职务表格
	 * @param id
	 * @return
	 */
	public List<BusinessM> treegrid(String id);
	
	/**
	 * 获得职务树
	 */
	public List<EasyuiTreeNode> tree(String id);
	
	/**
	 * 添加职务
	 * @param business
	 * @return
	 */
	public BusinessM add(BusinessM business);
	
	/**
	 * 修改职务
	 * @param business
	 * @return
	 */
	public BusinessM edit(BusinessM business);
	
	/**
	 * 删除角色
	 * @param business
	 */
	public void del(BusinessM business);
}
