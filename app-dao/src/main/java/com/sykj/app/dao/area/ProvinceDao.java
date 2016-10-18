package com.sykj.app.dao.area;

import java.util.List;

import com.sykj.app.entity.area.Province;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface ProvinceDao extends IBaseDao<Province>{

	/**
	 * 查找省份
	 */
	public Province getProvince(String id);
	
	/**
	 * 删除省份
	 */
	public void deleteProvince(String id);
	
	
	/**
	 * 获得所有省份（分页）
	 */
	public Pager<Province> findProvince(SystemContext syct, Province Province);
	
	/**
	 * 获得所有省份
	 */
	public List<Province> getAllProvince();
	/**
	 * 获取有直营门店的省份
	 */
	public List<Province> getZYShopProvince(String shopType);
}
