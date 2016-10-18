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
 * 天猫总部用户
 * @author lsy
 *
 */
@Controller
@RequestMapping("/tbHeadQuarter")
public class TBHeadQuarterController extends BaseController{

	@Resource
	private UserService userService;
	
	@RequestMapping(params="index")
	public String user() {
		return "/user/tbHeadQuarter";
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(EasyuiDataGrid dg, UserM userM) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return userService.subcenterUserDatagrid(syct, userM,"12");
	}
	@RequestMapping(params="add")
	@ResponseBody
	public Json add(HttpServletRequest request,UserM user,@RequestParam MultipartFile files) throws IOException {
		Json j = new Json();
		String pic = UploadUtil.handleImage(request, files);
		user.setAvatar(pic);
		user.setUserType("12");
		userService.addUsers(user);
		j.setSuccess(true);
		j.setMsg("添加成功!");
		return j;
	}
	
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
			userService.editType(user,"12");
			j.setSuccess(true);
			j.setMsg("用户编辑成功！");
		}
		return j;
	}
}
