package com.sykj.app.web.controller.user;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.UserM;

import com.sykj.app.service.user.AppUserService;
import com.sykj.app.service.user.UserService;
import com.sykj.app.util.UploadUtil;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/staff")
public class StaffUserController extends BaseController{
	
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
		return "/user/staff";
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
	 * 所有员工用户的表格
	 * 
	 * @param dg
	 * @param user
	 * @return
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request, UserM userM,
			EasyuiDataGrid dg) {
		return userService.datagrids(dg,userM,"1");
	}
	

	/**
	 * 添加员工用户
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public UserM add(HttpServletRequest request,UserM user,@RequestParam MultipartFile files) throws IOException {
	
		String pic = UploadUtil.handleImage(request, files);
		user.setAvatar(pic);
		user.setUserType("1");
	
		return userService.addUsers(user);
	}



	/**
	 * 批量编辑用户角色
	 * 
	 * @param userIds
	 *            用户ID
	 * @param roleId
	 *            角色ID
	 * @return
	 */
	@RequestMapping(params="editUsersRole")
	@ResponseBody
	public Json editUsersRole(String userIds, String roleId) {
		Json j = new Json();
		userService.editUsersRole(userIds, roleId);
		j.setSuccess(true);
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
