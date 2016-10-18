package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.BusinessResourcesDao;
import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.BusinessResources;
import com.sykj.common.dao.BaseDao;

/**
 * @author wjl 2016年10月12日 下午1:50:03
 */
@Repository("businessResourcesDao")
public class BusinessResourcesDaoImpl extends BaseDao<BusinessResources> implements BusinessResourcesDao{

	@Override
	public BusinessResources getBusinessResources(String id) {
		return this.get(BusinessResources.class,id);
	}
	
	@Override
	public List<BusinessResources> findBusinessResources(Business business) {
		return this.list("from BusinessResources t where t.business=?", business);
	}

	@Override
	public void deleteBusinessResources(String id) {
		this.delete(this.getBusinessResources(id));
	}

	@Override
	public void addBusinessResources(BusinessResources businessResources) {
		this.add(businessResources);
	}

}
