package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.BusinessDao;
import com.sykj.app.entity.system.Business;
import com.sykj.common.dao.BaseDao;

/**
 * @author wjl 2016年10月12日 上午11:22:04
 */
@Repository("businessDao")
public class BusinessDaoImpl extends BaseDao<Business> implements BusinessDao{

	@Override
	public List<Business> findBusiness(String id) {
		String hql = "from Business t where t.business is null order by t.seq";
		if (id != null && !id.trim().equals("")) {
			hql = "from Business t where t.business.id ='" + id + "' order by t.seq";
		}
		return this.list(hql);
	}

	@Override
	public Business getBusiness(String id) {
		return this.get(Business.class, id);
	}

	@Override
	public void addBusiness(Business business) {
		this.add(business);
	}

	@Override
	public void deleteBusiness(String id) {
		this.delete(this.getBusiness(id));
	}

}
