package com.sykj.app.dao.user;

import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.common.dao.IBaseDao;

public interface VerificationCodeDao extends IBaseDao<VerificationCode>{

	/**
	 * 根据手机号码和验证码查找VerificationCode
	 * @return
	 */
	public VerificationCode getVerificationCode(String code,String mobile);
	
	/**
	 * 根据手机号码和类型查找VerificationCode
	 * @return
	 */
	public VerificationCode getVerificationCodeBytype(String type,String mobile);
	
	/**
	 * 添加VerificationCode
	 */
	public void addVerificationCode(VerificationCode verificationCode);
	
	/**
	 * 删除VerificationCode
	 */
	public void deleteVerificationCode(String id);
	
	/**
	 * 修改VerificationCode
	 */
	public void updateVerificationCode(VerificationCode verificationCode);
	
	/**
	 * 获得所有用户（分页）
	 */
	public Pager<VerificationCode> findCode(SystemContext syct, VerificationCode verificationCode);
}
