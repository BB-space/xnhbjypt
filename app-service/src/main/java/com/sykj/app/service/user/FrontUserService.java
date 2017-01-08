package com.sykj.app.service.user;

import com.sykj.app.entity.user.FrontUserInfo;
import com.sykj.app.entity.user.User;
import com.sykj.app.model.FrontUserM;


/**
 * 前台注册登录
 * @author lsq
 *
 */
public interface FrontUserService {

	/**
	 * 前台会员注册
	 */
	public FrontUserM register(FrontUserM frontUserM);
	
	/**
	 * 发送激活邮件
	 * @param email
	 * @param uid
	 * @param uuid
	 */
	public void sendEmail(String email, int uid, String uuid, String ip);
	
	/**
	 * 前台会员注册验证用户是否已存在
	 */
	public User vMobile(String userName);
	/**
	 * 用户登录
	 */
	public FrontUserM login(String userName,String password);
	
	/**
	 * 重置密码
	 */
	public int updatePassword(String userName, String password);
	/**
	 *根据用户编号查询用户信息
	 * @param userId
	 * @return
	 */
	public FrontUserInfo getId(String userId);
	
	/**
	 * 校验手机号码/邮箱是否已经注册
	 * @param userName
	 * @return
	 */
	public boolean checkUserName(String userName);
	
	/**
	 * 邮件激活验证
	 * @param uid
	 * @return
	 */
	public int validate(String uid, String uuid);
	
	/**
	 * 检查用户是否实名认证
	 * @param userName
	 * @return
	 */
	public boolean certification(String userId);
	
	/**
	 * 实名认证
	 * @param m
	 * @return
	 */
	public void validateIdentity(FrontUserM m);
	
	/**
	 * 修改昵称
	 * @param m
	 */
	public void updateNickName(FrontUserM m);
	
	/**
	 * 保存邮箱
	 * @param m
	 */
	public void saveEmail(FrontUserM m);
	
	/**
	 * 保存绑定手机
	 * @param m
	 */
	public void saveMobile(FrontUserM m);
	
	/**
	 * 修改密码
	 * @return
	 */
	public int changePassword(FrontUserM m);
	
	/**
	 * 校验绑定手机是否存在
	 * @param mobile
	 * @return
	 */
	public boolean checkBoundMobile(String mobile); 
	
	/**
	 * 校验绑定邮箱是否存在
	 * @param email
	 * @return
	 */
	public boolean checkBoundEmail(String email); 
	
	/**
	 * 校验原密码
	 * @param userName
	 * @param password
	 * @return
	 */
	public boolean checkPassword(String userName, String password); 
}
