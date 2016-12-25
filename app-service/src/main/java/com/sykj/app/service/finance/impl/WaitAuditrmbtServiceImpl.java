package com.sykj.app.service.finance.impl;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.finance.MemberMoneyDao;
import com.sykj.app.dao.finance.RmbOperationRecordDao;
import com.sykj.app.dao.finance.WaitAuditrmbtDao;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.service.finance.WaitAuditrmbtService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.DateUtil;

@Service("waitAuditrmbtService")
public class WaitAuditrmbtServiceImpl extends BaseServiceImpl implements WaitAuditrmbtService{

	@Resource
	private WaitAuditrmbtDao waitAuditrmbtDao;
	@Resource
	private RmbOperationRecordDao rmbOperationRecordDao;
	@Resource
	private MemberMoneyDao memberMoneyDao;
	
	@Override
	public void addWaitAuditrmbt(WaitAuditrmbt rmbt) {
		
		//保存到待审核列表
		rmbt.setWaitauditrmbtId(UUID.randomUUID().toString());
		rmbt.setCreatedatetime(DateUtil.format(new Date()));
		rmbt.setCreateuser(rmbt.getLoginname());
		rmbt.setStatus("等待银行到账");
		rmbt.setPoundage(0.0);
		waitAuditrmbtDao.addWaitAuditrmbt(rmbt);
		
		//保存到虚拟币操作列表
		RmbOperationRecord record = new RmbOperationRecord();
		record.setRmboperationrecordId(rmbt.getWaitauditrmbtId());
		record.setCreatedatetime(rmbt.getCreatedatetime());
		record.setCreateuser(rmbt.getCreateuser());
		record.setStatus(rmbt.getStatus());
		record.setLoginname(rmbt.getLoginname());
		record.setUsernickname(rmbt.getUsernickname());
		record.setUserrealname(rmbt.getUserrealname());
		record.setTradingtype(rmbt.getCztype());
		record.setMoney(rmbt.getMoney());
		record.setPoundage(rmbt.getPoundage());
		record.setBankaccount(rmbt.getBank());
		record.setBankaddress(rmbt.getBank());
		rmbOperationRecordDao.add(record);
	}

	@Override
	public void cancelWaitAuditrmbtById(String id) {
		WaitAuditrmbt rmbt = waitAuditrmbtDao.getWaitAuditrmbt(id);
		if(rmbt != null){
			//跟新待审核虚拟币提现列表
			rmbt.setStatus("取消充值");
			rmbt.setUpdatedatetime(DateUtil.format(new Date()));
			rmbt.setUpdateuser(rmbt.getLoginname());
			waitAuditrmbtDao.update(rmbt);
			
			//更新虚拟币操作记录
			RmbOperationRecord rmbRecord = rmbOperationRecordDao.getRmbOperationRecord(id);
			rmbRecord.setUpdatedatetime(rmbt.getUpdatedatetime());
			rmbRecord.setUpdateuser(rmbt.getLoginname());
			rmbRecord.setStatus(rmbt.getStatus());
			rmbOperationRecordDao.update(rmbRecord);
			
		}
	}
}
