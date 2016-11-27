package com.sykj.app.web.controller.trade;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.model.FrontUserM;
import com.sykj.app.model.Json;
import com.sykj.app.service.finance.FinanceService;
import com.sykj.app.util.Jypt;
import com.sykj.app.util.JyptUtil;
import com.sykj.app.web.controller.BaseController;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/trade")
public class TradeController extends BaseController {

	@Resource
	private FinanceService financeService;
	
	@RequestMapping(params="index")
	public String index(HttpSession session, HttpServletRequest req,HttpServletResponse response) {
		return "/trade/index";
	}
	
	//K线图页面
	@RequestMapping(params="kline")
	public String kline(String type, HttpSession session, 
			HttpServletRequest req,HttpServletResponse response) {
		
		
		
		return "/trade/kline";
	}
	
	//买入，
	@RequestMapping(params="buyXnb")
	@ResponseBody
	public Json buyXnb(EntrustTrading entrustTrading, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			entrustTrading.setLoginname(frontUserM.getUserName());
			financeService.buyXnb(entrustTrading);
			j.setSuccess(true);
		}
		return j;
	}
	
	
	//卖出，
	@RequestMapping(params="sellXnb")
	@ResponseBody
	public Json sellXnb(EntrustTrading entrustTrading, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			entrustTrading.setLoginname(frontUserM.getUserName());
			financeService.sellXnb(entrustTrading);
			j.setSuccess(true);
		}
		return j;
	}
	
	
	
	//获取最新数据列表
	
	@RequestMapping(params="getJypthq")
	@ResponseBody
	public Json getJypthq(String type, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		List<JSONObject> list = new ArrayList<JSONObject>();
		
		 //发送 GET 请求
    	JSONObject s=JyptUtil.getJypthq(Jypt.btc_jyhq_uql);
    	JSONObject s2=JyptUtil.getJypthq(Jypt.ltc_jyhq_uql);
    	JSONObject s3=JyptUtil.getJypthq(Jypt.eth_jyhq_uql);
    	JSONObject s4=JyptUtil.getJypthq(Jypt.doge_jyhq_uql);
    	JSONObject s5=JyptUtil.getJypthq(Jypt.ybc_jyhq_uql);
    	JSONObject btcjsonObject = JSONObject.fromObject(s);
    	btcjsonObject.put("type", "btc");
    	JSONObject ltcjsonObject = JSONObject.fromObject(s2);
    	ltcjsonObject.put("type", "ltc");
    	JSONObject ethjsonObject = JSONObject.fromObject(s3);
    	ethjsonObject.put("type", "eth");
    	JSONObject dogejsonObject = JSONObject.fromObject(s4);
    	dogejsonObject.put("type", "doge");
    	JSONObject ybcjsonObject = JSONObject.fromObject(s5);
    	ybcjsonObject.put("type", "ybc");
    	list.add(btcjsonObject);
    	list.add(ltcjsonObject);
    	list.add(ethjsonObject);
    	list.add(dogejsonObject);
    	list.add(ybcjsonObject);
    	j.setObj(list);
		j.setSuccess(true);
		return j;
	}
	
	
	
	//获取看线图显示数据
	@RequestMapping(params="getJypthq2")
	@ResponseBody
	public Json getJypthq2(HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			
			
			
			j.setSuccess(true);
		}
		return j;
	}
	
	
	
}
