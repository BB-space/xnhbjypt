package com.sykj.app.dao.user;

import com.sykj.app.entity.user.FrontUser;
import com.sykj.common.dao.IBaseDao;

public interface FrontUserDao extends IBaseDao<FrontUser>{

	/**
	 * 查找用户
	 */
	public FrontUser getUser(String id);
	/**
	 * 根据用户名查找用户
	 */
	public FrontUser getUserByUserName(String userName);
	/**
	 * 根据用户名密码查找用户
	 */
	public FrontUser getUserByNamePassword(String userName,String password);
	/**
	 * 添加用户
	 */
	public void addUser(FrontUser user);
	
	/**
	 * 校验手机号码/邮箱是否已经注册
	 * @param userName
	 * @return
	 */
	public FrontUser checkUserName(String userName);
	
	//更新密码
	public void updatePassword(String userName, String password, String updateTime);
}
