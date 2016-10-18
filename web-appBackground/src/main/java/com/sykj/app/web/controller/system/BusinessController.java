package com.sykj.app.web.controller.system;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.system.BusinessM;
import com.sykj.app.service.system.BusinessService;
import com.sykj.app.web.controller.BaseController;

/**
 * @author wjl 2016年10月12日 上午10:52:13
 */
@Controller
@RequestMapping("/business")
public class BusinessController extends BaseController{

	@Resource
	private BusinessService businessService;
	
	/**
	 * 跳转到职务管理页面
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "/system/business";
	}
	
	/**
	 * 职务treegrid
	 * @param id
	 * @return
	 */
	@RequestMapping("/treegrid")
	@ResponseBody
	public List<BusinessM> treegrid(String id) {
		return businessService.treegrid(id);
	}
	
	/**
	 * 职务树
	 * @param id
	 * @return
	 */
	@RequestMapping("/tree")
	@ResponseBody
	public List<EasyuiTreeNode> tree(String id) {
		return businessService.tree(id);
	}
	
	/**
	 * 添加职务
	 * @param business
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Json add(BusinessM business) {
		Json j = new Json();
		businessService.add(business);
		j.setSuccess(true);
		j.setMsg("添加成功!");
		return j;
	}
	
	/**
	 * 编辑职务
	 * @param business
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(BusinessM business) {
		Json j = new Json();
		businessService.edit(business);
		j.setSuccess(true);
		j.setMsg("编辑成功!");
		return j;
	}
	
	/**
	 * 删除职务
	 * @param business
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public Json del(BusinessM business) {
		Json j = new Json();
		businessService.del(business);
		j.setSuccess(true);
		j.setMsg("删除成功!");
		return j;
	}
}
