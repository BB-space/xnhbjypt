package com.sykj.app.web.controller.area;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.SubcenterService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/subcenter")
public class SubcenterController extends BaseController{

	@Resource
	private SubcenterService subcenterService;
	
	/**
	 * 跳转到分中心管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String subcenter() {
		return "/area/subcenter";
	}

	
	/**
	 * 获得所有分中心表格
	 * 
	 * @param dg
	 * @param Subcenter
	 * @return
	 */
	@RequestMapping(params="subcenterDatagrid")
	@ResponseBody
	public EasyuiDataGridJson subcenterDatagrid(SystemContext syct, Subcenter subcenter) {

		return subcenterService.datagrid(syct, subcenter);
	}
	
	/**
	 * 所有分中心的表格
	 * 
	 * @param dg
	 * @param Subcenter
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request,
			EasyuiDataGrid dg, Subcenter subcenter) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return subcenterService.datagrid(syct, subcenter);
	}

	/**
	 * 获得分中心（下拉框用）
	 */
	@RequestMapping(params="subcenterList")
	@ResponseBody
	public List<Subcenter> subcenterList() {
		return subcenterService.getAllSubcenter();
	}
	
	/**
	 * 添加分中心
	 * 
	 * @param Subcenter
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Subcenter add(Subcenter subcenter) {
		return subcenterService.addSubcenter(subcenter);
	}

	/**
	 * 编辑分中心
	 * 
	 * @param Subcenter
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public Subcenter edit(Subcenter subcenter) {
		return subcenterService.editSubcenter(subcenter);
	}
	
	/**
	 * 删除分中心
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		subcenterService.deleteSubcenter(ids);
		j.setSuccess(true);
		return j;
	}
	
	/**
	 * 分中心树
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/tree")
	@ResponseBody
	public List<EasyuiTreeNode> tree(String id) {
//		return roleService.tree(id);
		return subcenterService.tree(id);
	}
}
