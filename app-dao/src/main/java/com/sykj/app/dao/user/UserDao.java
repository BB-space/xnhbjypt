package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.User;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.common.dao.IBaseDao;

public interface UserDao extends IBaseDao<User>{

	/**
	 * 查找用户
	 */
	public User getUser(String id);
	/**
	 * 根据用户名查找用户
	 */
	public User getUserByUsername(String username);
	/**
	 * 根据用户名密码查找用户
	 */
	public User getUserByNamePassword(String username,String password);
	/**
	 * 添加用户
	 */
	public void addUser(User user);
	
	/**
	 * 删除用户
	 */
	public void deleteUser(String id);
	
	/**
	 * 修改用户
	 */
	public void editUser(User user);
	
	/**
	 * 获得所有用户（分页）
	 */
	public Pager<User> findUser(SystemContext syct, UserM userM);
	
	/**
	 * 获得所有用户总记录数
	 */
	public Long countUser();
	
	/**
	 * 根据用户名和用户类型查找用户
	 */
	public User getUserByUsername(String username,String id);
	
	/**
	 * 记录店长人数
	 * @return
	 */
	public Integer getCount(String shopId);
	
	/**
	 * 记录不是当前用户店长人数
	 * @return
	 */
	public Integer getCount(String shopId,String id);
	
	/**
	 * 根据openId查找用户类型
	 */
	public User findUserByOpenId(String openId);
	
	/**
	 * 根据电话查找用户类型
	 */
	public User findByMobile(String mobile);
	
	/**
	 * 根据用户类型查询用户信息
	 * @param id
	 * @return
	 */
	public List<Object> findByUserType(String id);
	
	/**
	 * 根据店长身份查询信息
	 * zq
	 * @param shopId
	 * @return
	 */
	public User findByShopIdAndUserType(String shopId);
	
	/**
	 * 根据用户名，电话查询数据库中不是当前用户的信息
	 * zq
	 * @param name
	 * @param id
	 * @return
	 */
	public User findByNameAndIMobile(String name,String id,String mobile);
	/**
	 * 分中心列表
	 */
	public Pager<User> findSubcenterUser(SystemContext syct, UserM userM,String userType);
	
}
