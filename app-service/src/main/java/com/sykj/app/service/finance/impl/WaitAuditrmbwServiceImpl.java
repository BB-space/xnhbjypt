package com.sykj.app.service.finance.impl;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.finance.MemberMoneyDao;
import com.sykj.app.dao.finance.RmbOperationRecordDao;
import com.sykj.app.dao.finance.WaitAuditrmbwDao;
import com.sykj.app.entity.finance.MemberMoney;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.service.finance.WaitAuditrmbwService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.DateUtil;

@Service("waitAuditrmbwService")
public class WaitAuditrmbwServiceImpl extends BaseServiceImpl implements WaitAuditrmbwService{

	@Resource
	private WaitAuditrmbwDao waitAuditrmbwDao;
	@Resource
	private RmbOperationRecordDao rmbOperationRecordDao;
	@Resource
	private MemberMoneyDao memberMoneyDao;
	
	@Override
	public void addWaitAuditrmbw(WaitAuditrmbw rmbw) {
		
		//保存到待审核列表
		rmbw.setWaitauditrmbwId(UUID.randomUUID().toString());
		rmbw.setCreatedatetime(DateUtil.format(new Date()));
		rmbw.setCreateuser(rmbw.getLoginname());
		rmbw.setStatus("等待提现");
		rmbw.setPoundage(0.0);
		rmbw.setType("人民币提现");
		waitAuditrmbwDao.addWaitAuditrmbw(rmbw);
		
		//保存到人民币操作列表
		RmbOperationRecord record = new RmbOperationRecord();
		record.setRmboperationrecordId(rmbw.getWaitauditrmbwId());
		record.setCreatedatetime(rmbw.getCreatedatetime());
		record.setCreateuser(rmbw.getCreateuser());
		record.setLoginname(rmbw.getLoginname());
		record.setUsernickname(rmbw.getUsernickname());
		record.setUserrealname(rmbw.getUserrealname());
		record.setStatus(rmbw.getStatus());
		record.setTradingtype(rmbw.getType());
		record.setMoney(rmbw.getMoney());
		record.setPoundage(rmbw.getPoundage());
		record.setBankaccount(rmbw.getBank());
		record.setBankaddress(rmbw.getBankaddress());
		record.setDiscription(rmbw.getDescription());
		rmbOperationRecordDao.add(record);
		
		//修改用户对应人民币的冻结币数量
		MemberMoney mm = memberMoneyDao.getMemberMoneyByLoginName(rmbw.getLoginname());
		if(mm != null){
			mm.setUserfreezemoney(mm.getUserfreezemoney() + rmbw.getMoney());
			mm.setUpdatedatetime(rmbw.getUpdatedatetime());
			mm.setUpdateuser(rmbw.getUpdateuser());
			memberMoneyDao.update(mm);
		}
	}

	@Override
	public void cancelWaitAuditrmbwById(String id) {
		WaitAuditrmbw rmbw = waitAuditrmbwDao.getWaitAuditrmbw(id);
		if(rmbw != null){
			//更新待审核人民币提现列表
			rmbw.setStatus("取消提现");
			rmbw.setUpdatedatetime(DateUtil.format(new Date()));
			rmbw.setUpdateuser(rmbw.getLoginname());
			waitAuditrmbwDao.update(rmbw);
			
			//更新人民币操作记录
			RmbOperationRecord rmbRecord = rmbOperationRecordDao.getRmbOperationRecord(id);
			rmbRecord.setUpdatedatetime(rmbw.getUpdatedatetime());
			rmbRecord.setUpdateuser(rmbw.getLoginname());
			rmbRecord.setStatus(rmbw.getStatus());
			rmbOperationRecordDao.update(rmbRecord);
			
			//更新人民币
			MemberMoney mm = memberMoneyDao.getMemberMoneyByLoginName(rmbw.getLoginname());
			mm.setUpdatedatetime(rmbw.getUpdatedatetime());
			mm.setUpdateuser(rmbw.getLoginname());
			mm.setUserfreezemoney(mm.getUserfreezemoney() - rmbw.getMoney());
			memberMoneyDao.update(mm);
		}
		
	}

}
