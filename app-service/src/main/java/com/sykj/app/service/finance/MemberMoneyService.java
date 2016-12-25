package com.sykj.app.service.finance;

import com.sykj.app.entity.finance.MemberMoney;


/**
 * 用户人民币
 * @author lsq
 *
 */
public interface MemberMoneyService {

	/**
	 * 添加用户人民币
	 */
	public void addMemberMoney(MemberMoney mm);
	
	/**
	 * 根据登录名查询用户人民币
	 */
	public MemberMoney getMemberMoneyByLoginName(String loginName);
	
}
