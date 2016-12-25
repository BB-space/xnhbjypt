package com.sykj.app.service.finance;

import java.util.List;

import com.sykj.app.entity.finance.Userxnb;


/**
 * 用户虚拟币
 * @author lsq
 *
 */
public interface UserxnbService {

	/**
	 * 添加用户虚拟币
	 */
	public void addUserxnb(Userxnb xnb);
	
	/**
	 * 根据登录名，类型查询用户虚拟币
	 */
	public Userxnb getUserxnbByLoginNameAndType(String loginName, String xnbtype);
	
	/**
	 * 获取用户所有虚拟币
	 */
	public List<Userxnb> getUserxnbByLoginName(Userxnb xnb);
	
	
	
}
