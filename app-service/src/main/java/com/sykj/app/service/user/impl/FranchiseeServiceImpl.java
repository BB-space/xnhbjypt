package com.sykj.app.service.user.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.user.FranchiseeDao;
import com.sykj.app.entity.user.Franchisee;
import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.FranchiseeService;

/**
 * @author wjl 2016年9月29日 上午10:51:44
 */
@Service("franchiseeService")
public class FranchiseeServiceImpl extends BaseServiceImpl implements FranchiseeService{

	@Resource
	private FranchiseeDao franchiseeDao;
	
	@Override
	public void updateFranchisee(String userId, String shopIds) {
		String[] shops = shopIds.split(",");
		List<Franchisee> list = franchiseeDao.findByUserId(userId);
		//将原管辖分中心记录删除
		for(Franchisee franchisee : list) {
			franchiseeDao.delFranchiss(franchisee);
		}
		if(!shops.equals("") && shops != null) {
			//将新管辖分中心记录
			for(int i = 0 ; i < shops.length ; i++) {
				if(!shops[i].equals("") && shops[i] != null && shops[i] != "") {
					Franchisee franchisee = new Franchisee();
					franchisee.setId(UUID.randomUUID().toString());
					franchisee.setUserId(userId);
					franchisee.setShopId(shops[i]);
					franchisee.setCreateTime(new Date());
					franchiseeDao.addFranchisee(franchisee);
				}
			}
		}
	}

	@Override
	public List<Franchisee> getUserId(String userId) {
		return franchiseeDao.findByUserId(userId);
	}

}
