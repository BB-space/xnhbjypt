package com.sykj.app.dao.user.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.NationalUserDao;
import com.sykj.app.entity.user.NationalUser;
import com.sykj.common.dao.BaseDao;

@Repository("nationalUserDao")
public class NationalUserDaoImpl extends BaseDao<NationalUser> implements NationalUserDao{

	@Override
	public NationalUser getByMobile(String mobile, String sysdictionaryId) {
		String hql = "from NationalUser where mobile='"+mobile+"' and sysdictionaryId='"+sysdictionaryId+"'";
		return this.get(hql);
	}

}
