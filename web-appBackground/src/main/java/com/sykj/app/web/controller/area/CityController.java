package com.sykj.app.web.controller.area;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.area.City;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.CityService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/city")
public class CityController extends BaseController{

	@Resource
	private CityService cityService;
	
	/**
	 * 跳转到城市管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String city() {
		return "/area/city";
	}

	
	/**
	 * 获得所有城市表格
	 * 
	 * @param dg
	 * @param City
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="cityDatagrid")
	@ResponseBody
	public EasyuiDataGridJson cityDatagrid(EasyuiDataGrid dg, City city) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return cityService.datagrid(syct, city);
	}
	
	/**
	 * 获得城市（下拉框用）
	 */
	@RequestMapping(params="cityList")
	@ResponseBody
	public List<City> cityList(String provinceId) {
		return cityService.getCityByProvinceId(provinceId);
	}
	
	/**
	 * 所有城市的表格
	 * 
	 * @param dg
	 * @param City
	 * @return
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request,
			SystemContext syct, City city) {
		return cityService.datagrid(syct, city);
	}


	
	/**
	 * 添加城市
	 * 
	 * @param City
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public City add(City city) {
		return cityService.addCity(city);
	}

	/**
	 * 编辑城市
	 * 
	 * @param City
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public City edit(City city) {
		return cityService.editCity(city);
	}
	
	/**
	 * 删除城市
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		cityService.deleteCity(ids);
		j.setSuccess(true);
		return j;
	}
}
