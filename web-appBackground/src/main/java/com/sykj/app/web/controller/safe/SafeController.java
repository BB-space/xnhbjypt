package com.sykj.app.web.controller.safe;

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
@RequestMapping("/safe")
public class SafeController extends BaseController{
	@Resource
	private FrontUserService frontUserService;
	
	@RequestMapping(params="safeSetting")
	public String safeSetting(HttpSession session) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			if(b){  //已经实名认证
				return "/safe/safe_safeSetting";
			}
		}
		return "/safe/safe_userSetting";
	}
	
	@RequestMapping(params="userSetting")
	public String userSetting(HttpSession session) {
		
		return "/safe/safe_userSetting";
	}

	/**
	 * 用户设置--实名认证
	 * @param user
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="validateIdentity")
	@ResponseBody
	public Json validateIdentity(FrontUserM user, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			user.setId(frontUserM.getId());
			frontUserService.validateIdentity(user);
			frontUserM.setRealName(user.getRealName());
			frontUserM.setCardType(user.getCardType());
			frontUserM.setCardNumber(user.getCardNumber());
			session.setAttribute("frontUserM", frontUserM);
			j.setSuccess(true);
			j.setObj(frontUserM);
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 用户设置--修改昵称
	 * @param userName
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="updateNickName")
	@ResponseBody
	public Json updateNickName(String nickName, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			frontUserM.setNickName(nickName);
			frontUserService.updateNickName(frontUserM);
			session.setAttribute("frontUserM", frontUserM);
			j.setSuccess(true);
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 绑定邮箱
	 * @param email
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="emailBound")
	@ResponseBody
	public Json emailBound(String email, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			if("1".equals(frontUserM.getEmailStatus())){
				j.setSuccess(false);
				j.setMsg("1");
			}else {
				frontUserM.setEmail(email);
				frontUserService.saveEmail(frontUserM);
				frontUserService.sendEmail(email, frontUserM.getUid(), frontUserM.getUuid());
				j.setSuccess(true);
			}
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 绑定手机
	 * @param fum
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="mobileBound")
	@ResponseBody
	public Json mobileBound(FrontUserM fum, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			if("1".equals(frontUserM.getMobileStatus())){
				j.setSuccess(false);
				j.setMsg("1");
			}else {
				frontUserM.setMobile(fum.getMobile());
				frontUserM.setLocation(fum.getLocation());
				frontUserM.setMobileStatus("1");
				frontUserService.saveMobile(frontUserM);
				session.setAttribute("frontUserM", frontUserM);
				j.setSuccess(true);
				j.setObj(frontUserM);
			}
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 解绑手机
	 * @param fum
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="mobileUnbound")
	@ResponseBody
	public Json mobileUnbound(FrontUserM fum, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			frontUserM.setMobile("");
			frontUserM.setLocation("");
			frontUserM.setMobileStatus("0");
			frontUserService.saveMobile(frontUserM);
			session.setAttribute("frontUserM", frontUserM);
			j.setSuccess(true);
			j.setObj(frontUserM);
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 修改登陆密码
	 * @param fum
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="changePassword")
	@ResponseBody
	public Json changePassword(FrontUserM fum, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			
			frontUserService.changePassword(frontUserM);
			session.setAttribute("frontUserM", frontUserM);
			j.setSuccess(true);
			j.setObj(frontUserM);
		}else {
			j.setSuccess(false);
		}
		return j;
	}
	
}
