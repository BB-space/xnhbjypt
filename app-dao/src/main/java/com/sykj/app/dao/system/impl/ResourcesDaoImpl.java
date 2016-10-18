package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.ResourcesDao;
import com.sykj.app.entity.system.Resources;
import com.sykj.common.dao.BaseDao;

@Repository("resourcesDao")
public class ResourcesDaoImpl extends BaseDao<Resources> implements ResourcesDao {

	@Override
	public List<Resources> find(String id) {
		String hql = "from Resources t where t.resources is null order by t.seq";
		if (id != null && !id.trim().equals("")) {
			hql = "from Resources t where t.resources.id ='" + id + "' order by t.seq";
		}
		return this.list(hql);
	}

	@Override
	public Resources getResources(String id) {
		
		return this.get(Resources.class, id);
	}

	@Override
	public void addResources(Resources resources) {
		this.add(resources);
		
	}

	@Override
	public void deleteResources(String id) {
		this.delete(this.getResources(id));
		
	}

	@Override
	public void updateResources(Resources resources) {
		this.update(resources);
		
	}

	@Override
	public Resources getResourcesBySrc(String src) {
		return this.get("from Resources t where t.src='"+src+"'");
	}
	
	@Override
	public List<Resources> getListBySrc(String src) {
		return this.list("from Resources t where t.src='"+src+"'");
	}

	@Override
	public Resources getResourcesBySrc(String src, String paremeter) {
		
		return this.get("from Resources t where t.src='"+src+"' and t.parameter='"+paremeter+"'");
	}

}
