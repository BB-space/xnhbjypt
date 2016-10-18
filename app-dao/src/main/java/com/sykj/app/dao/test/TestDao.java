package com.sykj.app.dao.test;

import com.sykj.app.entity.test.Test;
import com.sykj.common.dao.IBaseDao;

public interface TestDao extends IBaseDao<Test>{
	
	public void addTest(Test t);

}
