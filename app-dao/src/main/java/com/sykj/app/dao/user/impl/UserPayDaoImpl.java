package com.sykj.app.dao.user.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserPayDao;
import com.sykj.app.entity.user.UserPay;
import com.sykj.common.dao.BaseDao;

@Repository("userPayDao")
public class UserPayDaoImpl extends BaseDao<UserPay> implements UserPayDao {

	@Override
	public UserPay getUserPayByUserId(String userId) {
		return this.get("from UserPay t where t.userId='"+userId+"'");
	}

	@Override
	public void editUserPay(UserPay userPay) {
		this.update(userPay);
	}

	@Override
	public UserPay getByMobile(String mobile) {
		return this.get("from UserPay u where u.mobile = '"+mobile+"'");
	}
}
