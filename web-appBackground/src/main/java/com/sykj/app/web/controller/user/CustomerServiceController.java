package com.sykj.app.web.controller.user;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sykj.app.entity.user.User;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.app.service.user.UserService;
import com.sykj.app.util.UploadUtil;
import com.sykj.app.web.controller.BaseController;

/**
 * 客服controller
 */
@Controller
@RequestMapping("/customer")
public class CustomerServiceController extends BaseController{

	@Resource
	private UserService userService;
	
	/**
	 * 跳转到客服列表页面
	 */
	@RequestMapping(params="index")
	public String customer() {
		return "/user/customer";
	}
	
	/**
	 * 所有客服列表
	 * 5:表示客服用户
	 */
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request, UserM userM,
			EasyuiDataGrid dg) {
		return userService.datagrids(dg,userM,"5");
	}
	
	/**
	 * 添加客服
	 * 5:表示客服用户
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Json add(HttpServletRequest request,UserM user,@RequestParam MultipartFile files) throws IOException {
		String pic = UploadUtil.handleImage(request, files);
		user.setAvatar(pic);
		user.setUserType("5");
		Json j = new Json();
		User u=userService.findByUserName(user.getUserName());
		User users=userService.findByMobile(user.getMobile());
		if(u !=null){
			j.setObj("1");
			j.setSuccess(false);
			j.setMsg("添加失败");
		}else if(users!=null){
			j.setObj("2");
			j.setSuccess(false);
			j.setMsg("添加失败");
		}else{
			j.setObj("3");
			userService.addUsers(user);
			j.setSuccess(true);
			j.setMsg("添加成功!");
		}
		return j;
	}
	
	/**
	 * 编辑客服
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public Json edit(HttpServletRequest request,UserM user,@RequestParam MultipartFile files) throws IOException {
		Json j = new Json();
		if(UploadUtil.handleImage(request,files)!=null){
			user.setAvatar(UploadUtil.handleImage(request,files));
		}
		User u=userService.findByNameAndMobile(user.getUserName(), user.getId(), "");
		User users=userService.findByNameAndMobile("",user.getId(),user.getMobile());
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
			userService.editType(user,"5");
			j.setSuccess(true);
			j.setMsg("用户编辑成功！");
		}
		return j;
	}
	
	/**
	 * 删除客服
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
