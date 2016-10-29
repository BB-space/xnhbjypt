package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.FrontUserInfoDao;
import com.sykj.app.entity.user.FrontUserInfo;
import com.sykj.common.dao.BaseDao;

@Repository("frontUserInfoDao")
public class FrontUserInfoDaoImpl extends BaseDao<FrontUserInfo> implements FrontUserInfoDao{

	@Override
	public FrontUserInfo getFrontUserInfo(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FrontUserInfo getFrontUserInfoByUserId(String userId) {
		
		return this.get("from FrontUserInfo t where t.userId='"+userId+"'");
	}

	@Override
	public void deleteFrontUserInfo(String id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void editFrontUserInfo(FrontUserInfo frontUserInfo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public FrontUserInfo getFrontUserInfoByUID(String uid) {
		
		return this.get("from FrontUserInfo t where t.uid='"+uid+ "'");
	}

	@Override
	public int getMaxUID() {
		String sql = "SELECT max(t.uid) from xnhb_user_userinfo t ";
		List<Object> list = this.findSQL(sql);
		if(list.get(0) != null){
			return (int) list.get(0);
		}
		return 0;
	}

	@Override
	public FrontUserInfo certifiUser(String userId) {
		return this.get("from FrontUserInfo t where t.userId='"+userId+ "'"
				+ " and t.realName is not null and t.realName != ''"
				+ " and t.cardNumber is not null and t.cardNumber != ''");
	}

}
