package com.sykj.app.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.user.UserPayDao;
import com.sykj.app.entity.user.UserPay;
import com.sykj.app.service.user.UserPayService;

@Service("userPayService")
public class UserPayServiceImpl implements UserPayService{

	@Autowired
	private UserPayDao userPayDao;
	
	@Override
	public UserPay getByMobile(String mobile) {
		UserPay up = userPayDao.getByMobile(mobile);
		return up;
	}

	@Override
	public void updateUserPay(UserPay userPay) {
		userPayDao.editUserPay(userPay);
	}

	@Override
	public void addUserPay(UserPay userPay) {
		userPayDao.add(userPay);
	}

}
