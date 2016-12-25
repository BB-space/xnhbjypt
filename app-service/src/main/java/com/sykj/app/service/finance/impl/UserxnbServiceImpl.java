package com.sykj.app.service.finance.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.finance.UserxnbDao;
import com.sykj.app.entity.finance.Userxnb;
import com.sykj.app.service.finance.UserxnbService;
import com.sykj.app.service.impl.BaseServiceImpl;

@Service("userxnbService")
public class UserxnbServiceImpl extends BaseServiceImpl implements UserxnbService{

	@Resource
	private UserxnbDao userxnbDao;

	@Override
	public void addUserxnb(Userxnb xnb) {
		
		
		userxnbDao.addUserxnb(xnb);
	}

	@Override
	public Userxnb getUserxnbByLoginNameAndType(String loginName, String xnbtype) {
		return userxnbDao.getUserxnbByLoginNameAndType(loginName, xnbtype);
	}

	@Override
	public List<Userxnb> getUserxnbByLoginName(Userxnb xnb) {
		return userxnbDao.getUserxnbByLoginName(xnb.getLoginname());
	}
}
