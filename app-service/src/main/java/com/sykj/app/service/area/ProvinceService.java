package com.sykj.app.service.area;

import java.util.List;

import com.sykj.app.entity.area.Province;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.SystemContext;

public interface ProvinceService {

	/**
	 * 添加省份
	 * @param Province
	 */
	public Province addProvince(Province province);
	
	/**
	 * 删除省份
	 * @param Province
	 */
	public void deleteProvince(String ids);
	
	/**
	 * 编辑省份
	 */
	public Province editProvince(Province province);
	
	/**
	 * 查询省份列表
	 * @param dg
	 * @param Province
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, Province province);
	
	/**
	 * 获得所有省份
	 */
	public List<Province> getAllProvince();
	/**
	 * 获取直营门店的省份
	 */
	public List<Province> getZYShopProvince(String shopType);
	
	/**
	 * 根据编号查询省份
	 * @param cityId
	 * @return
	 */
	public Province findById(String id);
}
