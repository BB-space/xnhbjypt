package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.FranchiseeDao;
import com.sykj.app.entity.user.Franchisee;
import com.sykj.common.dao.BaseDao;

/**
 * @author wjl 2016年9月29日 上午10:53:20
 */
@Repository("franchiseeDao")
public class FranchiseeDaoImpl extends BaseDao<Franchisee> implements FranchiseeDao{

	@Override
	public void addFranchisee(Franchisee franchisee) {
		this.add(franchisee);
	}

	@Override
	public void delFranchiss(Franchisee franchisee) {
		this.delete(franchisee);
	}

	@Override
	public List<Franchisee> findByUserId(String userId) {
		String hql = "from Franchisee t where t.userId = '"+userId+"'";
		return this.list(hql);
	}

}
