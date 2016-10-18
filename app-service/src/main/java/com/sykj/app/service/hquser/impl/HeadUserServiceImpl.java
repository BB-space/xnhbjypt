package com.sykj.app.service.hquser.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.hquser.HeadUserDao;
import com.sykj.app.entity.hquser.HeadUser;
import com.sykj.app.service.hquser.HeadUserService;

@Service
public class HeadUserServiceImpl implements HeadUserService {
	@Autowired
	private HeadUserDao headUserDao;

	//根据用户名和密码进行登录
	@Override
	public HeadUser login(String name, String pwd) {
		HeadUser user=headUserDao.findByName(name);
		if(user!=null && user.getPassword().equals(pwd)){
			return user;
		}
		return null;
	}

}
