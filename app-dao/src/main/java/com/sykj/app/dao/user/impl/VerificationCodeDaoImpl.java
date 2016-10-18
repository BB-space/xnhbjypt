package com.sykj.app.dao.user.impl;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.VerificationCodeDao;
import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;
@Repository("verificationCodeDao")
public class VerificationCodeDaoImpl extends BaseDao<VerificationCode>
		implements VerificationCodeDao {

	@Override
	public VerificationCode getVerificationCode(String code, String mobile) {

		return this.get("from VerificationCode t where t.code='"+code+"' and t.mobile='"+mobile+"'");
	}

	@Override
	public void addVerificationCode(VerificationCode verificationCode) {
		this.add(verificationCode);

	}

	@Override
	public void deleteVerificationCode(String id) {


	}

	@Override
	public void updateVerificationCode(VerificationCode verificationCode) {
		this.update(verificationCode);
		
	}

	@Override
	public VerificationCode getVerificationCodeBytype(String type, String mobile) {
		return this.get("from VerificationCode t where t.codeStatus='0' and t.codeType='"+type+"' and t.mobile='"+mobile+"'");
	}

	@Override
	public Pager<VerificationCode> findCode(SystemContext syct,
			VerificationCode verificationCode) {
		StringBuffer hql=new StringBuffer("from VerificationCode t where t.codeStatus='0' and t.codeType='0'");
		if(verificationCode !=null){// 添加查询条件
			if (verificationCode.getMobile() != null && !verificationCode.getMobile().trim().equals("")) {
				hql.append(" and t.mobile like '%%").append(verificationCode.getMobile().trim()).append("%%' ");
			}
		}
		hql.append(" order by t.createDateTime desc");
		return this.find(hql.toString(),syct);
	}



}
