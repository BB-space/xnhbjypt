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
	
	//个人财务
	@RequestMapping(params="index")
	public String index() {
		return "/finance/index";
	}
	
	//人民币充值 银行汇款
	@RequestMapping(params="rechargeCny")
	public String rechargeCny() {
		return "/finance/rechargeCny";
	}
	
	//人民币充值 环迅支付
	@RequestMapping(params="rechargeCny2")
	public String rechargeCny2() {
		return "/finance/rechargeCny2";
	}
	
	//人民币提现
	@RequestMapping(params="withdrawCny")
	public String withdrawCny() {
		return "/finance/withdrawCny";
	}
	
	//网络流通币充值  BTC
	@RequestMapping(params="rechargeBtc")
	public String rechargeBtc() {
		return "/finance/rechargeBtc";
	}
	
	//网络流通币充值 LTC
	@RequestMapping(params="rechargeBtc2")
	public String rechargeBtc2() {
		return "/finance/rechargeBtc2";
	}
	
	//网络流通币充值 SLM
	@RequestMapping(params="rechargeBtc3")
	public String rechargeBtc3() {
		return "/finance/rechargeBtc3";
	}
	
	//网络流通币提现
	@RequestMapping(params="withdrawBtc")
	public String withdrawBtc() {
		return "/finance/withdrawBtc";
	}
	
	//网络流通币提现
	@RequestMapping(params="withdrawBtc2")
	public String withdrawBtc2() {
		return "/finance/withdrawBtc2";
	}
	
	//网络流通币提现
	@RequestMapping(params="withdrawBtc3")
	public String withdrawBtc3() {
		return "/finance/withdrawBtc3";
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
