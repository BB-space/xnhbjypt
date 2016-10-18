package com.sykj.app.web.controller.user;

import java.util.HashSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.user.User;
import com.sykj.app.model.Json;
import com.sykj.app.model.UserM;
import com.sykj.app.service.area.ShopService;
import com.sykj.app.service.system.MenuService;

import com.sykj.app.service.user.AppUserService;
import com.sykj.app.service.user.MemberToEmployeesService;
import com.sykj.app.service.user.UserService;

import com.sykj.app.web.controller.BaseController;
/**
 * 前台用户登录注册控制器
 * @author swh
 *
 */
@Controller
@RequestMapping("/wxRegistered")
public class AppUserController extends BaseController{

	@Resource
	private AppUserService appUserService;
	@Autowired
	private UserService userService;

	@Resource
	private ShopService shopService;
	@Resource
	private MenuService menuService;
	/**
	 * 注册
	 * @return
	 */
	@RequestMapping(params="registered")
	@ResponseBody
	public Json registered(String mobile,String code,HttpSession session) {

		System.out.println("into registered");
		String wxUser = (String) session.getAttribute("wxUser");
		UserM userM = new UserM();
		userM.setUserName(mobile);
		userM.setUserPassword("888888");
		userM.setMobileCode(code);
		userM.setMobile(mobile);
		userM.setOpenId("");
		Json j = new Json();
		System.out.println(mobile+"****"+userM.getMobile());
		int a =appUserService.addBackgroundUser(userM,wxUser);
		j.setObj(a);
		switch(a){
			case 0:j.setMsg("/index");
			       j.setSuccess(true);
			       User u = userService.findByMobile(mobile);
			       UserM um =userService.findByNamePwd(u.getUserName(), u.getUserPassword());
			       HashSet<String> set = menuService.roleMenuIdSet(um);
			       um.setRoleMenuIdSet(set);
			       session.setAttribute("userM", um);
			       if(!um.getRoleId().equals("bfd7347d-4012-c876-78a3-3c6305e1d35e")) {
			    	   j.setSuccess(false);
			    	   j.setMsg("绑定失败，您还不是我们的门店店员！请联系店长");
			       }
			break;
			case 1:j.setMsg("绑定失败，请先在微信中进行会员绑定！");j.setSuccess(false);
			break;
			case 2:j.setMsg("绑定失败，您还不是我们的门店店员！请联系店长");j.setSuccess(false);
			break;
		}
		return j;
	}
	
	@RequestMapping(params="index")
	public String index() {
		return "/index";
	}
	

}
