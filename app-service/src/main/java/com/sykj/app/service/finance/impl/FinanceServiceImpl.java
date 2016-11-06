package com.sykj.app.service.finance.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.finance.EntrustTradingDao;
import com.sykj.app.dao.finance.MemberMoneyDao;
import com.sykj.app.dao.finance.RmbOperationRecordDao;
import com.sykj.app.dao.finance.UserxnbDao;
import com.sykj.app.dao.finance.WaitAuditrmbtDao;
import com.sykj.app.dao.finance.WaitAuditrmbwDao;
import com.sykj.app.dao.finance.WaitAuditxnbtDao;
import com.sykj.app.dao.finance.XnbOperationRecordDao;
import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.entity.finance.MemberMoney;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.entity.finance.Userxnb;
import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.entity.finance.WaitAuditxnbt;
import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.finance.PersonFinance;
import com.sykj.app.service.finance.FinanceService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.DateUtil;

@Service("financeService")
public class FinanceServiceImpl extends BaseServiceImpl implements FinanceService{
	
	@Resource
	private MemberMoneyDao memberMoneyDao;
	@Resource
	private UserxnbDao userxnbDao;
	@Resource
	private XnbOperationRecordDao xnbOperationRecordDao;
	@Resource
	private WaitAuditxnbtDao waitAuditxnbtDao;
	@Resource
	private RmbOperationRecordDao rmbOperationRecordDao; 
	@Resource
	private WaitAuditrmbwDao waitAuditrmbwDao;
	@Resource
	private WaitAuditrmbtDao waitAuditrmbtDao;
	@Resource
	private EntrustTradingDao entrustTradingDao;
	
	@Override
	public PersonFinance getPersonFinance(String loginName) {
		
		PersonFinance pf = new PersonFinance();
		
		MemberMoney memberMoney = memberMoneyDao.getMemberMoneyByLoginName(loginName);
		if(memberMoney != null){
			pf.setUserallmoney(memberMoney.getUserallmoney());
			pf.setUserfreezemoney(memberMoney.getUserfreezemoney());
			pf.setUserusablemoney(memberMoney.getUserallmoney() - memberMoney.getUserfreezemoney());
		}
		
		List<Userxnb> list = userxnbDao.getUserxnbByLoginName(loginName);
		if(list.size() > 0){
			for (Userxnb userxnb : list) {
				if("BTC".equals(userxnb.getXnbtype())){
					pf.setUserallnumBTC(userxnb.getUserallnum());
					pf.setUserfreezenumBTC(userxnb.getUserfreezenum());
					pf.setUserusablemoneyBTC(userxnb.getUserallnum() - userxnb.getUserfreezenum());
				}else if("LTC".equals(userxnb.getXnbtype())){
					pf.setUserallnumLTC(userxnb.getUserallnum());
					pf.setUserfreezenumLTC(pf.getUserfreezemoney());
					pf.setUserusablemoneyLTC(userxnb.getUserallnum() - userxnb.getUserfreezenum());
				}else if("SLM".equals(userxnb.getXnbtype())){
					pf.setUserallnumSLM(userxnb.getUserallnum());
					pf.setUserfreezenumSLM(userxnb.getUserfreezenum());
					pf.setUserusablemoneySLM(userxnb.getUserallnum() - userxnb.getUserfreezenum());
				}
			}
		}
		
		return pf;
	}

	@Override
	public void addXnbOperationRecord(XnbOperationRecord xnbOperationRecord) {
		
		WaitAuditxnbt waitAuditxnbt = new WaitAuditxnbt();
		waitAuditxnbt.setWaitauditxnbtId(UUID.randomUUID().toString());
		waitAuditxnbt.setCreatedatetime(DateUtil.format(new Date()));
		waitAuditxnbt.setUpdatedatetime(waitAuditxnbt.getCreatedatetime());
		waitAuditxnbt.setLoginname(xnbOperationRecord.getLoginname());
		waitAuditxnbt.setUsernickname(xnbOperationRecord.getUsernickname());
		waitAuditxnbt.setUserrealname(xnbOperationRecord.getUserrealname());
		waitAuditxnbt.setXnbtype(xnbOperationRecord.getXnbtype());
		waitAuditxnbt.setStatus("等待提现");
		waitAuditxnbt.setTradingtype("虚拟币提现");
		waitAuditxnbt.setNum(xnbOperationRecord.getNum());
		waitAuditxnbt.setPoundage(xnbOperationRecord.getPoundage());
		waitAuditxnbt.setWithdrawaladdress(xnbOperationRecord.getWithdrawaladdress());
		
		
		xnbOperationRecord.setXnboperationrecordId(waitAuditxnbt.getWaitauditxnbtId());
		xnbOperationRecord.setCreatedatetime(waitAuditxnbt.getCreatedatetime());
		xnbOperationRecord.setUpdatedatetime(waitAuditxnbt.getCreatedatetime());
		xnbOperationRecord.setTradingtype("虚拟币提现");
		//手续费
		xnbOperationRecord.setPoundage(0.0);
		xnbOperationRecord.setStatus("等待提现");
		
		waitAuditxnbtDao.add(waitAuditxnbt);
		xnbOperationRecordDao.addXnbOperationRecord(xnbOperationRecord);
	}

