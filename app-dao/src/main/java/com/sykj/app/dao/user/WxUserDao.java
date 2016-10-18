package com.sykj.app.dao.user;

import com.sykj.app.entity.user.WxUser;
import com.sykj.common.dao.IBaseDao;

public interface WxUserDao extends IBaseDao<WxUser>{

	/**
	 * 根据openid查找微信用户
	 */
	public WxUser getByOpenId(String openId);
	
	/**
	 * 根据openid删除微信用户
	 */
	public void deleteByOpenId(String openId);
	
	/**
	 * 添加微信粉丝
	 */
	public void addWxUser(WxUser wxUser);
	
	/**
	 * 修改微信粉丝信息
	 */
	public void updateWxUser(WxUser wxUser);
	
	/**
	 * 根据unionid查找微信用户
	 * @param unionid
	 * @return
	 */
	public WxUser getByUnionid(String unionid);
	/**
	 * 根据openid和APPID查询微信粉丝
	 * @param openId
	 * @param appId
	 * @return
	 */
	public WxUser getByOpenIdAndAppId(String openId,String appId);
	
	/**
	 * 根据支付openId获取用户信息
	 * @param payOpenId
	 * @return
	 */
	public WxUser getWxUserByPayOpenId(String payOpenId);
}
