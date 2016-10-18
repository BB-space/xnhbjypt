package com.sykj.app.dao.area.impl;

import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("cityDao")
public class CityDaoImpl  extends BaseDao<City> implements CityDao{

	@Override
	public City getCity(String id) {
		return this.get(City.class, id);
	}

	@Override
	public void deleteCity(String id) {
		this.delete(this.getCity(id));
		
	}

	@Override
	public Pager<City> findCity(SystemContext syct, City city) {
		StringBuffer hql = new StringBuffer("from City t where 1=1");
		if(city !=null){// 添加查询条件
			if (city.getCityName() != null && !city.getCityName().trim().equals("")) {
				hql.append(" and t.cityName like '%%").append(city.getCityName()).append("%%' ");
			}
		}
		return this.find(hql.toString(),syct);
	}

	@Override
	public List<City> findCityByProvinceId(String provinceId) {
		
		return this.list("from City t where t.provinceId='"+provinceId+"' ORDER BY t.cityNumber");
	}

	@Override
	public City findCityByName(String cityName) {
		
		return this.get("from City c where c.cityName='"+cityName+"'");
	}

	@Override
	public List<City> getCityNoOpen(String provinceId) {
		String hql = "from City c where c.status='0' and c.provinceId='"+provinceId+"' order by c.seq asc";
		return this.list(hql);
	}

	@Override
	public List<City> findOpenedCity(String cityName) {
		String hql;
		if(cityName != null){
			hql = "from City t where t.status='1' and t.cityName like '%%"+cityName+"%%' order by t.seq asc";
		}else{
			hql = "from City t where t.status='1' order by t.seq asc";
		}
		return this.list(hql);
	}

	@Override
	public List<City> findOpenedCityList(String provinceId,String status) {
		String hql = "from City c where c.status='"+status+"' and c.provinceId='"+provinceId+"' "
				     +"order by c.seq desc";
		return this.list(hql);
	}
	
	@Override
	public List<City> findZYShopCityList(String provinceId,String status) {
		String hql = "from City c where c.status='"+status+"' and c.provinceId='"+provinceId+"' "
				+ "and c.id in (select cityId from Shop where shopType='直营') "	     
				+"order by c.seq desc";
		return this.list(hql);
	}

	@Override
	public List<City> openCity() {
		String hql = "from City c where c.status='1' order by c.seq desc";
		return this.list(hql);
	}

	@Override
	public List<City> findByCityGroup(String cityGroup, String status) {
		String hql = "from City c where c.status='"+status+"' and c.cityGroup='"+cityGroup+"' order by c.seq desc";
		return this.list(hql);
	}

	@Override
	public List<Object []> findByGroupType() {
		String sql="select DISTINCT cityGroup from sykj_area_city"
				+" where cityGroup is not null";
		SQLQuery query=getSession().createSQLQuery(sql);
		@SuppressWarnings("unchecked")
		List<Object[]> list=query.list();
		return list;
	}

	@Override
	public List<City> getCityByNoProId(String provinceId, String status) {
		String hql = "from City c where c.status='"+status+"' and c.provinceId not in ('"+provinceId+"')"
				+ " order by c.seq desc";
		return this.list(hql);
	}

}