	@Override
	public Pager<XnbOperationRecord> findXnbOperationRecord(SystemContext syct, XnbOperationRecord xnbOperationRecord) {
		return xnbOperationRecordDao.findXnbOperationRecord(syct, xnbOperationRecord);
	}

	@Override
	public void addWithdrawCny(WaitAuditrmbw waitAuditrmbw) {
		
		waitAuditrmbw.setWaitauditrmbwId(UUID.randomUUID().toString());
		waitAuditrmbw.setCreatedatetime(DateUtil.format(new Date()));
		waitAuditrmbw.setUpdatedatetime(waitAuditrmbw.getCreatedatetime());
		waitAuditrmbw.setType("人民币提现");
		waitAuditrmbw.setStatus("等待提现");
		waitAuditrmbw.setPoundage(0.0);
		
		RmbOperationRecord record = new RmbOperationRecord();
		record.setRmboperationrecordId(waitAuditrmbw.getWaitauditrmbwId());
		record.setCreatedatetime(waitAuditrmbw.getCreatedatetime());
		record.setUpdatedatetime(waitAuditrmbw.getCreatedatetime());
		record.setLoginname(waitAuditrmbw.getLoginname());
		record.setUsernickname(waitAuditrmbw.getUsernickname());
		record.setUserrealname(waitAuditrmbw.getUserrealname());
		record.setCollectionbank(waitAuditrmbw.getBank());
		record.setBankaccount(waitAuditrmbw.getPaymentaccount());
		record.setTradingtype(waitAuditrmbw.getType());
		record.setStatus(waitAuditrmbw.getStatus());
		record.setMoney(waitAuditrmbw.getMoney());
		record.setPoundage(waitAuditrmbw.getPoundage());
		record.setBankaddress(waitAuditrmbw.getBankaddress());
		
		waitAuditrmbwDao.add(waitAuditrmbw);
		rmbOperationRecordDao.add(record);
		
	}
	
	@Override
	public void addWaitAuditrmbt(WaitAuditrmbt waitAuditrmbt) {
		
		waitAuditrmbt.setWaitauditrmbtId(UUID.randomUUID().toString());
		waitAuditrmbt.setCreatedatetime(DateUtil.format(new Date()));
		waitAuditrmbt.setUpdatedatetime(waitAuditrmbt.getCreatedatetime());
		waitAuditrmbt.setStatus("等待银行到账");
		waitAuditrmbt.setPoundage(0.0);
		
		RmbOperationRecord record = new RmbOperationRecord();
		record.setRmboperationrecordId(waitAuditrmbt.getWaitauditrmbtId());
		record.setCreatedatetime(waitAuditrmbt.getCreatedatetime());
		record.setUpdatedatetime(waitAuditrmbt.getCreatedatetime());
		record.setLoginname(waitAuditrmbt.getLoginname());
		record.setUsernickname(waitAuditrmbt.getUsernickname());
		record.setUserrealname(waitAuditrmbt.getUserrealname());
		record.setCollectionbank(waitAuditrmbt.getBank());
		record.setBankaccount(waitAuditrmbt.getRemittanceaccount());
		record.setTradingtype(waitAuditrmbt.getCztype());
		record.setStatus(waitAuditrmbt.getStatus());
		record.setMoney(waitAuditrmbt.getMoney());
		record.setPoundage(waitAuditrmbt.getPoundage());
		
		waitAuditrmbtDao.add(waitAuditrmbt);
		rmbOperationRecordDao.add(record);
	}

	@Override
	public Pager<RmbOperationRecord> findRmbOperationRecord(SystemContext syct, RmbOperationRecord rmbOperationRecord) {
		return rmbOperationRecordDao.findRmbOperationRecord(syct, rmbOperationRecord);
	}

	@Override
	public Pager<EntrustTrading> findEntrustTrading(SystemContext syct, EntrustTrading entrustTrading) {
		return entrustTradingDao.findEntrustTrading(syct, entrustTrading);
	}
	
	
}
