package com.sykj.app.web.controller.area;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.area.Shop;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.ShopService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/shop")
@SuppressWarnings("static-access")
public class ShopController extends BaseController{

	@Resource
	private ShopService shopService;
	
	/**
	 * 跳转到门店管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String shop() {
		return "/area/shop";
	}

	
	/**
	 * 获得所有门店表格
	 * 
	 * @param dg
	 * @param Shop
	 * @return
	 */
	
	@RequestMapping(params="shopDatagrid")
	@ResponseBody
	public EasyuiDataGridJson shopDatagrid(EasyuiDataGrid dg, Shop shop) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return shopService.datagrid(syct, shop);
	}
	
	/**
	 * 所有门店的表格
	 * 
	 * @param dg
	 * @param Shop
	 * @return
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, Shop shop) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return shopService.datagrid(syct, shop);
	}

	/**
	 * 获得门店（下拉框用）
	 */
	@RequestMapping(params="shopList")
	@ResponseBody
	public List<Shop> subcenterList(String cityId) {
		return shopService.getShopByCityId(cityId);
	}
	
	/**
	 * 添加门店
	 * 
	 * @param Shop
	 * @throws Exception 
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Shop add(Shop shop) throws Exception {
		return shopService.addShop(shop);
	}
	
	/**
	 * 添加门店(带二维码)
	 * 
	 * @param Shop
	 * @return
	 */
	@RequestMapping(params="addshop")
	@ResponseBody
	public Shop addshop(Shop shop,String shopid,HttpServletRequest request) {
		String url = request.getSession().getServletContext().getRealPath("/");
		return shopService.addShop(shop,shopid,url);
	}

	/**
	 * 编辑门店
	 * @param Shop
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public Shop edit(Shop shop) {
		//System.out.println(shop.getId());
		return shopService.editShop(shop);
	}
	
	/**
	 * 删除门店
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		shopService.deleteShop(ids);
		j.setSuccess(true);
		return j;
	}
	
	/**
	 * 获得所有的门店
	 * @return
	 */
	@RequestMapping(params="getAll")
	@ResponseBody
	public List<Shop> getAll(){
		return shopService.getAll();
	}
	
	/**
	 * 生成门店二维码
	 */
	@RequestMapping(params="createQRCode")
	@ResponseBody
	public String createQRCode(HttpServletRequest request,String id) {
		String url = request.getSession().getServletContext().getRealPath("/");
		String shopid = shopService.createQRCode(url,id);
		return shopid;
	}
	
	/**
	 * 获取所有测试门店
	 */
	@RequestMapping(params="getTestAll")
	@ResponseBody
	public List<Shop> getTestAll(){
		return shopService.getTestAll();
	}
	
	/**
	 * 门店树
	 * @param id
	 * @return
	 */
	@RequestMapping("/tree")
	@ResponseBody
	public List<EasyuiTreeNode> tree(HttpServletRequest request) {
		String subcenterId = request.getParameter("subcenterId");
		return shopService.tree(subcenterId);
	}
}
