package com.sykj.app.dao.area.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.area.SubcenterDao;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("subcenterDao")
public class SubcenterDaoImpl extends BaseDao<Subcenter> implements
		SubcenterDao {

	@Override
	public Subcenter getSubcenter(String id) {
		
		return this.get(Subcenter.class, id);
	}

	@Override
	public void deleteSubcenter(String id) {
		this.delete(this.getSubcenter(id));
		
	}

	@Override
	public Pager<Subcenter> findSubcenter(SystemContext syct,
			Subcenter Subcenter) {
		StringBuffer hql = new StringBuffer("from Subcenter t where 1=1");
		return this.find(hql.toString(),syct);
	}

	@Override
	public List<Subcenter> getAllSubcenter() {
		
		return this.list("from Subcenter t where 1=1 and (subcenterNumber != '1' or subcenterNumber is null) order by seq");
	}

	@Override
	public Subcenter getById(String id) {
		return this.get(Subcenter.class, id);
	}



}
