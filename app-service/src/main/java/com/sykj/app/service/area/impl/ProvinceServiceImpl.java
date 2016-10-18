package com.sykj.app.service.area.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.dao.area.ProvinceDao;
import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.area.Province;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.ProvinceService;
import com.sykj.app.service.impl.BaseServiceImpl;

@Service("provinceService")
public class ProvinceServiceImpl extends BaseServiceImpl implements ProvinceService{
	
	@Resource
	private ProvinceDao provinceDao;
	@Resource
	private CityDao cityDao;
	@Resource
	private ShopDao shopDao;
	
	@Override
	public Province addProvince(Province province) {
		Province p =new Province();
		province.setCreateDateTime(new Date());
		province.setId(UUID.randomUUID().toString());
		BeanUtils.copyProperties(province, p);
		return provinceDao.add(p);
	}

	@Override
	public void deleteProvince(String ids) {
		for (String id : ids.split(",")) {
			Province p = provinceDao.getProvince(id);
			if (p != null) {
				provinceDao.deleteProvince(id);
			}
		}
		
	}

	@Override
	public Province editProvince(Province province) {
		Province p = provinceDao.getProvince(province.getId());
		if(province.getProvinceName() != null && !province.getProvinceName().equals("")){
			p.setProvinceName(province.getProvinceName());
		}
		if(province.getProvinceNumber() != null && !province.getProvinceNumber().equals("")){
			p.setProvinceNumber(province.getProvinceNumber());
		}
		if(province.getSeq() != null && !province.getSeq().equals("")){
			p.setSeq(province.getSeq());
		}
		provinceDao.update(p);
		return p;
	}

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, Province province) {
		EasyuiDataGridJson edgj = new EasyuiDataGridJson();
		Pager<Province> pPager = provinceDao.findProvince(syct, province);
		edgj.setRows(pPager.getDatas());
		edgj.setTotal(pPager.getTotalCount());
		return edgj;
	}

	@Override
	public List<Province> getAllProvince() {
		
		return provinceDao.getAllProvince();
	}

	@Override
	public List<Province> getZYShopProvince(String shopType) {
		return provinceDao.getZYShopProvince(shopType);
	}

	@Override
	public Province findById(String id) {
		
		return provinceDao.getProvince(id);
	}

}
