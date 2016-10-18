package com.sykj.app.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.user.VerificationCodeDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.user.VerificationCodeService;

@Service("verificationCodeService")
public class VerificationCodeServiceImpl implements VerificationCodeService {
	@Autowired
	private VerificationCodeDao verificationCodeDao;

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, VerificationCode code) {
		EasyuiDataGridJson j=new EasyuiDataGridJson();
		Pager<VerificationCode> pCode = verificationCodeDao.findCode(syct, code);
		j.setRows(pCode.getDatas());
		j.setTotal(pCode.getTotalCount());
		return j;
	}

}
