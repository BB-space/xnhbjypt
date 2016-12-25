package com.sykj.app.web.controller.finance;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.entity.finance.MemberMoney;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.entity.finance.Userxnb;
import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.entity.finance.WaitAuditxnbt;
import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.model.FrontUserM;
import com.sykj.app.model.Json;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.finance.PersonFinance;
import com.sykj.app.service.finance.FinanceService;
import com.sykj.app.service.finance.MemberMoneyService;
import com.sykj.app.service.finance.UserxnbService;
import com.sykj.app.service.finance.WaitAuditrmbtService;
import com.sykj.app.service.finance.WaitAuditrmbwService;
import com.sykj.app.service.finance.WaitAuditxnbtService;
import com.sykj.app.service.user.FrontUserService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/finance")
public class FinanceController extends BaseController{
	
	@Resource
	private FinanceService financeService;
	@Resource
	private UserxnbService userxnbService;
	@Resource
	private WaitAuditxnbtService waitAuditxnbtService;
	@Resource
	private WaitAuditrmbwService waitAuditrmbwService;
	@Resource
	private WaitAuditrmbtService waitAuditrmbtService;
	@Resource
	private MemberMoneyService memberMoneyService;
	@Resource
	private FrontUserService frontUserService;
	
	//个人财务页面
	@RequestMapping(params="index")
	public String index(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			if(b){  //已经实名认证
				PersonFinance pf = financeService.getPersonFinance(frontUserM.getUserName());
				request.setAttribute("personFinance", pf);
				return "/finance/index";
			}
		}
		return "/safe/safe_userSetting";
	}
	
	//人民币充值 银行汇款页面
	@RequestMapping(params="rechargeCny")
	public String rechargeCny(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		return "/finance/rechargeCny";
	}
	
	//人民币充值 环迅支付页面
	@RequestMapping(params="rechargeCny2")
	public String rechargeCny2(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		return "/finance/rechargeCny2";
	}
	
	//人民币页面
	@RequestMapping(params="rechargeRmb")
	public String rechargeRmb(String type, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			RmbOperationRecord rmbOperationRecord = new RmbOperationRecord();
			rmbOperationRecord.setLoginname(frontUserM.getUserName());
			if("0".equals(type)){
				rmbOperationRecord.setTradingtype("人民币充值");
				
			}else if("1".equals(type)){
				rmbOperationRecord.setTradingtype("人民币在线充值");
			}
			SystemContext syct=new SystemContext();
			syct.setNumPerPage(10);
			syct.setPageNum(1);
			Pager<RmbOperationRecord> btcPager = financeService.findRmbOperationRecord(syct, rmbOperationRecord);
			
			request.setAttribute("rmbOperationRecordList", btcPager.getDatas());
			if("0".equals(type)){
				return "/finance/rechargeCny";
			}else if("1".equals(type)){
				return "/finance/rechargeCny2";
			}
		}
		return "/test/index";
	}	
	
	
	//新增人民币充值
	@RequestMapping(params="withdrawCnySubmit")
	public String withdrawCnySubmit(WaitAuditrmbt waitAuditrmbt, String type, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			waitAuditrmbt.setLoginname(frontUserM.getUserName());
			waitAuditrmbt.setUsernickname(frontUserM.getNickName());
			waitAuditrmbt.setUserrealname(frontUserM.getRealName());
			if("0".equals(type)){
				waitAuditrmbt.setCztype("人民币充值");
				
			}else if("1".equals(type)){
				waitAuditrmbt.setCztype("人民币在线充值");
			}
			
			financeService.addWaitAuditrmbt(waitAuditrmbt);
			
			rechargeRmb(type, session, request, response);
		}
		return "/test/index";
	}	
	
	
	//人民币提现页面
	@RequestMapping(params="withdrawCny")
	public String withdrawCny(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			RmbOperationRecord rmbOperationRecord = new RmbOperationRecord();
			rmbOperationRecord.setLoginname(frontUserM.getUserName());
			rmbOperationRecord.setTradingtype("人民币提现");
			SystemContext syct=new SystemContext();
			syct.setNumPerPage(10);
			syct.setPageNum(1);
			Pager<RmbOperationRecord> rmbPager = financeService.findRmbOperationRecord(syct, rmbOperationRecord);
			request.setAttribute("rmbOperationRecordList", rmbPager.getDatas());
			return "/finance/withdrawCny";
		}
		return "/test/index";
	}
	
	//新增人民币提现
	@RequestMapping(params="withdrawCnySubmit")
	public String withdrawCnySubmit(WaitAuditrmbw waitAuditrmbw, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			waitAuditrmbw.setLoginname(frontUserM.getUserName());
			waitAuditrmbw.setUsernickname(frontUserM.getNickName());
			waitAuditrmbw.setUserrealname(frontUserM.getRealName());
			financeService.addWithdrawCny(waitAuditrmbw);
			withdrawCny(session, request, response);
		}
		return "/test/index";
	}	
	
	//网络流通币充值  BTC页面
	@RequestMapping(params="rechargeBtc")
	public String rechargeBtc(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		return "/finance/rechargeBtc";
	}
	
	//网络流通币充值 LTC页面
	@RequestMapping(params="rechargeBtc2")
	public String rechargeBtc2(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		return "/finance/rechargeBtc2";
	}
	
	//网络流通币充值 SLM页面
	@RequestMapping(params="rechargeBtc3")
	public String rechargeBtc3(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		return "/finance/rechargeBtc3";
	}
	
	//网络流通币提现页面
	@RequestMapping(params="withdrawBtc")
	public String withdrawBtc(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			XnbOperationRecord xnbOperationRecord = new XnbOperationRecord();
			xnbOperationRecord.setLoginname(frontUserM.getUserName());
			xnbOperationRecord.setXnbtype("BTC");
			SystemContext syct=new SystemContext();
			syct.setNumPerPage(10);
			syct.setPageNum(1);
			Pager<XnbOperationRecord> btcPager = financeService.findXnbOperationRecord(syct, xnbOperationRecord);
			
			request.setAttribute("btcOperationRecordList", btcPager.getDatas());
		}
		return "/finance/withdrawBtc";
	}
	
	//网络流通币提现页面
	@RequestMapping(params="withdrawBtc2")
	public String withdrawBtc2(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			XnbOperationRecord xnbOperationRecord = new XnbOperationRecord();
			xnbOperationRecord.setLoginname(frontUserM.getUserName());
			xnbOperationRecord.setXnbtype("LTC");
			SystemContext syct=new SystemContext();
			syct.setNumPerPage(10);
			syct.setPageNum(1);
			Pager<XnbOperationRecord> btcPager = financeService.findXnbOperationRecord(syct, xnbOperationRecord);
			
			request.setAttribute("ltcOperationRecordList", btcPager.getDatas());
		}
		return "/finance/withdrawBtc2";
	}
	
	//网络流通币提现页面
	@RequestMapping(params="withdrawBtc3")
	public String withdrawBtc3(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			XnbOperationRecord xnbOperationRecord = new XnbOperationRecord();
			xnbOperationRecord.setLoginname(frontUserM.getUserName());
			xnbOperationRecord.setXnbtype("SLM");
			SystemContext syct=new SystemContext();
			syct.setNumPerPage(10);
			syct.setPageNum(1);
			Pager<XnbOperationRecord> btcPager = financeService.findXnbOperationRecord(syct, xnbOperationRecord);
			
			request.setAttribute("slmOperationRecordList", btcPager.getDatas());
		}
		return "/finance/withdrawBtc3";
	}
	

	
	
	//网络流通币提现页面
	@RequestMapping(params="withdrawXnb")
	public String withdrawXnb(String xnbType, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			XnbOperationRecord xnbOperationRecord = new XnbOperationRecord();
			xnbOperationRecord.setLoginname(frontUserM.getUserName());
			xnbOperationRecord.setXnbtype(xnbType);
			SystemContext syct=new SystemContext();
			syct.setNumPerPage(10);
			syct.setPageNum(1);
			Pager<XnbOperationRecord> btcPager = financeService.findXnbOperationRecord(syct, xnbOperationRecord);
			
			if("BTC".equals(xnbType)){
				request.setAttribute("btcOperationRecordList", btcPager.getDatas());
				return "/finance/withdrawBtc";
			}else if("BTC".equals(xnbType)){
				request.setAttribute("ltcOperationRecordList", btcPager.getDatas());
				return "/finance/withdrawBtc2";
			}else if("SLM".equals(xnbType)){
				request.setAttribute("slmOperationRecordList", btcPager.getDatas());
				return "/finance/withdrawBtc3";
			}
		}
		return "/test/index";
	}
	
	//增加网络流通币提现
	@RequestMapping(params="withdrawXnbSubmit")
	public String withdrawXnbSubmit(XnbOperationRecord record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			record.setLoginname(frontUserM.getUserName());
			record.setUsernickname(frontUserM.getNickName());
			record.setUserrealname(frontUserM.getRealName());
			financeService.addXnbOperationRecord(record);
			
			withdrawXnb(record.getXnbtype(), session, request, response);
		}
		return "/test/index";
	}
	
	//账单明细页面
	@RequestMapping(params="record")
	public String record(String recordType, String symbol,  HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			String page = request.getParameter("page");
			if (page == null) {
				page = "1";
			}
			SystemContext syct=new SystemContext();
			syct.setPageNum(Integer.parseInt(page));
			long pageTimes;// 页数
			int pageSize = 10;// 每页显示记录数
			syct.setNumPerPage(pageSize);
			
			if("0".equals(recordType)){	//人民币
				RmbOperationRecord rmbOperationRecord = new RmbOperationRecord();
				rmbOperationRecord.setLoginname(frontUserM.getUserName());
				if("0".equals(symbol)){
					rmbOperationRecord.setTradingtype("人民币充值");
					
				}else if("1".equals(symbol)){
					rmbOperationRecord.setTradingtype("人民币在线充值");
				}
				SystemContext syct2=new SystemContext();
				syct2.setNumPerPage(10);
				syct2.setPageNum(1);
				Pager<RmbOperationRecord> btcPager = financeService.findRmbOperationRecord(syct2, rmbOperationRecord);
			}else if("".equals(recordType)){	
				
			}else if("0".equals(recordType)){	
				
			}
			
			EntrustTrading entrustTrading = new EntrustTrading();
			entrustTrading.setLoginname(frontUserM.getUserName());
			Pager<EntrustTrading> pager = financeService.findEntrustTrading(syct, entrustTrading);
			long totalNum = pager.getTotalCount();// 总记录数
			if (totalNum % pageSize == 0) {
				pageTimes = totalNum / pageSize;
			} else {
				pageTimes = totalNum / pageSize + 1;
			}

			try {
				request.setAttribute("recordList", pager.getDatas());
				request.setAttribute("totalNum", totalNum);
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.setAttribute("pageTimes", pageTimes);
			} catch (Exception e) {

			}
			return "/finance/record";
		}
		return "/test/index";
		
