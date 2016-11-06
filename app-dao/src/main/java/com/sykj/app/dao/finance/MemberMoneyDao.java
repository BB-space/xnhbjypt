package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.MemberMoney;
import com.sykj.common.dao.IBaseDao;

public interface MemberMoneyDao extends IBaseDao<MemberMoney>{

	/**
	 * 查找会员资金
	 */
	public MemberMoney getMemberMoney(String id);
	

	/**
	 * 查找会员资金
	 */
	public MemberMoney getMemberMoneyByLoginName(String loginName);
	
	
	/**
	 * 添加会员资金
	 */
	public void addMemberMoney(MemberMoney memberMoney);
}
