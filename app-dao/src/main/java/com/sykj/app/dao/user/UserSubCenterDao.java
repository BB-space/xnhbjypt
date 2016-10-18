package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年9月22日 下午4:52:53
 */
public interface UserSubCenterDao extends IBaseDao<UserSubCenter>{

	public void addUserSubCenter(UserSubCenter userSubCenter);
	
	public void editUserSubCenter(UserSubCenter userSubCenter);
	
	public void delUserSubCenter(UserSubCenter userSubCenter);
	
	/**
	 * 通过userID查找管辖分中心
	 * @param userId
	 * @return
	 */
	public List<UserSubCenter> getByUserId(String userId);
}
