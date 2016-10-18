package com.sykj.app.dao.user;

import com.sykj.app.entity.user.UserPay;
import com.sykj.common.dao.IBaseDao;

public interface UserPayDao  extends IBaseDao<UserPay>{
	/**
	 * 根据用户ID查找用户
	 */
	public UserPay getUserPayByUserId(String userId);
	
	public void editUserPay(UserPay userPay);
	
	public UserPay getByMobile(String mobile);
}
