package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.BusinessResources;
import com.sykj.app.entity.system.RoleResources;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年10月12日 下午1:49:35
 */
public interface BusinessResourcesDao extends IBaseDao<BusinessResources>{

	/**
	 * 获得BusinessResources对象
	 */
	public BusinessResources getBusinessResources(String id);
	
	/**
	 * 查找BusinessResources
	 */
	public List<BusinessResources> findBusinessResources(Business business);
	
	/**
	 * 删除BusinessResources
	 */
	public void deleteBusinessResources(String id);
	
	/**
	 * 添加BusinessResources
	 */
	public void addBusinessResources(BusinessResources businessResources);
}