//		return "/finance/record";
	}
	
	//委托明细页面
	@RequestMapping(params="listentrust")
	public String listentrust(String symbol, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			String page = request.getParameter("page");
			if (page == null) {
				page = "1";
			}
			SystemContext syct=new SystemContext();
			syct.setPageNum(Integer.parseInt(page));
			long pageTimes;// 页数
			int pageSize = 10;// 每页显示记录数
			syct.setNumPerPage(pageSize);
			EntrustTrading entrustTrading = new EntrustTrading();
			entrustTrading.setLoginname(frontUserM.getUserName());
			if("2".equals(symbol)){
				entrustTrading.setTradingtype("比特币");
			}else if("2".equals(symbol)){
				entrustTrading.setTradingtype("莱特币");
			}else if("3".equals(symbol)){
				entrustTrading.setTradingtype("斯利姆币");
			}
			Pager<EntrustTrading> pager = financeService.findEntrustTrading(syct, entrustTrading);
			long totalNum = pager.getTotalCount();// 总记录数
			if (totalNum % pageSize == 0) {
				pageTimes = totalNum / pageSize;
			} else {
				pageTimes = totalNum / pageSize + 1;
			}

			try {
				request.setAttribute("entrustTradingList", pager.getDatas());
				request.setAttribute("totalNum", totalNum);
				request.setAttribute("currentPage", Integer.parseInt(page));
				request.setAttribute("pageTimes", pageTimes);
			} catch (Exception e) {

			}
			return "/finance/listentrust";
		}
		return "/test/index";
	}

	//虚拟币提现
	@RequestMapping(params="withdrawXnbt")
	@ResponseBody
	public Json withdrawXnbt(WaitAuditxnbt xnbt, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			Userxnb xnb = userxnbService.getUserxnbByLoginNameAndType(frontUserM.getUserName(), xnbt.getXnbtype());
			if(xnb != null ){
				//判断用户提现的虚拟币是否足够提现
				Double canUseXnb = xnb.getUserallnum() - xnb.getUserfreezenum() - xnbt.getNum();
				if(canUseXnb >= 0 ){
					//足够，则插入待审核虚拟币提现列表，虚拟币操作列表，冻结对应虚拟币的数量（冻结的数量不能再操作，包括提现/交易）
					xnbt.setLoginname(xnb.getLoginname());
					xnbt.setUsernickname(xnb.getUsernickname());
					xnbt.setUserrealname(xnb.getUserrealname());
					waitAuditxnbtService.addWaitAuditxnbt(xnbt);
					j.setMsg("0");
					j.setSuccess(true);
				}else {
					//否则，返回提示虚拟币数量不足
					j.setMsg("-1");
					j.setSuccess(false);
				}
			}else {
				j.setSuccess(false);
			}
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	//取消虚拟币提现
	@RequestMapping(params="cancelWithdrawXnbt")
	@ResponseBody
	public Json cancelWithdrawXnbt(WaitAuditxnbt xnbt, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			waitAuditxnbtService.cancelWaitAuditxnbtById(xnbt.getWaitauditxnbtId());
			j.setMsg("0");
			j.setSuccess(true);
		}else {
			j.setSuccess(false);
			j.setMsg("-1");
		}
		return j;
	}
	
	//虚拟币充值
	@RequestMapping(params="rechargeXnbc")
	@ResponseBody
	public Json rechargeXnbc(WaitAuditxnbt xnbt, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		
		return j;
	}
		
	//人民币提现
	@RequestMapping(params="withdrawRmbw")
	@ResponseBody
	public Json withdrawRmbw(WaitAuditrmbw rmbw, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			MemberMoney mm = memberMoneyService.getMemberMoneyByLoginName(frontUserM.getUserName());
			if(mm != null ){
				//判断用户提现的人民币是否足够提现
				Double canUsermb = mm.getUserallmoney() - mm.getUserfreezemoney() - rmbw.getMoney();
				if(canUsermb >= 0 ){
					//足够，则插入待审核人民币提现列表，人民币操作列表，冻结对应人民币的数量（冻结的数量不能再操作，包括提现/交易）
					rmbw.setLoginname(mm.getLoginname());
					rmbw.setUsernickname(mm.getUsernickname());
					rmbw.setUserrealname(mm.getUserrealname());
					waitAuditrmbwService.addWaitAuditrmbw(rmbw);
					j.setMsg("0");
					j.setSuccess(true);
				}else {
					//否则，返回提示人民币数量不足
					j.setMsg("-1");
					j.setSuccess(false);
				}
			}else {
				j.setSuccess(false);
			}
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	//取消人民币提现
	@RequestMapping(params="cancelWithdrawRmbw")
	@ResponseBody
	public Json cancelWithdrawRmbw(WaitAuditrmbw rmbw, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			waitAuditrmbwService.cancelWaitAuditrmbwById(rmbw.getWaitauditrmbwId());
			j.setMsg("0");
			j.setSuccess(true);
		}else {
			j.setSuccess(false);
			j.setMsg("-1");
		}
		return j;
	}
		
	//人民币充值
	@RequestMapping(params="rechargeRmbc")
	@ResponseBody
	public Json rechargeRmbc(WaitAuditrmbt rmbt, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			waitAuditrmbtService.addWaitAuditrmbt(rmbt);
			j.setMsg("0");
			j.setSuccess(true);
		}else {
			j.setSuccess(false);
			j.setMsg("-1");
		}
		return j;
	}
}
