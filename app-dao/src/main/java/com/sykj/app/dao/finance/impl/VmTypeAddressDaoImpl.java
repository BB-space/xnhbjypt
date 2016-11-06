package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.VmTypeAddressDao;
import com.sykj.app.entity.finance.VmTypeAddress;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("vmTypeAddressDao")
public class VmTypeAddressDaoImpl extends BaseDao<VmTypeAddress> implements VmTypeAddressDao{

	@Override
	public VmTypeAddress getVmTypeAddress(String id) {
		return this.get("from VmTypeAddress t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addVmTypeAddress(VmTypeAddress vmTypeAddress) {
		
		this.add(vmTypeAddress);
	}
	
	@Override
	public Pager<VmTypeAddress> findVmTypeAddress(SystemContext syct, VmTypeAddress vmTypeAddress) {
		StringBuffer hql = new StringBuffer("from VmTypeAddress t where 1=1");
		if(vmTypeAddress !=null){// 添加查询条件
			/*if (vmTypeAddress.getLoginname() != null && !vmTypeAddress.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(vmTypeAddress.getLoginname().trim()).append("' ");
			}*/
		}
		return this.find(hql.toString(),syct);
	}

}
	
