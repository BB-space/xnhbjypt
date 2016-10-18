package com.sykj.app.web.controller.system;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.web.controller.BaseController;
import com.sykj.app.entity.system.Menu;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Json;
import com.sykj.app.model.MenuM;
import com.sykj.app.model.UserM;
import com.sykj.app.service.system.MenuService;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController{

	@Resource
	private MenuService menuService;
	
	/**
	 * 跳转到菜单管理页面
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String menu() {
		return "/system/menu";
	}

	/**
	 * 获取菜单树
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/tree")
	@ResponseBody
	public List<EasyuiTreeNode> tree(String id) {
//		System.out.println("*"+id);
		return menuService.tree(id);
	}

	/**
	 * 获取后台导航栏
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/backgroundTree")
	@ResponseBody
	public List<EasyuiTreeNode> backgroundTree(HttpSession session,String id) {
		UserM userM = (UserM) session.getAttribute("userM");
		return menuService.backgroundTree(userM,id);
	}
	
	/**
	 * 获取菜单treegrid
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/treegrid")
	@ResponseBody
	public List<MenuM> treegrid(String id) {
		return menuService.treegrid(id);
	}

	/**
	 * 添加菜单
	 * 
	 * @param menu
	 * @return
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Json add(MenuM menu) {
		Json j = new Json();
		MenuM m = menuService.add(menu);
		j.setSuccess(true);
		j.setMsg("添加成功!");
		return j;
	}

	/**
	 * 删除菜单
	 * 
	 * @param menu
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public Json del(MenuM menu) {
		Json j = new Json();
		menuService.del(menu);
		j.setSuccess(true);
		j.setMsg("删除成功!");
		return j;
	}

	/**
	 * 编辑菜单
	 * 
	 * @param menu
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(MenuM menu) {
		Json j = new Json();
		MenuM m = menuService.edit(menu);
		j.setSuccess(true);
		j.setMsg("编辑成功!");
		return j;
	}
}
