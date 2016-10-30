package com.sykj.app.web.controller.finance;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sykj.app.model.FrontUserM;
import com.sykj.app.service.user.FrontUserService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/finance")
public class FinanceController extends BaseController{
	
	@Resource
	private FrontUserService frontUserService;
	
	@RequestMapping(params="index")
	public String index(HttpSession session) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			
			
			if(b){  //已经实名认证
				return "/finance/index";
			}
		}
		return "/test/index";
	}
	
	
	//个人财务
	@RequestMapping(params="index")
	public String finance() {
		return "/finance/index";
	}
	
	//人民币充值
	@RequestMapping(params="rechargeCny")
	public String rechargeCny() {
		return "/finance/rechargeCny";
	}
	
	//人民币提现
	@RequestMapping(params="withdrawCny")
	public String withdrawCny() {
		return "/finance/withdrawCny";
	}
	
	//网络流通币充值
	@RequestMapping(params="rechargeBtc")
	public String rechargeBtc() {
		return "/finance/rechargeBtc";
	}
	
	//网络流通币提现
	@RequestMapping(params="withdrawBtc")
	public String withdrawBtc() {
		return "/finance/withdrawBtc";
	}
	
	//账单明细
	@RequestMapping(params="record")
	public String record() {
		return "/finance/record";
	}
	
	//账单明细
	@RequestMapping(params="listentrust")
	public String listentrust() {
		return "/finance/listentrust";
	}


}
