package com.sykj.app.service.user.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.sykj.app.dao.user.MemberToEmployeesDao;
import com.sykj.app.dao.user.SubordinateUserDao;
import com.sykj.app.dao.user.UserBoundDao;
import com.sykj.app.dao.user.UserDao;
import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.dao.user.VerificationCodeDao;
import com.sykj.app.dao.user.WxUserDao;
import com.sykj.app.entity.user.SubordinateUser;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserBound;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.entity.user.WxUser;
import com.sykj.app.model.UserM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.AppUserService;
import com.sykj.app.util.ConfigUtil;
import com.sykj.app.util.MyRandom;
import com.sykj.app.util.SecurityUtil;
import com.sykj.common.core.DatabaseContextHolder;

@Service("appUserService")
public class AppUserServiceImpl extends BaseServiceImpl implements AppUserService{

	@Resource
	private UserDao userDao;
	@Resource
	private UserBoundDao userBoundDao;
	@Resource
	private UserInformationDao userInformationDao;
	@Resource
	private VerificationCodeDao verificationCodeDao;
	@Resource
	private MemberToEmployeesDao memberToEmployeesDao;
	@Autowired
	private SubordinateUserDao subordinateUserDao;
	@Autowired
	private WxUserDao wxUserDao;

	
	@Override
	public int addUser(UserM userM,String mobile) {
		//检测openId是否已经存在
		UserInformation infos = userInformationDao.getByOpenId(userM.getOpenId());
		if(infos!=null){
			return 3;
		}
		//0:表示验证成功,并注册；1：表示验证码已使用；2：表示验证失败，验证码不存在;3:表示该用户已被注册,;
		int b =0;
		
			//商城
		DatabaseContextHolder.setCustomerType(DatabaseContextHolder.DATA_SOURCE_B);
		userM.setMobile(userM.getUserName());
		User u = userDao.getUserByUsername(userM.getUserName());
		
		if(u!=null){
			UserInformation userInfo = userInformationDao.getUserInformationByUserId(u.getId());
			if(userInfo!=null){
				if(userInfo.getOpenId()!=null && !userInfo.getOpenId().equals("")){
					return 3;
				}else{
					b=vCode(userM);//验证码验证
					if (b == 0) {
						UserInformation info = userInformationDao.findByMobile(userM.getUserName());
						info.setOpenId(userM.getOpenId());
						info.setStatus("0");
						userInformationDao.update(info);
						userDao.update(u);
					}
					return b;
				}
			}
		}else{
		b=vCode(userM);//验证码验证
			if (b == 0) {
				User user = new User();
				UserInformation ufm = new UserInformation();
				//根据openid查询微信里的信息
				WxUser w=wxUserDao.getByOpenIdAndAppId(userM.getOpenId(), ConfigUtil.APPID);
				userM.setId(UUID.randomUUID().toString());
				userM.setCreateDateTime(new Date());
				userM.setUserType("2");
				userM.setUserPassword(SecurityUtil.md5(userM.getUserPassword()));
				BeanUtils.copyProperties(userM, user);
				BeanUtils.copyProperties(userM, ufm);
				ufm.setId(UUID.randomUUID().toString());
				ufm.setUserId(userM.getId());
				ufm.setOpenId(userM.getOpenId());
				ufm.setMobile(userM.getMobile());
				ufm.setNowCoin(100L);//绑定获取100积分
				ufm.setTotalCoin(100L);
				String sex=null;
				if(w!=null){
					if(w.getSex().equals(1)){
						sex="男";
					}else if(w.getSex().equals(2)){
						sex="女";
					}else{
						sex=null;
					}
					ufm.setSex(sex);
					ufm.setAvatar(w.getHeadImgUrl());
					ufm.setRealname(w.getNickname());
				}
				ufm.setStatus("0");
				userInformationDao.add(ufm);
				userDao.add(user);
				this.addUserRole(user);
				
				UserBound t = new UserBound();
				t.setId(userM.getId());
				t.setOpenId(userM.getOpenId());
				t.setMobile(userM.getMobile());
				t.setStatus("0");
				userBoundDao.add(t);
			}
		}
		return b;
	}
	
	//验证码验证状态
	public int vCode(UserM userM){
		int a =0;//0:表示验证成功,并修改密码；1：表示验证码已使用；2：表示验证失败，验证码不存在
		VerificationCode vc = verificationCodeDao.getVerificationCode(userM.getMobileCode(), userM.getMobile());
		if(vc==null){
			a=2;
		}else if(vc.getCodeStatus().equals("0")){
			vc.setCodeStatus("1");
			vc.setUsedDateTime(new Date());
			verificationCodeDao.update(vc);//修改验证码使用状态
		}else{
			a=1;
		}
		return a;
	}

	

	@Override
	public UserM login(String username, String password) {
		UserM um = null;
		User user = userDao.getUserByNamePassword(username, SecurityUtil.md5(password));
		if(user!=null){
			um = new UserM();
			UserInformation uim = userInformationDao.getUserInformationByUserId(user.getId());
			//BeanUtils.copyProperties(uim,um);
			um.setId(uim.getUserId());
			um.setRealname(uim.getRealname());
			um.setShopId(uim.getShopId());
			um.setMobile(uim.getMobile());
			um.setUserName(user.getUserName());
			um.setOpenId(uim.getOpenId());
			um.setUserType(user.getUserType());
		}
		return um;
	}

