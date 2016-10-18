package com.sykj.app.dao.area;

import java.util.List;

import com.sykj.app.entity.area.City;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface CityDao extends IBaseDao<City>{

	/**
	 * 查找城市
	 */
	public City getCity(String id);
	
	/**
	 * 删除城市
	 */
	public void deleteCity(String id);
	
	
	/**
	 * 获得所有城市（分页）
	 */
	public Pager<City> findCity(SystemContext syct, City city);
	
	/**
	 * 获得所有城市
	 */
	public List<City> findCityByProvinceId(String provinceId);
	
	/**
	 * 根据城市名获取
	 */
	public City findCityByName(String cityName);
	
	/**
	 *	根据省id获取开通城市列表 
	 */
	public List<City> findOpenedCityList(String provinceId,String status);
	
	/**
	 * 根据省份获取所有未开通预约的城市
	 */
	public List<City> getCityNoOpen(String provinceId);
	
	/**
	 * 获取已开通预约城市
	 * cityName : 模糊查询城市
	 * @return
	 */
	public List<City> findOpenedCity(String cityName);
	/**
	 * 获取有直营门店的城市列表
	 */
	public List<City> findZYShopCityList(String provinceId, String status);
	/**
	 * 获取所有开通的城市
	 */
	public List<City> openCity();
	/**
	 * 根据区域获取开通城市
	 */
	public List<City> findByCityGroup(String cityGroup,String status);
	
	/**
	 * 查询区域
	 * zq
	 * @return
	 */
	public List<Object []> findByGroupType();
	/**
	 * 去除省的城市
	 */
	public List<City> getCityByNoProId(String provinceId,String status);
}
