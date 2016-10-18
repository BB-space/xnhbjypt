package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.AccountComfirm;
import com.sykj.common.dao.IBaseDao;

public interface AccountComfirmDao extends IBaseDao<AccountComfirm>{

	public List<AccountComfirm> getMonth(String shopId, String userId,int month);
}
