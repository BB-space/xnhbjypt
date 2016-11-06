package com.sykj.app.dao.finance.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.finance.VmTypeDao;
import com.sykj.app.entity.finance.VmType;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("vmTypeDao")
public class VmTypeDaoImpl extends BaseDao<VmType> implements VmTypeDao{

	@Override
	public VmType getVmType(String id) {
		return this.get("from VmType t where t.membermomeyId='"+id+"'");
	}

	@Override
	public void addVmType(VmType vmType) {
		
		this.add(vmType);
	}
	
	@Override
	public Pager<VmType> findVmType(SystemContext syct, VmType vmType) {
		StringBuffer hql = new StringBuffer("from VmType t where 1=1");
		if(vmType !=null){// 添加查询条件
			/*if (vmType.getLoginname() != null && !vmType.getLoginname().trim().equals("")) {
				hql.append(" and t.loginname = '").append(vmType.getLoginname().trim()).append("' ");
			}*/
		}
		return this.find(hql.toString(),syct);
	}

}
	
