package com.sykj.app.service.user;

import java.util.List;

import com.sykj.app.entity.user.Franchisee;

/**
 * @author wjl 2016年9月29日 上午10:51:29
 */
public interface FranchiseeService {

	/**
	 * 更新加盟商管辖的门店
	 * @param userId
	 * @param shopIds
	 */
	public void updateFranchisee(String userId,String shopIds);
	/**
	 * 根据userid查找
	 */
	public List<Franchisee> getUserId(String userId);
}
