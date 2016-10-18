package com.sykj.app.web.controller.system;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.area.City;
import com.sykj.app.entity.system.SearchParam;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.MenuM;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.system.MenuService;
import com.sykj.app.service.system.SearchParamService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/searchParam")
public class SearchParamController extends BaseController{

	@Resource
	private SearchParamService searchParamService;
	@Resource
	private MenuService menuService;
	
	/**
	 * 跳转到搜索参数管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String searchParam() {
		return "/system/searchParam";
	}
	
	/**
	 * 获得所有搜索参数表格
	 * 
	 * @param dg
	 * @param SearchParam
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="searchParamDatagrid")
	@ResponseBody
	public EasyuiDataGridJson searchParamDatagrid(EasyuiDataGrid dg, SearchParam searchParam) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return searchParamService.datagrid(syct, searchParam);
	}
	
	/**
	 * 所有搜索参数的表格
	 * 
	 * @param dg
	 * @param SearchParam
	 * @return
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request,
			SystemContext syct, SearchParam searchParam) {
		return searchParamService.datagrid(syct, searchParam);
	}

	/**
	 * 添加搜索参数
	 * 
	 * @param SearchParam
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Json add(SearchParam searchParam) {
		Json j = new Json();
		searchParamService.addSearchParam(searchParam);
		j.setSuccess(true);
		return j;
	}
	
	/**
	 * 删除搜索参数
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		searchParamService.deleteSearchParam(ids);
		j.setSuccess(true);
		return j;
	}
	
	/**
	 * 菜单列表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="menuList")
	@ResponseBody
	public List<MenuM> menuList() {
		return menuService.findAllMenus();
	}
	
	@RequestMapping(params="openCity")
	@ResponseBody
	public List<City> openCity(){
		return searchParamService.findSearchCity();
	}
}
