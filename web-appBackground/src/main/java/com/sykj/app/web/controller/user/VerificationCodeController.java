package com.sykj.app.web.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.user.VerificationCode;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.user.VerificationCodeService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/verification")
public class VerificationCodeController extends BaseController{
	@Autowired
	private VerificationCodeService verificationCodeService;
	
	@RequestMapping(params="index")
	public String index(){
		return "/user/verification";
	}
	
	/**
	 * 获得所有未失效注册验证表格
	 * 
	 * @param dg
	 * @param City
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, VerificationCode code) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return verificationCodeService.datagrid(syct, code);
	}

}
