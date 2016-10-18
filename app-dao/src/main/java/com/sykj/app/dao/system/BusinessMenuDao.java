package com.sykj.app.dao.system;

import java.util.List;

import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.BusinessMenu;
import com.sykj.app.entity.system.RoleMenu;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年10月12日 下午2:06:56
 */
public interface BusinessMenuDao extends IBaseDao<BusinessMenu>{

	/**
	 * 获得BusinessMenu对象
	 */
	public BusinessMenu getBusinessMenu(String id);
	
	/**
	 * 查找BusinessMenu
	 */
	public List<BusinessMenu> findBusinessMenu(Business business);
	
	/**
	 * 删除BusinessMenu
	 */
	public void deleteBusinessMenu(String id);
	
	/**
	 * 添加BusinessMenu
	 */
	public void addBusinessMenu(BusinessMenu businessMenu);
}
