package com.sykj.app.dao.user.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.WxUserDao;
import com.sykj.app.entity.user.WxUser;
import com.sykj.common.dao.BaseDao;

@Repository("wxUserDao")
public class WxUserDaoImpl extends BaseDao<WxUser> implements WxUserDao{

	@Override
	public WxUser getByOpenId(String openId) {
		
		return this.get("from WxUser t where t.openId='"+openId+"'");
	}

	@Override
	public void deleteByOpenId(String openId) {
		
		 this.delete(this.getByOpenId(openId));
	}

	@Override
	public void addWxUser(WxUser wxUser) {
		this.add(wxUser);
	}

	@Override
	public void updateWxUser(WxUser wxUser) {
		this.update(wxUser);
	}

	@Override
	public WxUser getByUnionid(String unionid) {
		return this.get("from WxUser t where t.unionid='"+unionid+"'");
	}

	//根据openid和APPID查询微信粉丝
	@Override
	public WxUser getByOpenIdAndAppId(String openId, String appId) {
		return this.get("from WxUser t where t.openId='"+openId+"' and t.appId='"+appId+"'");
	}

	@Override
	public WxUser getWxUserByPayOpenId(String payOpenId) {
		return this.get("from WxUser t where t.payOpenId='"+payOpenId+"'");
	}

}
