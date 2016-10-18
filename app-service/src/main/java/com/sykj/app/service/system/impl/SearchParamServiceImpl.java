package com.sykj.app.service.system.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.dao.system.MenuDao;
import com.sykj.app.dao.system.SearchParamDao;
import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.system.Menu;
import com.sykj.app.entity.system.SearchParam;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.system.SearchParamM;
import com.sykj.app.service.system.SearchParamService;
import com.sykj.app.util.DateUtil;

@Service("searchParamService")
public class SearchParamServiceImpl implements SearchParamService{
	@Resource
	private SearchParamDao searchParamDao;
	@Resource
	private UserInformationDao userInformationDao;
	@Resource
	private MenuDao menuDao;
	@Resource
	private CityDao cityDao;
	
	@Override
	public void addSearchParam(SearchParam t) {
		searchParamDao.deleteSearchParamByMenuIdMobile(t);
		t.setId(UUID.randomUUID().toString());
		t.setCreateDateTime(new Date());
		searchParamDao.addSearchParam(t);
	}

	@Override
	public SearchParam getSearchParam(String id) {
		return searchParamDao.getSearchParam(id);
	}

	@Override
	public void deleteSearchParam(String ids) {
		for (String id : ids.split(",")) {
			SearchParam s = searchParamDao.getSearchParam(id);
			if (s != null) {
				searchParamDao.deleteSearchParam(id);
			}
		}
	}

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, SearchParam t) {
		EasyuiDataGridJson edgj = new EasyuiDataGridJson();
		Pager<SearchParam> pPager = searchParamDao.findSearchParam(syct, t);
		List<SearchParam> list = pPager.getDatas();
		List<SearchParamM> mlist = new ArrayList<SearchParamM>(); 
		if(list.size() > 0){
			for (SearchParam sp : list) {
				SearchParamM spm = new SearchParamM();
				BeanUtils.copyProperties(sp, spm);
				Menu menu = menuDao.getMenu(spm.getMenuId());
				spm.setMenuName(menu.getText());
				mlist.add(spm);
			}
		}
		edgj.setRows(mlist);
		edgj.setTotal(pPager.getTotalCount());
		return edgj;
	}

	@Override
	public List<City> findSearchParamByUserId(String userId, String src) {
		List<City> list = new ArrayList<City>();
		
		SearchParam s = searchParamDao.findSearchParamByUserId(userId, src);
		if(s != null){
			String[] cityNames = s.getCityNames().split(",");
			for (String name : cityNames) {
				if(name != ""){
					City city = new City();
					city.setCityName(name);
					list.add(city);
				}
			}
		}
		
		return list;
	}

	@Override
	public List<City> findSearchCity() {
		List<City> list = new ArrayList<City>();
		City city = new City();
		city.setId(UUID.randomUUID().toString());
		city.setCityName("所有");
		list.add(city);
		List<City> cityList = cityDao.openCity();
		list.addAll(cityList);
		return list;
	}
}
