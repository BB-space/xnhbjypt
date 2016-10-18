package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserBusiness;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年10月12日 下午2:49:13
 */
public interface UserBusinessDao extends IBaseDao<UserBusiness>{

	/**
	 * 根据business查找所有UserBusiness
	 */
	public List<UserBusiness> findByBusiness(Business business);
	
	/**
	 * 删除UserBusiness
	 */
	public void deleteUserBusiness(String id);
	
	/**
	 * 根据ID查找UserBusiness
	 * @return
	 */
	public UserBusiness getUserBusiness(String id);
	
	/**
	 * 根据user查找所有UserBusiness
	 */
	public List<UserBusiness> findByUser(User user);
	
	/**
	 * 添加UserBusiness
	 */
	public void addUserBusiness(UserBusiness userBusiness);
	
	/**
	 * 根据userID查找UserBusiness
	 * @return
	 */
	public UserBusiness getUserBusinessByUserId(String userId);
}
