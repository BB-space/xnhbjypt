package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.BusinessMenuDao;
import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.BusinessMenu;
import com.sykj.common.dao.BaseDao;

/**
 * @author wjl 2016年10月12日 下午2:07:24
 */
@Repository("businessMenuDao")
public class BusinessMenuDaoImpl extends BaseDao<BusinessMenu> implements BusinessMenuDao{

	@Override
	public BusinessMenu getBusinessMenu(String id) {
		return this.get(BusinessMenu.class, id);
	}
	
	@Override
	public List<BusinessMenu> findBusinessMenu(Business business) {
		return this.list("from BusinessMenu t where t.business=?", business);
	}

	@Override
	public void deleteBusinessMenu(String id) {
		this.delete(this.getBusinessMenu(id));
	}

	@Override
	public void addBusinessMenu(BusinessMenu businessMenu) {
		this.add(businessMenu);
	}

}
