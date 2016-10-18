package com.sykj.app.service.user;

import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.SystemContext;

public interface VerificationCodeService {
	
	/**
	 * 查询注册验证码列表
	 * @param dg
	 * @param City
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, VerificationCode code);

}
