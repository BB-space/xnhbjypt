package com.sykj.app.web.controller.finance;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.model.Json;
import com.sykj.app.service.user.FrontUserService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/finance")
public class FinanceController extends BaseController{
	@Resource
	private FrontUserService frontUserService;
	
	@RequestMapping(params="finance")
	public String finance() {
		
		return "/test/finance";
	}


}
