package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.VmTypeAddress;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface VmTypeAddressDao extends IBaseDao<VmTypeAddress>{

	/**
	 * 查找虚拟币可用地址
	 */
	public VmTypeAddress getVmTypeAddress(String id);
	/**
	 * 添加虚拟币可用地址
	 */
	public void addVmTypeAddress(VmTypeAddress vmTypeAddress);
	
	/**
	 * 获得所有虚拟币可用地址（分页）
	 */
	public Pager<VmTypeAddress> findVmTypeAddress(SystemContext syct, VmTypeAddress vmTypeAddress);
	
}
