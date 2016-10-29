package com.sykj.app.dao.user;

import com.sykj.app.entity.user.FrontUserInfo;
import com.sykj.common.dao.IBaseDao;

public interface FrontUserInfoDao extends IBaseDao<FrontUserInfo>{

	/**
	 * 查找用户
	 */
	public FrontUserInfo getFrontUserInfo(String id);
	
	/**
	 * 根据用户ID查找用户
	 */
	public FrontUserInfo getFrontUserInfoByUserId(String userId);
	
	
	/**
	 * 删除用户
	 */
	public void deleteFrontUserInfo(String id);
	
	/**
	 * 修改用户
	 */
	public void editFrontUserInfo(FrontUserInfo frontUserInfo);
	
	/**
	 * 根据uid获取用户信息
	 * @param uid
	 * @return
	 */
	public FrontUserInfo getFrontUserInfoByUID(String uid);
	
	/**
	 * 获取最大的uid值
	 * @return
	 */
	public int getMaxUID();
	
	/**
	 * 查看用户是否已经实名认证
	 * @param userId
	 * @return
	 */
	public FrontUserInfo certifiUser(String userId);
	
}
