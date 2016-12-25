package com.sykj.app.dao.finance;

import java.util.List;

import com.sykj.app.entity.finance.Userxnb;
import com.sykj.common.dao.IBaseDao;

public interface UserxnbDao extends IBaseDao<Userxnb>{

	/**
	 * 查找会员虚拟币
	 */
	public Userxnb getUserxnb(String id);
	
	/**
	 * 登录名，类型查询用户虚拟币
	 */
	public Userxnb getUserxnbByLoginNameAndType(String loginName, String xnbtype);
	
	/**
	 * 查找会员虚拟币
	 */
	public List<Userxnb> getUserxnbByLoginName(String loginName);
	
	
	
	/**
	 * 添加会员虚拟币
	 */
	public void addUserxnb(Userxnb userxnb);
}
