package com.sykj.app.web.controller.area;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.area.Province;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.ProvinceService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/province")
public class ProvinceController extends BaseController{

	@Resource
	private ProvinceService provinceService;
	
	/**
	 * 跳转到省份管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String province() {
		return "/area/province";
	}

	
	/**
	 * 获得所有省份表格
	 * 
	 * @param dg
	 * @param Province
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="provinceDatagrid")
	@ResponseBody
	public EasyuiDataGridJson provinceDatagrid(EasyuiDataGrid dg, Province province) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return provinceService.datagrid(syct, province);
	}
	
	
	
	/**
	 * 所有省份的表格
	 * 
	 * @param dg
	 * @param Province
	 * @return
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request,
			SystemContext syct, Province province) {
//		System.out.println("****");
		return provinceService.datagrid(syct, province);
	}


	
	/**
	 * 添加省份
	 * 
	 * @param Province
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Province add(Province province) {
		return provinceService.addProvince(province);
	}

	/**
	 * 编辑省份
	 * 
	 * @param Province
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public Province edit(Province province) {
		return provinceService.editProvince(province);
	}
	
	/**
	 * 获得省份（下拉框用）
	 */
	@RequestMapping(params="provinceList")
	@ResponseBody
	public List<Province> provinceList() {
		return provinceService.getAllProvince();
	}
	
	/**
	 * 删除省份
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		provinceService.deleteProvince(ids);
		j.setSuccess(true);
		return j;
	}
}
