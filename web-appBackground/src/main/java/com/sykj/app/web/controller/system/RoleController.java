package com.sykj.app.web.controller.system;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.web.controller.BaseController;
import com.sykj.app.entity.system.Role;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.RoleM;
import com.sykj.app.service.system.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController{

	@Resource
	private RoleService roleService;
	/**
	 * 跳转到角色管理页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String role() {
		return "/system/role";
	}

	/**
	 * 角色树
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/tree")
	@ResponseBody
	public List<EasyuiTreeNode> tree(String id) {
		return roleService.tree(id);
	}

	/**
	 * 角色treegrid
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/treegrid")
	@ResponseBody
	public List<RoleM> treegrid(String id) {
		return roleService.treegrid(id);
	}

	/**
	 * 添加角色
	 * 
	 * @param role
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Json add(RoleM role) {
		Json j = new Json();
		RoleM r = roleService.add(role);
		j.setSuccess(true);
		j.setMsg("添加成功!");
		return j;
	}

	/**
	 * 删除角色
	 * 
	 * @param role
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public Json del(RoleM role) {
		Json j = new Json();
		roleService.del(role);
		j.setSuccess(true);
		j.setMsg("删除成功!");
		return j;
	}

	/**
	 * 编辑角色
	 * 
	 * @param role
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(RoleM role) {
		Json j = new Json();
		RoleM r = roleService.edit(role);
		j.setSuccess(true);
		j.setMsg("编辑成功!");
		return j;
	}
}