	//重置密码
	@Override
	public int updatePassword(UserM userM) {
		int a = updateCode(userM);//验证码验证
		if(a==0){//验证成功
			User user = userDao.getUserByUsername(userM.getMobile());
			user.setUserPassword(SecurityUtil.md5(userM.getUserPassword()));
			user.setCreateDateTime(new Date());
			userDao.update(user);//修改密码
		}
		return a;
	}

	@Override
	public String addVerificationCode(String type,String mobile) {
		VerificationCode vc = verificationCodeDao.getVerificationCodeBytype(type, mobile);
		String code = MyRandom.runVerifyCode(6);
		if(vc!=null){
			vc.setCode(code);
			vc.setCreateDateTime(new Date());
			verificationCodeDao.updateVerificationCode(vc);
			return code;
		}else{
			VerificationCode verificationCode = new VerificationCode();
			verificationCode.setId(UUID.randomUUID().toString());
			verificationCode.setCode(code);
			verificationCode.setCodeType(type);
			verificationCode.setCodeStatus("0");
			verificationCode.setMobile(mobile);
			verificationCode.setCreateDateTime(new Date());
			verificationCodeDao.add(verificationCode);
			return code;
		}

		
	}

	@Override
	public User vMobile(String mobile) {
		User user = userDao.getUserByUsername(mobile);
		return user;
	}
	
	//验证码验证状态
	public int updateCode(UserM userM){
		int a =0;//0:表示验证成功,并修改密码；1：表示验证码已使用；2：表示验证失败，验证码不存在
		VerificationCode vc = verificationCodeDao.getVerificationCode(userM.getMobileCode(), userM.getMobile());
		if(vc==null){
			a=2;
		}else if(vc.getCodeStatus().equals("0")){
			vc.setCodeStatus("1");
			vc.setUsedDateTime(new Date());
			verificationCodeDao.update(vc);//修改验证码使用状态
		}else{
			a=1;
		}
		return a;
	}


	@Override
	public int editBindingOpenId(String openId, String userId) {
		int result=0;
		UserInformation userInformation = userInformationDao.getUserInformationByUserId(userId);
		if(null==userInformation.getOpenId()){
			userInformation.setOpenId(openId);
			userInformationDao.update(userInformation);
			result=1;
		}
		return result;
	}

	
	//根据门店查询用户信息
	@Override
	public List<UserInformation> findByShopId(String shopId) {
		
		return userInformationDao.getUserInformationByShopId(shopId);
	}
	
	@Override
	public List<UserInformation> findByShopId(String shopId,String userType) {
		
		return userInformationDao.getUserInformationByShopId(shopId,userType);
	}

	//根据openId查询用户信息
	@Override
	public UserInformation findByUserId(String openId) {
		
		return userInformationDao.getByOpenId(openId);
	}

	//根据用户编号查询用户信息
	@Override
	public UserInformation getId(String userId) {
		
		return userInformationDao.fingByUserId(userId);
	}

	//添加所属用户
	@Override
	public void addSubordinateUser(SubordinateUser s) {
		subordinateUserDao.addSubordinateUser(s);
	}

	//根据openId查询所属用户信息
	@Override
	public SubordinateUser getOpenId(String openId) {
		return subordinateUserDao.getOpenId(openId);
	}

	//根据openID查询用户
	@Override
	public UserInformation getByOpenId(String openId) {
		
		return userInformationDao.getByOpenId(openId);
	}

	//用户根据openID登录
	@Override
	public UserM getBylogin(String username, String password) {
		UserM um = null;
		User user = userDao.getUserByNamePassword(username, password);
		if(user!=null){
			um = new UserM();
			UserInformation uim = userInformationDao.getUserInformationByUserId(user.getId());
			//BeanUtils.copyProperties(uim,um);
			um.setId(uim.getUserId());
			um.setRealname(uim.getRealname());
			um.setShopId(uim.getShopId());
			um.setMobile(uim.getMobile());
			um.setUserName(user.getUserName());
			um.setOpenId(uim.getOpenId());
			um.setUserType(user.getUserType());
		}
		return um;
	}

	//编辑用户，修改员工的名字和描述
	@Override
	public void updateUserInformation(UserInformation u) {
		userInformationDao.editUserInformation(u);
	}

	@Override
	public int addBackgroundUser(UserM userM,String wxUser) {
		int b = 0;//0:成功;1:数据库中没有该手机记录，让他先前台绑定;2:用户类型不为门店店员
		//检测openId是否已经存在
		User user = userDao.findByMobile(userM.getMobile());
		if(user!=null){
			//电话已存在，取出数据库中相对应的数据
			UserInformation userInfo = userInformationDao.findByMobile(userM.getMobile());
			WxUser wx= wxUserDao.getByOpenId(userInfo.getOpenId());
			wx.setUnionid(wxUser);
			wxUserDao.update(wx);
			if(user.getUserType() == "1" || "1".equals(user.getUserType()) ) {
				b = 0;
			}else {
				b = 2;
			}
		}else{
			b = 1;
		}
		return b;
	}

	@Override
	public VerificationCode fingByPhone(String mobile) {
		
		return verificationCodeDao.getVerificationCodeBytype("0", mobile);
	}

	@Override
	public List<UserInformation> findByShopIdAndAccount(String shopId) {
		List<UserInformation> list = userInformationDao.getUserInformationByShopIdAndAccount(shopId);
		if (list != null && list.size() > 0) {
			for(UserInformation uf : list){
				if(uf.getEmployeeAccount().startsWith("B")){
					uf.setRealname("员工");
				}
			}
		}
		return list;
	}

	@Override
	public int editCancelEmpAccount(String openId) {
		// TODO Auto-generated method stub
		return 0;
	}


}
