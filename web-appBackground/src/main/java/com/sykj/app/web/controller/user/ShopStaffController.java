package com.sykj.app.web.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.sykj.app.util.UploadUtil;
import com.sykj.app.web.controller.BaseController;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.app.service.user.AppUserService;
import com.sykj.app.service.user.UserService;

/**
 * 门店管理员工
 * zq
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/shopStaff")
public class ShopStaffController extends BaseController{
	
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
	public String user() {
		return "/user/shopStaff";
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
	 * 所有店长用户的表格
	 * 
	 * @param dg
	 * @param user
	 * @return
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request, UserM userM,
			EasyuiDataGrid dg) {
		UserM um=(UserM) request.getSession().getAttribute("userM");
		//UserInformation u=appUserService.getId(um.getId());
		userM.setId(um.getId());
		userM.setUserType(um.getUserType());
		return userService.datagridShop(dg,userM,um.getShopId(),"staff");
	}


	/**
	 * 添加店长用户
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Json add(HttpServletRequest request,UserM userM,@RequestParam MultipartFile files) throws IOException {
		String pic = UploadUtil.handleImage(request, files);
		userM.setAvatar(pic);
		userM.setUserType("1");
		User u=userService.findByUserName(userM.getUserName());
		Integer count=userService.getCount(userM.getShopId());
		Json j = new Json();
		if(u !=null){
			j.setObj("1");
			j.setMsg("添加失败");
		}else if(count!=0){
			j.setObj("2");
			j.setMsg("添加失败");
		}else{
			userService.addUsers(userM);
			j.setObj("3");
			j.setMsg("添加成功");
		}
		return j;
	}

	/**
	 * 编辑员工用户
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public Json edit(HttpServletRequest request,UserM userM,@RequestParam MultipartFile files) throws IOException {
		Json j = new Json();
		if(UploadUtil.handleImage(request,files)!=null){
			userM.setAvatar(UploadUtil.handleImage(request,files));
		}
		User u=userService.findByNameAndMobile(userM.getUserName(), userM.getId(), "");
		User users=userService.findByNameAndMobile("",userM.getId(),userM.getMobile());
		if(u !=null){
			j.setObj("1");
			j.setSuccess(false);
			j.setMsg("用户名称已存在！");
		}else if(users!=null){
			j.setObj("2");
			j.setSuccess(false);
			j.setMsg("输入的电话号码已存在！");
		}else{
			j.setObj("3");
			userService.editType(userM,"1");
			j.setSuccess(true);
			j.setMsg("用户编辑成功!");
		}
		return j;
	}
	
	/**
	 * 删除员工用户
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
