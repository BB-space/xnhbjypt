package com.sykj.app.web.controller.test;

import java.io.IOException;
import java.io.PrintWriter;

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
import com.sykj.app.util.Jypt;
import com.sykj.app.util.SMSUtil;
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
			if("禁用".equals(frontUserM.getStatus())){
				//用户被禁用，不能登陆
				j.setSuccess(false);
				j.setMsg("用户被禁用，请联系管理员接触禁用");
			}else {
				session.setAttribute("frontUserM", frontUserM);
				j.setMsg("登录成功!");
				j.setSuccess(true);
				j.setObj(frontUserM);
			}
		}else{
			j.setSuccess(false);
			j.setMsg("用户名或密码错误，请重新输入！");
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
		
		if("mobile".equals(user.getRegType())){
			if(!"888888".equals(user.getMobileCheckCode())){	//手机验证码不正确
				j.setSuccess(false);
				j.setMsg("1");
				return j;
			}
		}
		user.setIp(Jypt.server_ip);
		FrontUserM frontUserM = frontUserService.register(user);
		if (frontUserM != null) {
			session.setAttribute("frontUserM", frontUserM);
			j.setMsg("注册成功!");
			j.setSuccess(true);
			j.setObj(frontUserM);
		}else{

		}
		return j;
	}

	/**
	 * 给手机发送验证码
	 * @param mobile
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params="sendCheckCode")
	@ResponseBody
	public Json sendCheckCode(String mobile, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) throws Exception {
		Json j = new Json();
		
//		String mobileCheckCode = (int)((Math.random()*9+1)*100000) + "";
		String mobileCheckCode = "888888";
		String content = "【数字资产交易平台】您的验证码是："+mobileCheckCode+"。请不要把验证码泄露给他人，如非本人操作，请勿理会！";
//		SMSUtil.sendTextSms(mobile, content);
		session.setAttribute("mobileCheckCode", mobileCheckCode);
		
		return j;
	}
	
	@RequestMapping(params="resetCheckCode")
	@ResponseBody
	public Json resetCheckCode(HttpSession session,
			HttpServletRequest req,HttpServletResponse response) throws Exception {
		Json j = new Json();
		session.setAttribute("mobileCheckCode", null);
		return j;
	}
	
	/**
	 * 校验手机验证码是否正确
	 * @param mobileCheckCode
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params="checkMobileCode")
	@ResponseBody
	public Json checkMobileCode(String mobileCheckCode, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) throws Exception {
		Json j = new Json();
		
		String checkCode = (String) session.getAttribute("mobileCheckCode");
		if(checkCode != null && checkCode.equals(mobileCheckCode)){
			j.setSuccess(true);
		}else {
			j.setSuccess(false);
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
	public void validate(String uid, String uuid, HttpSession session,
			HttpServletRequest request,HttpServletResponse response)  throws IOException{
		String tip = "";
		int result = frontUserService.validate(uid, uuid);
		if(result == 0){
			tip = "尊敬的用户，您的账号已激活，请点击登录！";
		}else if(result == -1){
			tip = "该邮箱未注册（邮箱地址不存在）";
		}else if(result == -2){
			tip = "该账号已激活";
		}else if(result == -3){
			tip = "激活码不正确";
		}
		
		StringBuilder builder = new StringBuilder(); 
        builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");  
		String path =request.getContextPath();
	    response.setContentType("text/html; charset=utf-8"); 
	    builder.append("alert(\""+tip+"\");");
        PrintWriter out = response.getWriter();  
        builder.append("window.top.location.href=\"");
        builder.append(path);
        builder.append("\";");
        builder.append("</script>");  
        out.print(builder.toString());  
        out.close();
		
//		return "/test/index";
	}
	
	//前台重置密码
	@RequestMapping(params="resetPassword")
	@ResponseBody
	public Json resetPassword(String userName, String password, String mobileCheckCode, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		System.out.println(userName + "," + password+ ", " + mobileCheckCode);
		Json j = new Json();
//		String mobileCheckCode = (String) session.getAttribute("mobileCheckCode");
		if(!"888888".equals(mobileCheckCode)){	//手机验证码不正确
			j.setSuccess(false);
			j.setMsg("1");
			return j;
		}else {
			//重置密码
			frontUserService.updatePassword(userName, password);
			
			j.setSuccess(true);
			j.setMsg("0");
		}
		
		return j;
	}
	
}
