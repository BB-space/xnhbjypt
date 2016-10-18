package com.sykj.app.web.controller.user;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sykj.app.entity.user.User;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.UserM;

import com.sykj.app.service.user.AppUserService;
import com.sykj.app.service.user.UserService;
import com.sykj.app.util.UploadUtil;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/tmallMember")
public class TmallMemberController extends BaseController{
	
	@Resource
	private UserService userService;
	@Resource
	private AppUserService appUserService;

	
	/**
	 * 跳转到用户管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String user(HttpServletRequest request,HttpSession session) {
		UserM userM = (UserM) session.getAttribute("userM");
		request.setAttribute("userType", userM.getUserType());
		return "/user/tmallMember";
	}
	/**
	 * 用户注销
	 * 
	 * @param session
	 * @return
	 */
	
	@RequestMapping(params="logout")
	@ResponseBody
	public Json logout(HttpSession session) {
		Json j = new Json();
		if (session != null) {
			session.invalidate();
		}
		j.setSuccess(true);
		return j;
	}
	
	
	/**
	 * 添加会员用户
	 * 
	 * @param user
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Json add(HttpServletRequest request,UserM user,@RequestParam MultipartFile files) throws IOException {
		Json j = new Json();
		String pic = UploadUtil.handleImage(request, files);
		user.setAvatar(pic);
		user.setUserType("2");
		userService.addUsers(user);
		j.setSuccess(true);
		j.setMsg("添加成功!");
		return j;
	}



	
	/**
	 * 删除会员用户
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params="del")
	@ResponseBody
	public Json del(String ids) {
		Json j = new Json();
		userService.deleteUser(ids);
		j.setSuccess(true);
		return j;
	}
}
