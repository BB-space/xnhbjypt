package com.sykj.app.web.controller.system;

import java.util.List;

import javax.annotation.Resource;
import javax.annotation.Resources;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.web.controller.BaseController;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.ResourcesM;
import com.sykj.app.service.system.ResourcesService;

@Controller
@RequestMapping("/resources")
public class ResourcesController extends BaseController{
	
	@Resource
	private ResourcesService resourcesService;
	
	
	@RequestMapping("/test")
	public String test() {
		System.out.println("**");
		return "/index";
	}
	
	/**
	 * 跳转到资源管理页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String resources() {
		return "/system/resources";
	}

	/**
	 * 获取资源管理树
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/tree")
	@ResponseBody
	public List<EasyuiTreeNode> tree(String id) {
		return resourcesService.tree(id);
	}

	/**
	 * 资源管理treegrid
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/treegrid")
	@ResponseBody
	public List<ResourcesM> treegrid(String id) {
		return resourcesService.treegrid(id);
	}

	/**
	 * 添加资源
	 * 
	 * @param resources
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Json add(ResourcesM resources) {
		Json j = new Json();
		ResourcesM r = resourcesService.add(resources);
		j.setSuccess(true);
		j.setMsg("添加成功!");
		return j;
	}

	/**
	 * 删除资源
	 * 
	 * @param resources
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public Json del(ResourcesM resources) {
		Json j = new Json();
		resourcesService.del(resources);
		j.setSuccess(true);
		j.setMsg("删除成功!");
		return j;
	}

	/**
	 * 编辑资源
	 * 
	 * @param resources
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(ResourcesM resources) {
		Json j = new Json();
		ResourcesM r = resourcesService.edit(resources);
		j.setSuccess(true);
		j.setMsg("编辑成功!");
		return j;
	}
}
