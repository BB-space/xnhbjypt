package com.sykj.app.service.user;

import com.sykj.app.model.Json;

public interface NationalUserService {

	/**
	 * 判断是否是老会员
	 */
	public Json judgeUser(String openId,String sysDictionaryId);
}
