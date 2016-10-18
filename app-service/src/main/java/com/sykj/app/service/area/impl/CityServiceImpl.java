package com.sykj.app.service.area.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.CityService;
import com.sykj.app.service.impl.BaseServiceImpl;

@Service("cityService")
public class CityServiceImpl extends BaseServiceImpl implements CityService{

	@Resource
	private CityDao cityDao;
	@Resource
	private ShopDao shopDao;
	
	@Override
	public City addCity(City city) {
		City c = new City();
		city.setCreateDateTime(new Date());
		city.setId(UUID.randomUUID().toString());
		BeanUtils.copyProperties(city, c);
		cityDao.add(c);
		return c;
	}

	@Override
	public void deleteCity(String ids) {
		for (String id : ids.split(",")) {
			City city = cityDao.getCity(id);
			if (city != null) {
				cityDao.deleteCity(id);
			}
		}
		
	}

	@Override
	public City editCity(City city) {
		City c = cityDao.getCity(city.getId());
		if(city.getCityName() != null && !city.getCityName().equals("")){
			c.setCityName(city.getCityName());
		}
		if(city.getCityNumber() != null && !city.getCityNumber().equals("")){
			c.setCityNumber(city.getCityNumber());
		}
		if(city.getProvinceId() != null && !city.getProvinceId().equals("")){
			c.setProvinceId(city.getProvinceId());
		}
		if(city.getSeq() !=null && !city.getSeq().equals("")){
			c.setSeq(city.getSeq());
		}
		cityDao.update(c);
		return c;
	}
	
	@Override
	public City getCity(String cityId) {
		
		return cityDao.getCity(cityId);
	}
	
	@Override
	public City getName(String cityName) {
		
		return cityDao.findCityByName(cityName);
	}

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, City city) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		Pager<City> pCity = cityDao.findCity(syct, city);
		j.setRows(pCity.getDatas());
		j.setTotal(pCity.getTotalCount());
		return j;
	}

	@Override
	public List<City> getCityByProvinceId(String provinceId) {
		return cityDao.findCityByProvinceId(provinceId);
	}
	
	@Override
	public List<City> getCityByProId(String provinceId,String status) {
		return cityDao.findOpenedCityList(provinceId,status);
	}

	@Override
	public List<City> findOpenedCity(String cityName) {
//		System.out.println("1***"+cityName);
		if(cityName != null){
			List<City> listSearch = cityDao.findOpenedCity(cityName);
			if(listSearch.size()>0){
				return listSearch;
			}else{//查询为空，返回所有
				return cityDao.findOpenedCity(null);
			}
		}else{
			return cityDao.findOpenedCity(null);
		}
	}

	@Override
	public List<City> getNoOpenCityByProvinceId(String provinceId) {
		return cityDao.getCityNoOpen(provinceId);
	}

	@Override
	public List<City> getCityZYShopByProId(String provinceId, String status) {

		return cityDao.findZYShopCityList(provinceId,status);
	}
	@Override
	public List<City> openCity(){
		return cityDao.openCity();
	}

	@Override
	public List<City> findByCityGroup(String cityGroup, String status) {
		return cityDao.findByCityGroup(cityGroup,status);
	}

	@Override
	public List<City> findByMoreCityGroup(String[] cityGroups, String status) {
		List<City> cList = new ArrayList<City>();
		for(int i=0;i<cityGroups.length;i++){
			List<City> list = cityDao.findByCityGroup(cityGroups[i],status);
			if(list != null && list.size()>0){
				for(City c : list){
					cList.add(c);
				}
			}
		}
		return cList;
	}

	@Override
	public List<Object []> findByGroupType() {
		
		return cityDao.findByGroupType();
	}

	@Override
	public List<City> getCityByNoProId(String provinceId, String status) {
		return cityDao.getCityByNoProId(provinceId,status);
	}

}
