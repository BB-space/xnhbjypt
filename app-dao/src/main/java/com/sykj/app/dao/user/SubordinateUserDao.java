package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.SubordinateUser;
import com.sykj.common.dao.IBaseDao;

public interface SubordinateUserDao extends IBaseDao<SubordinateUser> {
	
	/**
	 * 根据openID查询所属用户信息
	 * @param openId
	 * @return
	 */
	public SubordinateUser getOpenId(String openId);
	
	/**
	 * 添加所属用户信息
	 * @param s
	 */
	public void addSubordinateUser(SubordinateUser s);

	/**
	 * 根据员工id获取员工的客户
	 * @param userId
	 * @return
	 */
	public List<SubordinateUser> getSubordinateUserByUserId(String userId);
}
