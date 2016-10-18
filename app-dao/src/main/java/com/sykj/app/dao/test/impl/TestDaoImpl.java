package com.sykj.app.dao.test.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.test.TestDao;
import com.sykj.app.entity.test.Test;
import com.sykj.common.dao.BaseDao;

@Repository("testDao")
public class TestDaoImpl extends BaseDao<Test>
implements TestDao{

	@Override
	public void addTest(Test t) {
		this.add(t);
	}

}
