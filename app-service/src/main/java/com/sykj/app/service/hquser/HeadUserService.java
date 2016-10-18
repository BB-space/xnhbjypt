package com.sykj.app.service.hquser;

import com.sykj.app.entity.hquser.HeadUser;

public interface HeadUserService {
	
	/**
	 * 根据用户名和密码进行登录
	 * @param name
	 * @param pwd
	 * @return
	 */
	public HeadUser login(String name,String pwd);

}
