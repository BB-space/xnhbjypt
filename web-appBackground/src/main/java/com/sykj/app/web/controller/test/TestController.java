package com.sykj.app.web.controller.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/test")
public class TestController extends BaseController{

	
	@RequestMapping(params="index")
	public String index() {
		
		return "/test/index";
	}
}
