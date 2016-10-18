package com.sykj.app.service.user;

import java.util.List;

import com.sykj.app.entity.user.UserSubCenter;

/**
 * @author wjl 2016年9月22日 下午4:51:19
 */
public interface UserSubCenterService {

	public void addUserSubCenter(UserSubCenter userSubCenter);
	
	public void editUserSubCenter(UserSubCenter userSubCenter);
	
	public void delUserSubCenter(UserSubCenter userSubCenter);
	
	/**
	 * 通过userID查找管辖分中心
	 * @param userId
	 * @return
	 */
	public List<UserSubCenter> getByUserId(String userId);
	
	/**
	 * 更新用户管辖的分中心
	 * @param userId
	 * @param subcenters
	 */
	public void updateUserSubCenter(String userId,String subcenters);
}
