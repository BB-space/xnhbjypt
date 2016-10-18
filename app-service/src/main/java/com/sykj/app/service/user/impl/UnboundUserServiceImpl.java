package com.sykj.app.service.user.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.user.UnboundUserDao;
import com.sykj.app.entity.user.UnboundUser;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.UnboundUserService;

@Service("unboundUserService")
public class UnboundUserServiceImpl extends BaseServiceImpl implements UnboundUserService{

	@Resource
	private UnboundUserDao unboundUserDao;
	
	@Override
	public void addUnboundUser(UnboundUser unboundUser) {
		unboundUserDao.addUnboundUser(unboundUser);
	}

}
