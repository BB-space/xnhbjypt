package com.sykj.app.service.user.impl;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.user.FrontUserDao;
import com.sykj.app.dao.user.FrontUserInfoDao;
import com.sykj.app.entity.user.FrontUser;
import com.sykj.app.entity.user.FrontUserInfo;
import com.sykj.app.entity.user.User;
import com.sykj.app.model.FrontUserM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.FrontUserService;
import com.sykj.app.util.SecurityUtil;
import com.sykj.app.util.SendEmail;

@Service("frontUserService")
public class FrontUserServiceImpl extends BaseServiceImpl implements FrontUserService{

	@Resource
	private FrontUserDao frontUserDao;
	@Resource
	private FrontUserInfoDao frontUserInfoDao;
	
	
	@Override
	public FrontUserM register(FrontUserM fum) {
		FrontUser frontUser = new FrontUser();
		FrontUserInfo frontUserInfo = new FrontUserInfo();
		FrontUserM frontUserM = new FrontUserM();
		
		if("mobile".equals(fum.getRegType())){  //手机注册
			frontUser.setUserName(fum.getMobile());
			frontUserInfo.setMobile(fum.getMobile());
			frontUserInfo.setMobileStatus("1");
			frontUserInfo.setLocation(fum.getLocation());
			frontUserInfo.setEmailStatus("0");
			frontUserInfo.setNickName(fum.getMobile());
		}else { //邮箱注册
			frontUser.setUserName(fum.getEmail());
			frontUserInfo.setEmail(fum.getEmail());
			frontUserInfo.setEmailStatus("0");
			frontUserInfo.setMobileStatus("0");
			//设置昵称
			int location = fum.getEmail().indexOf("@");
			String nickName = fum.getEmail().substring(0, location);
			frontUserInfo.setNickName(nickName);
		}
		frontUser.setId(UUID.randomUUID().toString());
		frontUser.setPassword(SecurityUtil.md5(fum.getPassword()));
		frontUser.setCreateTime(new Date());
		
		FrontUser fu = frontUserDao.add(frontUser);
		if(fu != null){
			frontUserInfo.setId(UUID.randomUUID().toString());
			int uid = frontUserInfoDao.getMaxUID();
			frontUserInfo.setUid(uid + 1);
			frontUserInfo.setUuid(UUID.randomUUID().toString());
			frontUserInfo.setUserId(fu.getId());
			frontUserInfo.setMembeLevel(0);
			frontUserInfo.setCreateTime(new Date());
			frontUserInfoDao.add(frontUserInfo);
			
			if("email".equals(fum.getRegType())){
				//发送注册账号激活邮件
				sendEmail(fum.getEmail(), frontUserInfo.getUid(), frontUserInfo.getUuid());
			}
			
			BeanUtils.copyProperties(frontUserInfo, frontUserM);
			frontUserM.setId(frontUser.getId());
			frontUserM.setUserName(frontUser.getUserName());
			frontUserM.setPassword(frontUser.getPassword());
			
		}
		return frontUserM;
	}

