package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.Role;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年10月12日 上午11:21:36
 */
public interface BusinessDao extends IBaseDao<Business>{

	/**
	 * 根据ID查找所有职务
	 * @return
	 */
	public List<Business> findBusiness(String id);
	
	/**
	 * 根据ID查找职务
	 * @return
	 */
	public Business getBusiness(String id);
	
	/**
	 * 添加职务
	 */
	public void addBusiness(Business business);
	
	/**
	 * 删除职务
	 */
	public void deleteBusiness(String id);
}
