package com.sykj.app.dao.user;

import com.sykj.app.entity.user.NationalUser;
import com.sykj.common.dao.IBaseDao;

public interface NationalUserDao extends IBaseDao<NationalUser>{

	/**
	 * 根据mobile获取
	 */
	public NationalUser getByMobile(String mobile,String sysdictionaryId);
}
