package com.sykj.app.service.user;

import com.sykj.app.entity.user.UserPay;

public interface UserPayService {

	public UserPay getByMobile(String mobile);
	
	public void updateUserPay(UserPay userPay);
	
	public void addUserPay(UserPay userPay);
}
