package com.sykj.app.dao.finance;

import com.sykj.app.entity.finance.VmType;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface VmTypeDao extends IBaseDao<VmType>{

	/**
	 * 查找虚拟币类型
	 */
	public VmType getVmType(String id);
	/**
	 * 添加虚拟币类型
	 */
	public void addVmType(VmType vmType);
	
	/**
	 * 获得所有虚拟币类型（分页）
	 */
	public Pager<VmType> findVmType(SystemContext syct, VmType vmType);
	
}
