package com.sykj.app.web.controller.test;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.model.FrontUserM;
import com.sykj.app.model.Json;
import com.sykj.app.service.user.FrontUserService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/test")
public class TestController extends BaseController{
	@Resource
	private FrontUserService frontUserService;
	
	@RequestMapping(params="index")
	public String index() {
		
		return "/test/index";
	}
	
	@RequestMapping(params="frontLogin")
	@ResponseBody
	public Json login(FrontUserM user, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = frontUserService.login(user.getUserName(), user.getPassword());
		if (frontUserM != null) {
			session.setAttribute("frontUserM", frontUserM);
			j.setMsg("登录成功!");
			j.setSuccess(true);
			j.setObj(frontUserM);
		}else{

		}
		return j;
	}
	
	@RequestMapping(params="logout")
	public String logout(HttpSession session, HttpServletRequest req,HttpServletResponse response) {
		session.setAttribute("frontUserM", null);
		return "/test/index";
	}
	
	@RequestMapping(params="register")
	@ResponseBody
	public Json register(FrontUserM user, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		System.out.println(user);
		Json j = new Json();
		
		FrontUserM frontUserM = frontUserService.register(user);
		if (frontUserM != null) {
			session.setAttribute("userM", frontUserM);
			j.setMsg("注册成功!");
			j.setSuccess(true);
			j.setObj(frontUserM);
		}else{

		}
		return j;
	}

	/**
	 * 检查手机/邮箱是否已经存在
	 * @param userName
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="checkUserName")
	@ResponseBody
	public Json checkUserName(String userName, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		boolean b = frontUserService.checkUserName(userName);
		j.setSuccess(b);
		return j;
	}
	
	/**
	 * 校验图片验证码
	 * @param checkCode
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="checkcode")
	@ResponseBody
	public Json checkCode(String checkCode, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		String code = (String) session.getAttribute("code");
		if(code.equalsIgnoreCase(checkCode)){
			j.setSuccess(true);
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 邮件激活验证
	 * @return
	 */
	@RequestMapping(params="validate")
	public String validate(String uid, String uuid, HttpSession session) {
		int result = frontUserService.validate(uid, uuid);
		if(result == 0){
			//激活成功
			FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
			if(frontUserM != null){
				frontUserM.setEmailStatus("1");
				session.setAttribute("frontUserM", frontUserM);
			}
			
		}
		
		return "/test/index";
	}
}
