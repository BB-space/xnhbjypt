package com.sykj.app.dao.system.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.SysDictionaryDao;
import com.sykj.app.entity.system.SysDictionary;
import com.sykj.common.dao.BaseDao;

@Repository("sysDictionaryDao")
public class SysDictionaryDaoImpl extends BaseDao<SysDictionary> implements
		SysDictionaryDao {

	@Override
	public void addSysDictionary(SysDictionary t) {
		this.add(t);
	}

	@Override
	public SysDictionary getSysDictionary(String id) {
		return this.get("from SysDictionary t where t.id='"+id+"'");
	}

}
