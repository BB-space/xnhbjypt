package com.sykj.app.service.area;

import java.util.List;

import antlr.collections.impl.LList;

import com.sykj.app.entity.area.City;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.SystemContext;

public interface CityService {

	/**
	 * 添加城市
	 * @param City
	 */
	public City addCity(City city);
	
	/**
	 * 删除城市
	 * @param City
	 */
	public void deleteCity(String ids);
	
	/**
	 * 编辑城市
	 */
	public City editCity(City city);
	
	/**
	 * 根据id获取城市
	 */
	public City getCity(String cityId);
	
	public City getName(String cityName);
	/**
	 * 查询城市列表
	 * @param dg
	 * @param City
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, City city);
	
	/**
	 * 根据省份获得城市
	 */
	public List<City> getCityByProvinceId(String provinceId);
	
	/**
	 * 根据省份获得已开通服务城市
	 * @param status 城市开放状态 
	 */
	public List<City> getCityByProId(String provinceId,String status);
	
	/**
	 * 返回已开通预约城市
	 * cityName：模糊查询城市名
	 * @return
	 */
	public List<City> findOpenedCity(String cityName);
	/**
	 * 根据省份获取所有未开通的城市
	 */
	public List<City> getNoOpenCityByProvinceId(String provinceId);
	/**
	 * 获取有直营门店的城市
	 */
	public List<City> getCityZYShopByProId(String provinceId,String status);
	/**
	 * 获取所有开通的城市
	 */
	public List<City> openCity();
	/**
	 * 根据区域获取开通城市
	 */
	public List<City> findByCityGroup(String cityGroup,String status);
	/**
	 * 获取广州、海南城市
	 */
	public List<City> findByMoreCityGroup(String[] cityGroups, String status);
	
	/**
	 * 查询区域
	 * @return
	 */
	public List<Object []> findByGroupType();
	/**
	 * 去除省
	 */
	public List<City> getCityByNoProId(String provinceId,String status);
}
