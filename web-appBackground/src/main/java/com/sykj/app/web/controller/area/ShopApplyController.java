package com.sykj.app.web.controller.area;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.area.ShopApply;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.app.service.area.ShopApplyService;
import com.sykj.app.service.area.ShopService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/shopApply")
@SuppressWarnings("static-access")
public class ShopApplyController extends BaseController{

	@Resource
	private ShopApplyService shopApplyService;
	
	/**
	 * 跳转到门店管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String shop() {
		return "/area/shopApply";
	}
	
	@RequestMapping(params="audit")
	public String shopAudit() {
		return "/area/shopApplyAudit";
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
	public EasyuiDataGridJson shopDatagrid(EasyuiDataGrid dg, ShopApply shop,HttpSession session) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		UserM userM = (UserM) session.getAttribute("userM");
		return shopApplyService.datagrid(syct, shop,userM);
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
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, ShopApply shop,HttpSession session) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		UserM userM = (UserM) session.getAttribute("userM");
		return shopApplyService.datagrid(syct, shop,userM);
	}
	
	@RequestMapping(params="datagridAudit")
	@ResponseBody
	public EasyuiDataGridJson datagridAudit(EasyuiDataGrid dg, ShopApply shop,HttpSession session) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		UserM userM = (UserM) session.getAttribute("userM");
		return shopApplyService.datagrid(syct, shop,userM);
	}

	/**
	 * 获得门店（下拉框用）
	 */
	@RequestMapping(params="shopList")
	@ResponseBody
	public List<ShopApply> subcenterList(String cityId) {
		return shopApplyService.getShopByCityId(cityId);
	}
	
	/**
	 * 添加门店
	 * 
	 * @param Shop
	 * @throws Exception 
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public ShopApply add(ShopApply shop) throws Exception {
		return shopApplyService.addShop(shop);
	}
	
	/**
	 * 添加门店(带二维码)
	 * 
	 * @param Shop
	 * @return
	 */
	@RequestMapping(params="addshop")
	@ResponseBody
	public ShopApply addshop(ShopApply shop,String shopid,HttpServletRequest request) {
		String url = request.getSession().getServletContext().getRealPath("/");
		UserM userM = (UserM) request.getSession().getAttribute("userM");
		return shopApplyService.addShop(shop,shopid,url,userM);
	}

	/**
	 * 编辑门店
	 * @param Shop
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public ShopApply edit(ShopApply shop) {
		return shopApplyService.editShop(shop);
	}
	
	@RequestMapping(params="shopAudit")
	@ResponseBody
	public ShopApply editAudit(ShopApply shop) {
		return shopApplyService.editShopAudit(shop.getId(), "1");
	}
	
	@RequestMapping(params="shopReject")
	@ResponseBody
	public ShopApply editReject(ShopApply shop) {
		return shopApplyService.editShopAudit(shop.getId(),"2");
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
		shopApplyService.deleteShop(ids);
		j.setSuccess(true);
		return j;
	}
	
	/**
	 * 获得所有的门店
	 * @return
	 */
	@RequestMapping(params="getAll")
	@ResponseBody
	public List<ShopApply> getAll(){
		return shopApplyService.getAll();
	}
	
	/**
	 * 生成门店二维码
	 */
	@RequestMapping(params="createQRCode")
	@ResponseBody
	public String createQRCode(HttpServletRequest request,String id) {
		String url = request.getSession().getServletContext().getRealPath("/");
		String shopid = shopApplyService.createQRCode(url,id);
		return shopid;
	}
	
	/**
	 * 获取所有测试门店
	 */
	@RequestMapping(params="getTestAll")
	@ResponseBody
	public List<ShopApply> getTestAll(){
		return shopApplyService.getTestAll();
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
		return shopApplyService.tree(subcenterId);
	}
}
