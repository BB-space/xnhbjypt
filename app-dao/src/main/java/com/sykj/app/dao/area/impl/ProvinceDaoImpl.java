package com.sykj.app.dao.area.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.area.ProvinceDao;
import com.sykj.app.entity.area.Province;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("provinceDao")
public class ProvinceDaoImpl extends BaseDao<Province> implements ProvinceDao {

	@Override
	public Province getProvince(String id) {
		
		return this.get(Province.class, id);
	}

	@Override
	public void deleteProvince(String id) {
		this.delete(this.getProvince(id));
		
	}

	@Override
	public Pager<Province> findProvince(SystemContext syct, Province Province) {
		StringBuffer hql = new StringBuffer("from Province t where 1=1 ORDER BY t.provinceNumber");
		return this.find(hql.toString(),syct);
	}

	@Override
	public List<Province> getAllProvince() {
		
		return this.list("from Province t where 1=1 ORDER BY t.provinceNumber");
	}

	@Override
	public List<Province> getZYShopProvince(String shopType) {
		String hql = "from Province where id in "
	                  +"( select provinceId from City where id in (select cityId from Shop where shopType='"+shopType+"')) "
	                  +"order by seq desc";
		return this.list(hql);
	}



}

