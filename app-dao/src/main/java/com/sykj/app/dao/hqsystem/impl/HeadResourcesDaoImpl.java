package com.sykj.app.dao.hqsystem.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.hqsystem.HeadResourcesDao;

import com.sykj.app.entity.hqsystem.HeadResources;

import com.sykj.common.dao.BaseDao;

@Repository
public class HeadResourcesDaoImpl extends BaseDao<HeadResources> implements HeadResourcesDao {

	@Override
	public List<HeadResources> find(String id) {
		String hql = "from HeadResources t where t.resources is null order by t.seq";
		if (id != null && !id.trim().equals("")) {
			hql = "from HeadResources t where t.resources.id ='" + id + "' order by t.seq";
		}
		return this.list(hql);
	}

	@Override
	public HeadResources getResources(String id) {
		
		return this.get(HeadResources.class, id);
	}

	@Override
	public void addResources(HeadResources resources) {
		this.add(resources);
		
	}

	@Override
	public void deleteResources(String id) {
		this.delete(this.getResources(id));
		
	}

	@Override
	public void updateResources(HeadResources resources) {
		this.update(resources);
		
	}

	@Override
	public HeadResources getResourcesBySrc(String src) {
		return this.get("from HeadResources t where t.src='"+src+"'");
	}

}
