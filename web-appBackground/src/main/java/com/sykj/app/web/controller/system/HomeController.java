package com.sykj.app.web.controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/")
public class HomeController extends BaseController{
	
	@RequestMapping("/north")
	public String north() {
//		return "/common/layout/north";
		return "/common/layout/northNew";
	}

	@RequestMapping("/west")
	public String west() {
		return "/common/layout/west";
	}

	@RequestMapping("/center")
	public String center() {
		return "/common/layout/center";
	}

	@RequestMapping("/south")
	public String south() {
		return "/common/layout/south";
	}

	/**
	 * 跳转到首页
	 */
	@RequestMapping("/index")
	public String index() {
		return "/index";
	}
	
	/**
	 * 跳转到home页面
	 * 
	 * @return
	 */
	@RequestMapping("/home")
	public String home() {
		return "/common/layout/home";
	}
}
