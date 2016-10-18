package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.UserBound;
import com.sykj.common.dao.IBaseDao;

public interface UserBoundDao extends IBaseDao<UserBound>{

	/**
	 * 获取绑定用户
	 * @return
	 */
	public List<UserBound> getUserBound();

	/**
	 * 获取所有用户
	 */
	public List<UserBound> getAll();
	
	
}
