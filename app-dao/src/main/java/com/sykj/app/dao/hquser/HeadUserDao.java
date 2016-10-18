package com.sykj.app.dao.hquser;

import com.sykj.app.entity.hquser.HeadUser;
import com.sykj.common.dao.IBaseDao;

/**
 * 总部用户
 * @author Administrator
 *
 */
public interface HeadUserDao extends IBaseDao<HeadUser>{
	
	/**
	 * 根据用户名查询用户
	 * @param name
	 * @return
	 */
	public HeadUser findByName(String name);

}
