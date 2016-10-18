
package com.sykj.app.web.controller.user;

import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.util.RequestUtil;
import com.sykj.app.util.SecurityUtil;
import com.sykj.app.web.controller.BaseController;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.entity.user.User;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;

import com.sykj.app.service.area.ShopService;

import com.sykj.app.service.system.MenuService;
import com.sykj.app.service.system.RoleService;
import com.sykj.app.service.user.AppUserService;
import com.sykj.app.service.user.UserService;
@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	
	@Resource
	private UserService userService;
	@Resource
	private AppUserService appUserService;
	@Resource
	private MenuService menuService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private RoleService roleService;

	
	/**
	 * 跳转到用户管理页面
	 * 
	 * @return
	 */
	@RequestMapping(params="index")
	public String user() {
		return "/user/user";
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
	 * 所有用户的表格
	 * 
	 * @param dg
	 * @param user
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="datagrid")
	@ResponseBody
	public EasyuiDataGridJson datagrid(HttpServletRequest request,
			EasyuiDataGrid dg, UserM userM) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
//		System.out.println(syct.getNumPerPage()+"\t"+syct.getPageNum()+"**"+userM.getCreateDateTime());
		return userService.datagrid(syct, userM);
	}

	
	
	/**
	 * 添加用户
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(params="add")
	@ResponseBody
	public Json add(UserM user) {
		Json j = new Json();
		User u=userService.findByUserName(user.getUserName());
		if(u !=null){
			j.setSuccess(false);
			j.setMsg("用户名称已存在!");
		}else{
			userService.addUser(user);
			j.setSuccess(true);
			j.setMsg("用户创建成功!");
		}
		return j;
	}

	/**
	 * 编辑用户
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(params="edit")
	@ResponseBody
	public Json edit(UserM user) {
		User u=userService.findByNameAndMobile(user.getUserName(), user.getId(), "");
		Json j = new Json();
		if(u !=null){
			j.setSuccess(false);
			j.setMsg("用户名称已存在！");
		}else{
			userService.editUser(user);
			j.setSuccess(true);
			j.setMsg("用户编辑成功!");
		}
		return j;
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
	 * 删除用户
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
	
	/**
	 * 用户登录
	 * @param user
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "bgLogin")
	@ResponseBody
	public Json login(UserM user, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		UserM u =userService.login(user.getUserName(), user.getUserPassword());
		Json j = new Json();
			if (u != null) {
				RequestUtil.addUserCookie(response, user);//添加用户到cookie
				HashSet<String> set = menuService.roleMenuIdSet(u);
				u.setRoleMenuIdSet(set);
				if(u.getText().equals("区域门店")){
					List<Shop> list=null;
					if(u.getCityGroup()!=null && !u.getCityGroup().equals("")){
						list=shopService.findByCityGroup(u.getCityGroup());
					}else{
						list=shopService.getZYShopByCityId(u.getCityId());
					}
					session.setAttribute("shopList", list);
					session.setAttribute("user", u);
				}
//				if(u.getUserType().equals("10")||u.getUserType().equals("13")){
//					ContractM cm = contractService.getByRegId(u.getId());
//					if(cm!=null&&cm.getAuditStatus()!=1){
//						session.setAttribute("userM", u);
//						j.setMsg("审核");
//						j.setSuccess(true);
//						j.setObj(u);
//						return j;
//					}
//				}
				session.setAttribute("userM", u);
				j.setMsg("登录成功!");
				j.setSuccess(true);
				j.setObj(u);
			}else{

			}
		return j;
	}
	
	/**
	 * 用户登录
	 * @param user
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "bgLogins")
	@ResponseBody
	public Json logins(UserM user, HttpSession session,
			HttpServletRequest request,HttpServletResponse response,String companyCode) {
		UserM u=null;
		Json j = new Json();
		if(user.getUserName()==null){
			user = (UserM)session.getAttribute("userM");
			Shop s=shopService.getByShortNumber(companyCode);
			if(s!=null){
				User users=userService.finsByShopIdAndUserType(s.getId());
				if(users!=null){
				u =userService.findByNamePwd(users.getUserName(), users.getUserPassword());
				if (u != null) {
					RequestUtil.addUserCookie(response, user);//添加用户到cookie
					HashSet<String> set = menuService.roleMenuIdSet(u);
					u.setRoleMenuIdSet(set);
					u.setCityGroup(user.getCityGroup());
					u.setText("区域门店");
					session.setAttribute("companyCode", companyCode);
					session.setAttribute("userM", u);
					j.setMsg("登录成功!");
					j.setSuccess(true);
					j.setObj(u);
				}
				}else{
					j.setMsg("此店没有用户!");
					j.setSuccess(false);
				}
			}else{
				user = (UserM)session.getAttribute("user");
				if (user != null) {
					RequestUtil.addUserCookie(response, user);//添加用户到cookie
					HashSet<String> set = menuService.roleMenuIdSet(user);
					user.setRoleMenuIdSet(set);
					session.setAttribute("companyCode", companyCode);
					session.setAttribute("user", user);
					session.setAttribute("userM",user);
					j.setMsg("登录成功!");
					j.setSuccess(true);
					j.setObj(u);
				}
			}
			}else{
				j.setSuccess(false);
			}
		return j;
	}
	
	/**
	 * 根据用户名查询用户
	 * @param userName
	 * @return
	 */
	@RequestMapping(params = "fingByUserName")
	@ResponseBody
	public Json fingByUserName(String userName, HttpSession session) {
		User user = userService.findByUserName(userName,"2");
		Json j = new Json();
		if (user != null) {
			j.setSuccess(false);
		} else {
			j.setSuccess(true);
		}
		return j;
	}
	
	/**
	 * 判断手机号是否存在
	 */
	@RequestMapping(params="findUser")
	@ResponseBody
	public Json findUser(String mobile) {
		Json j = new Json();
		User u = userService.findByMobile(mobile);
		if(u != null){
			j.setSuccess(true);
		}else{
			j.setSuccess(false);
		}
		return j;
	}
	
	@RequestMapping(params="modifyPwd")
	@ResponseBody
	public Json modifyPwd(HttpServletRequest request,HttpSession session) {
		UserM userM = (UserM)session.getAttribute("userM");
		Json json = new Json();
		String original = request.getParameter("original");
		String newPwd = request.getParameter("newPwd");
		String newPwdConfim = request.getParameter("newPwdConfim");
		if(!userM.getUserPassword().equals(original)) {
			if(!userM.getUserPassword().equals(SecurityUtil.md5(original))){
				json.setSuccess(false);
				json.setMsg("输入的当前密码有误");
				return json;
			}
		}
		if(newPwd.equals(newPwdConfim)) {
			userM.setUserPassword(newPwd);
			userService.editUser(userM);
			json.setSuccess(true);
			json.setMsg("修改成功");
		}else {
			json.setMsg("");
			json.setSuccess(false);//两次输入的密码不一致
		}
		return json;
	}
}
