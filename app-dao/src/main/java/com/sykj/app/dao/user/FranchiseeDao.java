package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.Franchisee;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年9月29日 上午10:52:38
 */
public interface FranchiseeDao extends IBaseDao<Franchisee>{
	
	public void addFranchisee(Franchisee franchisee);
	
	public void delFranchiss(Franchisee franchisee);
	
	public List<Franchisee> findByUserId(String userId);

}