	@Override
	public void sendEmail(String email, int uid, String uuid){
		int location = email.indexOf("@");
		String user = email.substring(0, location);
		
		 ///邮件的内容  
        StringBuffer sb=new StringBuffer("尊敬的用户：" + user + "</br>");  
        sb.append("您好！</br>");  
        sb.append("感谢您注册数字资产交易平台，请点击以下链接完成账号激活：<a href=\"http://localhost:8080/xnhbjypt/test.do?validate&uid=");  
        sb.append(uid);
        sb.append("&uuid=");   
        sb.append(uuid);  
        sb.append("\">http://localhost:8080/xnhbjypt/test.do?validate&uid=");   
        sb.append(uid);
        sb.append("&uuid=");   
        sb.append(uuid);  
        sb.append("</a>");  
        
        sb.append("————————————————————————————————————————————</br>");  
        sb.append("系统发信， 请勿回复</br>");  
        sb.append("数字资产交易平台官方网站：xxxxxx </br>");  
        //发送邮件  
        SendEmail.send(email, sb.toString());  
        
	}
	
	
	@Override
	public User vMobile(String userName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FrontUserM login(String userName, String password) {
		FrontUserM um = null;
		FrontUser frontUser = frontUserDao.getUserByNamePassword(userName, SecurityUtil.md5(password));
		if(frontUser!=null){
			um = new FrontUserM();
			FrontUserInfo uim = frontUserInfoDao.getFrontUserInfoByUserId(frontUser.getId());
			BeanUtils.copyProperties(uim, um);
			um.setId(uim.getUserId());
			um.setUserName(frontUser.getUserName());
			um.setPassword(frontUser.getPassword());
			System.out.println("ddd:" + um);
		}
		return um;
	}

	@Override
	public int updatePassword(FrontUserM frontUserM) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public FrontUserInfo getId(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkUserName(String userName) {
		
		FrontUser fu = frontUserDao.checkUserName(userName);
		if(fu != null)
			return true;
		return false;
	}

	@Override
	public int validate(String uid, String uuid) {
		FrontUserInfo fui =  frontUserInfoDao.getFrontUserInfoByUID(uid);
		//验证用户是否存
		if(fui != null){
			//验证用户激活状态 
			if("0".equals(fui.getEmailStatus())){
				//验证激活码是否正确
				if(uuid.equals(fui.getUuid())){
					//激活成功， //并更新用户的激活状态，为已激活 
					fui.setEmailStatus("1");
					fui.setUpdateTime(new Date());
					frontUserInfoDao.update(fui);
					return 0;
				}else {
					//激活码不正确
					return -3;
				}
			}else {
				//邮箱已激活
				return -2;
			}
		}else {
			//该邮箱未注册（邮箱地址不存在）
			return -1;
		}
	}

	@Override
	public boolean certification(String userId) {
		
		FrontUserInfo fui = frontUserInfoDao.certifiUser(userId);
		if(fui != null)
			return true;
		return false;
	}

	@Override
	public void validateIdentity(FrontUserM m) {
		FrontUserInfo fui = frontUserInfoDao.getFrontUserInfoByUserId(m.getId());
		if(fui != null){
			fui.setRealName(m.getRealName().trim());
			fui.setCardType(m.getCardType());
			fui.setCardNumber(m.getCardNumber().trim());
			fui.setUpdateTime(new Date());
			frontUserInfoDao.update(fui);
		}
	}

	@Override
	public void updateNickName(FrontUserM m) {
		
		FrontUserInfo fui = frontUserInfoDao.getFrontUserInfoByUserId(m.getId());
		if(fui != null){
			fui.setNickName(m.getNickName());
			fui.setUpdateTime(new Date());
			frontUserInfoDao.update(fui);
		}
	}

	@Override
	public void saveEmail(FrontUserM m) {
		
		FrontUserInfo fui = frontUserInfoDao.getFrontUserInfoByUserId(m.getId());
		if(fui != null){
			fui.setEmail(m.getEmail());
			fui.setUpdateTime(new Date());
			frontUserInfoDao.update(fui);
		}
	}

	@Override
	public void saveMobile(FrontUserM m) {
		
		FrontUserInfo fui = frontUserInfoDao.getFrontUserInfoByUserId(m.getId());
		if(fui != null){
			fui.setMobile(m.getMobile());
			fui.setLocation(m.getLocation());
			fui.setMobileStatus(m.getMobileStatus());
			fui.setUpdateTime(new Date());
			frontUserInfoDao.update(fui);
		}
	}

	@Override
	public int changePassword(FrontUserM m) {
		FrontUser fu = frontUserDao.getUser(m.getId());
		if(fu != null){
			fu.setPassword(SecurityUtil.md5(m.getPassword()));
			fu.setUpdateTime(new Date());
			frontUserDao.update(fu);
		}
		return 0;
	}
	
	
}
