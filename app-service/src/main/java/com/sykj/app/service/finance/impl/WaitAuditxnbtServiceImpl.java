package com.sykj.app.service.finance.impl;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.finance.UserxnbDao;
import com.sykj.app.dao.finance.WaitAuditxnbtDao;
import com.sykj.app.dao.finance.XnbOperationRecordDao;
import com.sykj.app.entity.finance.Userxnb;
import com.sykj.app.entity.finance.WaitAuditxnbt;
import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.service.finance.WaitAuditxnbtService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.DateUtil;

@Service("waitAuditxnbtService")
public class WaitAuditxnbtServiceImpl extends BaseServiceImpl implements WaitAuditxnbtService{

	@Resource
	private WaitAuditxnbtDao waitAuditxnbtDao;
	@Resource
	private XnbOperationRecordDao xnbOperationRecordDao;
	@Resource
	private UserxnbDao userxnbDao;
	
	@Override
	public void addWaitAuditxnbt(WaitAuditxnbt xnbt) {
		
		//保存到待审核列表
		xnbt.setWaitauditxnbtId(UUID.randomUUID().toString());
		xnbt.setCreatedatetime(DateUtil.format(new Date()));
		xnbt.setCreateuser(xnbt.getLoginname());
		xnbt.setStatus("等待提现");
		xnbt.setTradingtype("虚拟币提现");
		xnbt.setPoundage(0.0);
		waitAuditxnbtDao.addWaitAuditxnbt(xnbt);
		
		//保存到虚拟币操作列表
		XnbOperationRecord record = new XnbOperationRecord();
		record.setCreatedatetime(xnbt.getCreatedatetime());
		record.setCreateuser(xnbt.getCreateuser());
		record.setStatus(xnbt.getStatus());
		record.setLoginname(xnbt.getLoginname());
		record.setUsernickname(xnbt.getUsernickname());
		record.setUserrealname(xnbt.getUserrealname());
		record.setXnbtype(xnbt.getXnbtype());
		record.setTradingtype(xnbt.getTradingtype());
		record.setNum(xnbt.getNum());
		record.setPoundage(xnbt.getPoundage());
		record.setWithdrawaladdress(xnbt.getWithdrawaladdress());
		xnbOperationRecordDao.add(record);
		
		//修改用户对应虚拟币的冻结币数量
		Userxnb uxnb = userxnbDao.getUserxnbByLoginNameAndType(xnbt.getLoginname(), xnbt.getXnbtype());
		if(uxnb != null){
			uxnb.setUserfreezenum(uxnb.getUserfreezenum() + xnbt.getNum());
			uxnb.setUpdatedatetime(xnbt.getUpdatedatetime());
			uxnb.setUpdateuser(xnbt.getUpdateuser());
			userxnbDao.update(uxnb);
		}
	}

	@Override
	public void cancelWaitAuditxnbtById(String id) {
		WaitAuditxnbt xnbt = waitAuditxnbtDao.getWaitAuditxnbt(id);
		if(xnbt != null){
			//跟新待审核虚拟币提现列表
			xnbt.setStatus("取消提现");
			xnbt.setUpdatedatetime(DateUtil.format(new Date()));
			xnbt.setUpdateuser(xnbt.getLoginname());
			waitAuditxnbtDao.update(xnbt);
			
			//更新虚拟币操作记录
			XnbOperationRecord xnbRecord = xnbOperationRecordDao.getXnbOperationRecord(id);
			xnbRecord.setUpdatedatetime(xnbt.getUpdatedatetime());
			xnbRecord.setUpdateuser(xnbt.getLoginname());
			xnbRecord.setStatus(xnbt.getStatus());
			xnbOperationRecordDao.update(xnbRecord);
			
			//更新虚拟币
			Userxnb uxnb = userxnbDao.getUserxnbByLoginNameAndType(xnbt.getLoginname(), xnbt.getXnbtype());
			uxnb.setUpdatedatetime(xnbt.getUpdatedatetime());
			uxnb.setUpdateuser(xnbt.getLoginname());
			uxnb.setUserfreezenum(uxnb.getUserfreezenum() - xnbt.getNum());
			userxnbDao.update(uxnb);
		}
		
	}

}
