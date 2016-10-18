package com.sykj.app.service.user.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;



import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.dao.user.UserSubCenterDao;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.UserSubCenterService;

/**
 * @author wjl 2016年9月22日 下午4:51:41
 */
@Service("userSubCenterService")
public class UserSubCenterServiceImpl extends BaseServiceImpl implements UserSubCenterService{

	@Resource
	private UserSubCenterDao userSubcenterDao;
	@Resource
	private UserInformationDao userInformationDao;

	
	@Override
	public void addUserSubCenter(UserSubCenter userSubCenter) {
		userSubCenter.setId(UUID.randomUUID().toString());
		userSubcenterDao.addUserSubCenter(userSubCenter);
	}

	@Override
	public void editUserSubCenter(UserSubCenter userSubCenter) {
		userSubcenterDao.editUserSubCenter(userSubCenter);
	}

	@Override
	public void delUserSubCenter(UserSubCenter userSubCenter) {
		userSubcenterDao.delUserSubCenter(userSubCenter);
	}

	@Override
	public List<UserSubCenter> getByUserId(String userId) {
		return userSubcenterDao.getByUserId(userId);
	}

	@Override
	public void updateUserSubCenter(String userId, String subcenters) {
		// TODO Auto-generated method stub
		
	}



}
