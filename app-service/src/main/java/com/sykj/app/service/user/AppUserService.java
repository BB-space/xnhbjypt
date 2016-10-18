package com.sykj.app.service.user;

import java.util.List;

import com.sykj.app.entity.user.SubordinateUser;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.entity.user.WxUser;
import com.sykj.app.model.UserM;


/**
 * 前台注册登录
 * @author swh
 *
 */
public interface AppUserService {

	/**
	 * 前台APP会员注册
	 */
	public int addUser(UserM userM,String mobile);
	/**
	 * 后台appBackground扫码登录绑定用户
	 */
	public int addBackgroundUser(UserM userM,String wxUser);
	/**
	 * 前台APP会员注册验证用户是否已存在
	 */
	public User vMobile(String mobile);
	/**
	 * 用户登录
	 */
	public UserM login(String username,String password);
	
	/**
	 * 重置密码
	 */
	public int updatePassword(UserM userM);
	
	/**
	 * 获得用户验证码
	 */
	public String addVerificationCode(String type,String mobile);
	
	/**
	 * 绑定open
	 */
	public int editBindingOpenId(String openId,String userId);
	
	/**
	 * 根据门店查询用户信息
	 * @param shopId
	 * @return
	 */
	public List<UserInformation> findByShopId(String shopId);
	
	/**
	 * 根据门店查询用户信息
	 * @param shopId
	 * @return
	 */
	public List<UserInformation> findByShopId(String shopId,String userType);
	
	/**
	 * 根据openId查询用户信息
	 * @param openId
	 * @return
	 */
	public UserInformation findByUserId(String openId);
	
	/**
	 *根据用户编号查询用户信息
	 * @param userId
	 * @return
	 */
	public UserInformation getId(String userId);
	
	/**
	 * 添加所属用户
	 * @param s
	 */
	public void addSubordinateUser(SubordinateUser s);
	
	/**
	 * 根据openID查询所属用户信息
	 * @param openId
	 * @return
	 */
	public SubordinateUser getOpenId(String openId);
	
	/**
	 * 根据openID查询用户
	 * @param openId
	 * @return
	 */
	public UserInformation getByOpenId(String openId);
	
	/**
	 * 用户根据openID登录
	 */
	public UserM getBylogin(String username,String password);
	
	/**
	 * 编辑用户，修改员工的名字和描述
	 * @param u
	 */
	public void updateUserInformation(UserInformation u);
	
	public VerificationCode fingByPhone(String mobile);
	
	/**
	 * 
	 * @param shopId
	 * @return
	 */
	public List<UserInformation> findByShopIdAndAccount(String shopId);
	
	/**
	 * 取消二维码
	 * @param openId
	 * @return
	 */
	public int editCancelEmpAccount(String openId);
}
