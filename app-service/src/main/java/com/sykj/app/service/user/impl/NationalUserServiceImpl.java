package com.sykj.app.service.user.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.user.NationalUserDao;
import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.entity.user.NationalUser;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.Json;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.NationalUserService;

@Service("nationalUserService")
public class NationalUserServiceImpl extends BaseServiceImpl implements NationalUserService{

	@Resource
	private UserInformationDao userInformationDao;
	@Resource
	private NationalUserDao nationalUserDao;
	
	@Override
	public Json judgeUser(String openId,String sysDictionaryId) {
		Json j = new Json();
		j.setSuccess(false);
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			NationalUser user = nationalUserDao.getByMobile(info.getMobile(), sysDictionaryId);
			if(user == null){
				j.setSuccess(true);
			}
		}
		return j;
	}

}
