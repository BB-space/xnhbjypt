package com.sykj.app.web.controller.finance;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sykj.app.entity.finance.EntrustTrading;
import com.sykj.app.entity.finance.RmbOperationRecord;
import com.sykj.app.entity.finance.WaitAuditrmbt;
import com.sykj.app.entity.finance.WaitAuditrmbw;
import com.sykj.app.entity.finance.XnbOperationRecord;
import com.sykj.app.model.FrontUserM;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.finance.PersonFinance;
import com.sykj.app.service.finance.FinanceService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/finance")
public class FinanceController extends BaseController{
	
	@Resource
	private FinanceService financeService;
	
	//个人财务页面
	@RequestMapping(params="index")
	public String index(HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			PersonFinance pf = financeService.getPersonFinance(frontUserM.getUserName());
			request.setAttribute("personFinance", pf);
		}
		
		return "/finance/index";
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


}
