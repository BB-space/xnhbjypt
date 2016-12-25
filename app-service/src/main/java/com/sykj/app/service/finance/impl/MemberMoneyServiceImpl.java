package com.sykj.app.service.finance.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.finance.MemberMoneyDao;
import com.sykj.app.entity.finance.MemberMoney;
import com.sykj.app.service.finance.MemberMoneyService;
import com.sykj.app.service.impl.BaseServiceImpl;

@Service("memberMoneyService")
public class MemberMoneyServiceImpl extends BaseServiceImpl implements MemberMoneyService{

	@Resource
	private MemberMoneyDao memberMoneyDao;

	@Override
	public void addMemberMoney(MemberMoney xnb) {
		
		memberMoneyDao.addMemberMoney(xnb);
	}

	@Override
	public MemberMoney getMemberMoneyByLoginName(String loginName) {
		return memberMoneyDao.getMemberMoneyByLoginName(loginName);
	}

	
}
