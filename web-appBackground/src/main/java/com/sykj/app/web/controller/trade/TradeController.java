package com.sykj.app.web.controller.trade;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/trade")
public class TradeController extends BaseController {

	@RequestMapping(params="index")
	public String index(HttpSession session, HttpServletRequest req,HttpServletResponse response) {
		return "/trade/index";
	}
	
}
