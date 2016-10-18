package com.sykj.app.service.user.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.dao.area.SubcenterDao;
import com.sykj.app.dao.system.BusinessDao;
import com.sykj.app.dao.system.RoleDao;
import com.sykj.app.dao.user.FranchiseeDao;
import com.sykj.app.dao.user.UserBusinessDao;
import com.sykj.app.dao.user.UserDao;
import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.dao.user.UserRoleDao;
import com.sykj.app.dao.user.UserSubCenterDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.user.Franchisee;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserBusiness;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.entity.user.UserRole;
import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.user.UserService;
import com.sykj.app.util.SecurityUtil;
import com.sykj.common.core.DatabaseContextHolder;

@SuppressWarnings("unchecked")
@Service("userService")
public class UserServiceImpl extends BaseServiceImpl implements UserService{
	
	@Resource
	private UserDao userDao;
	@Resource
	private UserRoleDao userRoleDao;
	@Resource
	private RoleDao roleDao;
	@Resource
	private UserInformationDao userInformationDao;


	@Autowired
	private CityDao cityDao;
	@Autowired
	private ShopDao shopDao;
	@Resource
	private UserSubCenterDao userSubCenterDao;
	@Resource
	private SubcenterDao subcenterDao;
	@Resource
	private FranchiseeDao franchiseeDao;
	@Resource
	private UserBusinessDao userBusinessDao;
	@Resource
	private BusinessDao businessDao;
	
	@Override
	public UserM addUser(UserM userM) {
		User u=userDao.getUserByUsername(userM.getUserName(), userM.getUserType());
		if(u!=null){
			return null;
		}else{
			User user = new User();
			UserInformation ufm=new UserInformation();
			BeanUtils.copyProperties(userM, user);
			BeanUtils.copyProperties(userM, ufm);
			user.setUserPassword(SecurityUtil.md5(userM.getUserPassword()));
			user.setCreateDateTime(new Date());
			user.setId(UUID.randomUUID().toString());
			userDao.addUser(user);
			ufm.setId(UUID.randomUUID().toString());
			ufm.setUserId(user.getId());
			ufm.setAddress(userM.getAddress());
			ufm.setAvatar(userM.getAvatar());
			ufm.setEmail(userM.getEmail());
			ufm.setExperience(0);
			ufm.setIdCard(userM.getIdCard());
			ufm.setMobile(userM.getMobile());
			ufm.setNowCoin(0L);
			ufm.setOldShopId(userM.getOldShopId());
			ufm.setOpenId(userM.getOpenId());
			ufm.setPosition(userM.getPosition());
			ufm.setQq(userM.getQq());
			ufm.setRealname(userM.getRealname());
			ufm.setSex(userM.getSex());
			ufm.setShopId(userM.getShopId());
			ufm.setTotalCoin(0L);
			ufm.setUserLevel("");
			userInformationDao.add(ufm);
			if (userM.getRoleId() != null && !userM.getRoleId().equals("")) {
				for (String id : userM.getRoleId().split(",")) {
					UserRole userRole = new UserRole();
					userRole.setId(UUID.randomUUID().toString());
					userRole.setRole(roleDao.getRole(id));
					userRole.setUser(user);
					userRoleDao.add(userRole);
				}
			}
			if(userM.getBusinessId() != null && !userM.getBusinessId().equals("")) {
				for(String id : userM.getBusinessId().split(",")) {
					UserBusiness userBusiness = new UserBusiness();
					userBusiness.setId(UUID.randomUUID().toString());
					userBusiness.setBusiness(businessDao.getBusiness(id));
					userBusiness.setUser(user);
					userBusinessDao.addUserBusiness(userBusiness);
				}
			}
		return userM;
		}
	}

	@Override
	public void deleteUser(String ids) {
		for (String id : ids.split(",")) {
			User user = userDao.getUser(id);
			if (user != null) {
				Set<UserRole> userRoleSet = user.getUserRoles();
				if (userRoleSet != null && userRoleSet.size() > 0) {
					List<UserRole> userRoleList = userRoleDao.findByUser(user);
					if (userRoleList != null && userRoleList.size() > 0) {
						for (UserRole userRole : userRoleList) {
							userRoleDao.deleteUserRole(userRole.getId());
						}
					}
				}
				userDao.deleteUser(id);
				UserInformation u=userInformationDao.getUserInformationByUserId(id);
				userInformationDao.deleteUserInformation(u.getId());
			}

		}
		
	}

	@Override
	public UserM editUser(UserM userM) {
		User user = userDao.getUser(userM.getId());
		user.setEditDateTime(new Date());
		if(userM.getUserName() != null && !userM.getUserName().equals("")){
			user.setUserName(userM.getUserName());
		}
		if(userM.getUserPassword() != null && !userM.getUserPassword().equals("")){
				user.setUserPassword(SecurityUtil.md5(userM.getUserPassword()));
		}
		if(userM.getUserType() != null && !userM.getUserType().equals("")){
			user.setUserType(userM.getUserType());
		}
		if (user != null) {
			List<UserRole> userRoleList = userRoleDao.findByUser(user);
			System.out.println(userRoleList.size());
			if (userRoleList != null && userRoleList.size() > 0) {
				for (UserRole userRole : userRoleList) {
					userRoleDao.deleteUserRole(userRole.getId());;
				}
			}
			if (userM.getRoleId() != null && !userM.getRoleId().equals("")) {
				for (String id : userM.getRoleId().split(",")) {
					Role role = roleDao.getRole(id);
					if (role != null) {
						UserRole userRole = new UserRole();
						userRole.setId(UUID.randomUUID().toString());
						userRole.setRole(role);
						userRole.setUser(user);
						userRoleDao.addUserRole(userRole);
					}
				}
			}
			List<UserBusiness> userBusinessList = userBusinessDao.findByUser(user);
			if(userBusinessList != null && userBusinessList.size() > 0) {
				for(UserBusiness userBusiness : userBusinessList) {
					userBusinessDao.deleteUserBusiness(userBusiness.getId());
				}
			}
			if(userM.getBusinessId() != null && !userM.getBusinessId().equals("")) {
				for(String id : userM.getBusinessId().split(",")) {
					Business business = businessDao.getBusiness(id);
					if(business != null) {
						UserBusiness userBusiness = new UserBusiness();
						userBusiness.setId(UUID.randomUUID().toString());
						userBusiness.setBusiness(business);
						userBusiness.setUser(user);
						userBusinessDao.addUserBusiness(userBusiness);
					}
				}
			}
//				Role role = roleDao.findByuserType(user.getUserType());
//				if (role != null) {
//					UserRole userRole = new UserRole();
//					userRole.setId(UUID.randomUUID().toString());
//					userRole.setRole(role);
//					userRole.setUser(user);
//					userRoleDao.addUserRole(userRole);
//				}
			
		}
		UserInformation usf=userInformationDao.fingByUserId(user.getId());

		usf.setOldShopId(usf.getShopId());
		usf.setShopId(null);
		userInformationDao.editUserInformation(usf);
		userDao.editUser(user);
		return userM;
	}

	
	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, UserM userM) {
		//System.out.println(syct.getNumPerPage()+"*"+syct.getPageNum());
		EasyuiDataGridJson edgj = new EasyuiDataGridJson();
		Pager<User> userPager=userDao.findUser(syct,userM);
		List<UserM> userMs = new ArrayList<UserM>();
		List<User> userList = userPager.getDatas();
		if (userList != null && userList.size() > 0) {// 转换模型
			for (User user : userList) {
				UserM u = new UserM();
				BeanUtils.copyProperties(user, u);

				Set<UserRole> userRoleSet = user.getUserRoles();
				if (userRoleSet != null && userRoleSet.size() > 0) {
					boolean b = false;
					String roleId = "";
					String roleText = "";
					for (UserRole userRole : userRoleSet) {
						if (!b) {
							b = true;
						} else {
							roleId += ",";
							roleText += ",";
						}
						roleId += userRole.getRole().getId();
						roleText += userRole.getRole().getText();
					}
					u.setRoleId(roleId);
					u.setRoleText(roleText);
				}
				
				Set<UserBusiness> userBusinessSet = user.getUserBusinesses();
				if(userBusinessSet != null && userBusinessSet.size() > 0) {
					boolean flag = false;
					String businessId = "";
					String businessText = "";
					for(UserBusiness userBusiness : userBusinessSet) {
						if(!flag) {
							flag = true;
						}else {
							businessId += ",";
							businessText += ",";
						}
						businessId += userBusiness.getBusiness().getId();
						businessText += userBusiness.getBusiness().getText();
					}
					u.setBusinessId(businessId);
					u.setBusinessText(businessText);
				}
//				System.out.println(u.getUserName()+"****");
				userMs.add(u);
			}
		}
		edgj.setRows(userMs);
		edgj.setTotal(userPager.getTotalCount());
		return edgj;
	}
	
	//批量修改用户角色
	@Override
	public void editUsersRole(String userIds, String roleId) {
		for (String userId : userIds.split(",")) {
			User user = userDao.get(User.class, userId);
			if (user != null) {
				List<UserRole> userRoleList = userRoleDao.findByUser(user);
				if (userRoleList != null && userRoleList.size() > 0) {
					for (UserRole userRole : userRoleList) {
						userRoleDao.deleteUserRole(userRole.getId());;
					}
				}
				if (roleId != null && !roleId.equals("")) {
					for (String id : roleId.split(",")) {
						Role role = roleDao.get(Role.class, id);
						if (role != null) {
							UserRole userRole = new UserRole();
							userRole.setId(UUID.randomUUID().toString());
							userRole.setRole(role);
							userRole.setUser(user);;
							userRoleDao.add(userRole);
						}
					}
				}
			}
		}
		
	}

	@Override
	public UserM login(String name, String password) {
		UserM um = null;
		User user = userDao.getUserByNamePassword(name, SecurityUtil.md5(password));
		if(user!=null){
			um = new UserM();
			BeanUtils.copyProperties(user,um);
			UserRole role = userRoleDao.getUserRoleByUserId(user.getId());
			um.setRoleId(role.getRole().getId());
			um.setText(role.getRole().getText());
			UserBusiness business = userBusinessDao.getUserBusinessByUserId(user.getId());
			if(business != null && business.getBusiness() != null) {
				um.setBusinessId(business.getBusiness().getId());
				um.setBusinessText(business.getBusiness().getText());
			}
			UserInformation userInfo = userInformationDao.getUserInformationByUserId(user.getId());
			if(userInfo!=null){
				if(userInfo.getShopId()!=null && !userInfo.getShopId().equals("")){
					Shop shop = shopDao.getShop(userInfo.getShopId());
					if(shop!=null){
						um.setShopId(shop.getId());
						um.setShopName(shop.getShopName());
						um.setBelongShopType(shop.getBelong());
						um.setShortNumber(shop.getShortNumber());
//						um.setCityId(shop.getCityId());
					}
				}
				um.setCityId(userInfo.getCityId());
				um.setCityGroup(userInfo.getCityGroup());
			}
			return um;
		}
		return null;
	}
	
	@Override
	public UserM findByNamePwd(String name, String password) {
		UserM um = null;
		User user = userDao.getUserByNamePassword(name,password);
		if(user!=null/*&&user.getUserType().trim().equals("0")*/){
			um = new UserM();
			BeanUtils.copyProperties(user,um);
			UserRole role = userRoleDao.getUserRoleByUserId(user.getId());
			um.setRoleId(role.getRole().getId());
			um.setText(role.getRole().getText());
			UserInformation userInfo = userInformationDao.getUserInformationByUserId(user.getId());
			if(userInfo!=null){
				if(userInfo.getShopId()!=null && !userInfo.getShopId().equals("")){
					Shop shop = shopDao.getShop(userInfo.getShopId());
					if(shop!=null){
						um.setShopId(shop.getId());
						um.setShopName(shop.getShopName());
						um.setBelongShopType(shop.getBelong());
						um.setShortNumber(shop.getShortNumber());
//						um.setCityId(shop.getCityId());
					}
				}
				um.setCityId(userInfo.getCityId());
				um.setCityGroup(userInfo.getCityGroup());
			}
			return um;
		}
		return null;
	}

	@Override
	public EasyuiDataGridJson datagrids(EasyuiDataGrid dg,UserM userM, String id) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		String sql = "  a.id id,a.username name,a.userpassword pass,b.userlevel userlevel,b.shopid shopid,b.sex sex,b.email email,"
				+" b.mobile mobile,b.address address,b.qq qq,b.idcard idcard,b.avatar avatar,b.nowcoin nowcoin,b.totalcoin total,"
				+" b.position position,b.experience experience,b.realname realname,s.shopName shopName,b.cityId cityId,b.provinceId provinceId,"
				+" b.cityGroup cityGroup,c.cityName cityName from SYKJ_USER_TUSER a INNER JOIN SYKJ_USER_USERINFORMATION  b on a.id=b.userId LEFT JOIN sykj_area_shop s"
				+" on b.shopId=s.id LEFT JOIN sykj_area_city c on b.cityId=c.id where  a.userType='"+id+"'";
		
		StringBuffer faSql = new StringBuffer("select");
		faSql.append(sql);
		if (userM != null) {// 添加查询条件
			if (userM.getUserName() != null && !userM.getUserName().trim().equals("")) {
				faSql.append(" and a.username like '%%")
						.append(userM.getUserName().trim()).append("%%' ");
			}
			if (userM.getShopId() != null && !userM.getShopId().trim().equals("")) {
				faSql.append(" and b.shopId like '%%")
						.append(userM.getShopId().trim()).append("%%' ");
			}
			if(userM.getPosition() !=null && !userM.getPosition().trim().equals("")){
				faSql.append(" and b.position like '%%")
		               .append(userM.getPosition().trim()).append("%%' ");
			}
			if (userM.getShopName() != null && !userM.getShopName().trim().equals("")) {
				faSql.append(" and s.shopName like '%%")
						.append(userM.getShopName().trim()).append("%%' ");
			}
			if (userM.getRealname()!= null && !userM.getRealname().trim().equals("")) {
				faSql.append(" and b.realname like '%%")
						.append(userM.getRealname().trim()).append("%%' ");
			}

		}

	
		List<Object> values = new ArrayList<Object>();
	
		j.setTotal((long) userInformationDao.findSQL(faSql.toString()).size());// 设置总记录数

		// System.out.println(dg.getSort());
		if (dg.getSort() != null) {// 设置排序
			faSql.append(" order by ").append(dg.getSort()).append(" ")
					.append(dg.getOrder());
		}
		List<Object> objList = userInformationDao.findbySql(faSql.toString(),
				dg.getPage(), dg.getRows(), values);// 查询分页
		List<UserM> users = new ArrayList<UserM>();
		if (objList.size() > 0 && objList != null) {
			for (Object o : objList) {
				UserM u = new UserM();
				Object[] obj = (Object[]) o;
				u.setId((String) obj[0]);
				u.setUserName((String) obj[1]);
				u.setUserPassword((String) obj[2]);
				u.setUserLevel((String) obj[3]);
				u.setShopId((String) obj[4]);
				u.setSex((String) obj[5]);
				u.setEmail((String) obj[6]);
				u.setMobile((String) obj[7]);
				u.setAddress((String) obj[8]);
				u.setQq((String) obj[9]);
				u.setIdCard((String) obj[10]);
				u.setAvatar((String) obj[11]);
				if(obj[12] !=null){
					u.setNowCoin(Long.parseLong(obj[12].toString()));
				}else{
					u.setNowCoin(0L);
				}
				if(obj[13] !=null){
					u.setTotalCoin(Long.parseLong(obj[13].toString()));
				}else{
					u.setTotalCoin(0L);
				}
				u.setPosition((String) obj[14]); 
				if(obj[15] !=null){
					u.setExperience(Integer.parseInt(obj[15].toString()));
				}else{
					u.setExperience(0);
				}
				u.setRealname((String) obj[16]); 
				u.setShopName((String) obj[17]);
				u.setCityId((String) obj[18]);
				u.setProvinceId((String) obj[19]);
				u.setCityGroup((String) obj[20]);
				u.setCityName((String) obj[21]);
				
				User user = userDao.getUser(u.getId());
				if(user != null){
					Set<UserRole> userRoleSet = user.getUserRoles();
					if (userRoleSet != null && userRoleSet.size() > 0) {
						boolean b = false;
						String roleId = "";
						String roleText = "";
						for (UserRole userRole : userRoleSet) {
							if (!b) {
								b = true;
							} else {
								roleId += ",";
								roleText += ",";
							}
							roleId += userRole.getRole().getId();
							roleText += userRole.getRole().getText();
						}
						u.setRoleId(roleId);
						u.setRoleText(roleText);
					}
				}
				users.add(u);
			}
		}
		j.setRows(users);// 设置返回的行
		
		return j;
	}

	//添加用户
	@Override
	public UserM addUsers(UserM userM) {
		User u=userDao.getUserByUsername(userM.getUserName());
		if(u!=null){
			return null;
		}else{
			User user = new User();
			UserInformation ufm = new UserInformation();
			userM.setId(UUID.randomUUID().toString());
			userM.setCreateDateTime(new Date());
			userM.setUserPassword(SecurityUtil.md5(userM.getUserPassword()));
			BeanUtils.copyProperties(userM,user);
			BeanUtils.copyProperties(userM,ufm);
			ufm.setId(UUID.randomUUID().toString());
			ufm.setUserId(userM.getId());
			ufm.setAddress(userM.getAddress());
			ufm.setAvatar(userM.getAvatar());
			ufm.setEmail(userM.getEmail());
			ufm.setExperience(0);
			ufm.setIdCard(userM.getIdCard());
			ufm.setMobile(userM.getMobile());
			ufm.setNowCoin(0L);
			ufm.setOldShopId(userM.getOldShopId());
			ufm.setOpenId(userM.getOpenId());
			ufm.setPosition(userM.getPosition());
			ufm.setQq(userM.getQq());
			ufm.setRealname(userM.getRealname());
			ufm.setSex(userM.getSex());
			ufm.setShopId(userM.getShopId());
			ufm.setTotalCoin(0L);
			ufm.setUserLevel("");
			ufm.setCityGroup(userM.getCityGroup());
			userDao.add(user);
			this.addUserRole(user);
			userInformationDao.add(ufm);
			return userM;
		}
	}

//	//店长审核会员，使其成为员工
//	@Override
//	public Integer edit(MemberToEmployees m, String id) {
//		Integer a=1;//成功
//		
//		User user=userDao.getUserByUsername(m.getMobile());
//		//查询未使用的最小二维码
//		Integer code=qrCodeDao.getByCode();
//		System.out.println(code);
//		QrCode qrCode=qrCodeDao.findCodeByNumber(code);
//		String address=qrCode.getCodeAddress();
//		if(address!=null){
//		//编辑二维码的状态
//		qrCode.setStatus(1);
//		qrCodeDao.update(qrCode);//更改二维码使用情况
//			
//			//添加
//			QrCodeUser c=new QrCodeUser();
//			c.setId(UUID.randomUUID().toString());
//			c.setCodeNumber(code);
//			c.setCreateDateTime(new Date());
//			c.setUserId(user.getId());
//			c.setStatus(0);
//			qrCodeUserDao.addQrCodeUser(c);
//			
//			
//			user.setUserType(id);
//			user.setCreateDateTime(new Date());
//			userDao.editUser(user);
//			UserInformation uf=userInformationDao.getUserInformationByUserId(user.getId());
//			uf.setShopId(m.getShopId());
//			uf.setMobile(m.getMobile());
//			uf.setRealname(m.getMemberName());
//			
//			uf.setCodeAddress(address);
//			uf.setQrcodeId(String.valueOf(code));
//			userInformationDao.editUserInformation(uf);
//			a=1;
//		}else{
//			a=0;
//		}
//		return a;
//	}

	@Override
	public User findByUserName(String name,String id) {
		User user=userDao.getUserByUsername(name,id);
		return user;
	}

	//根据用户名查询用户
	@Override
	public UserM findByName(String name) {
		User user=userDao.getUserByUsername(name);
		if(user==null){
			return null;
		}else{
			UserInformation usf=userInformationDao.fingByUserId(user.getId());
			Role role=roleDao.findByuserType(user.getUserType());
			UserM userM=new UserM();
			userM.setId(user.getId());
			userM.setAddress(usf.getAddress());
			userM.setAvatar(usf.getAvatar());
			userM.setEmail(usf.getEmail());
			userM.setIdCard(usf.getIdCard());
			userM.setMobile(usf.getMobile());
			userM.setOldShopId(usf.getOldShopId());
			userM.setOpenId(usf.getOpenId());
			userM.setPosition(usf.getPosition());
			userM.setQq(usf.getQq());
			userM.setSex(usf.getSex());
			userM.setShopId(usf.getShopId());
			userM.setRealname(usf.getRealname());
			userM.setNowCoin(usf.getNowCoin());
			userM.setRoleId(role.getId());
			userM.setRoleText(role.getText());
			BeanUtils.copyProperties(user,userM);
			return userM;
		}
	}
	
	@Override
	public User findByUserName(String name) {
		User user=userDao.getUserByUsername(name);
		return user;
	}

	//根据编号查询用户
	@Override
	public User getId(String id) {
		return userDao.getUser(id);
	}

	//根据门店和用户类型查询店长人数
	@Override
	public Integer getCount(String shopId) {
		
		return userDao.getCount(shopId);
	}

	@Override
	public Integer getCount(String shopId, String id) {
		
		return userDao.getCount(shopId,id);
	}

	@Override
	public List<UserM> findUserByShopId(String shopId) {
		List<UserInformation> list = userInformationDao.findAllEmployees(shopId);
		List<UserM> uList = new ArrayList<UserM>();
		if(list!=null && list.size()>0){
			for(UserInformation info : list){
				UserM m = new UserM();
				User u = userDao.getUser(info.getUserId());
				BeanUtils.copyProperties(u, m);
				m.setRealname(info.getRealname());
				m.setShopId(info.getShopId());
				uList.add(m);
			}
		}
		return uList;
	}
	
	@Override
	public List<UserM> findUserByShopId(String shopId,String userType) {
		List<UserInformation> list = userInformationDao.findAllEmployees(shopId,userType);
		List<UserM> uList = new ArrayList<UserM>();
		if(list!=null && list.size()>0){
			for(UserInformation info : list){
				UserM m = new UserM();
				User u = userDao.getUser(info.getUserId());
				BeanUtils.copyProperties(u, m);
				m.setRealname(info.getRealname());
				m.setShopId(info.getShopId());
				m.setEmployeeAccount(info.getEmployeeAccount());
				uList.add(m);
			}
		}
		return uList;
	}
	
	@Override
	public List<UserM> findBySubcenterId(String subcenterId) {
		List<Object> list = userInformationDao.findBySubcenterId(subcenterId);
		List<UserM> uList = new ArrayList<UserM>();
		if(list!=null && list.size()>0){
			for(Object object : list){
				UserM m = new UserM();
				Object[] obj = (Object[])object;
				User u = userDao.getUser(obj[0].toString());
				BeanUtils.copyProperties(u, m);
				m.setRealname(obj[1].toString());
				m.setShopId(obj[2].toString());
				m.setEmployeeAccount(obj[3].toString());
				uList.add(m);
			}
		}
		return uList;
	}
	

	@Override
	public List<UserM> findByAllEmployee() {
		List<Object> list = userInformationDao.findByAllEmployee();
		List<UserM> uList = new ArrayList<UserM>();
		if(list!=null && list.size()>0){
			for(Object object : list){
				UserM m = new UserM();
				Object[] obj = (Object[])object;
				User u = userDao.getUser(obj[0].toString());
				BeanUtils.copyProperties(u, m);
				m.setRealname(obj[1].toString());
				m.setShopId(obj[2].toString());
				m.setEmployeeAccount(obj[3].toString());
				uList.add(m);
			}
		}
		return uList;
	}

	@Override
	public UserM getUserById(String id) {
		User u = userDao.getUser(id);
		UserInformation info = userInformationDao.getUserInformationByUserId(id);
		UserM m = new UserM();
		BeanUtils.copyProperties(u, m);
		m.setRealname(info.getRealname());
		m.setMobile(info.getMobile());
		return m;
	}

	@Override
	public UserM editType(UserM userM, String id) {
		userM.setUserType(id);
		//userM.setEditDateTime(new Date());
		User user = userDao.getUser(userM.getId());
		if(userM.getUserName() != null && !userM.getUserName().equals("")){
			user.setUserName(userM.getUserName());
		}
		if(userM.getUserPassword() != null && !userM.getUserPassword().equals("")){
				user.setUserPassword(SecurityUtil.md5(userM.getUserPassword()));
		}
		if(userM.getUserType() != null && !userM.getUserType().equals("")){
			user.setUserType(userM.getUserType());
		}
		user.setEditDateTime(new Date());
		UserInformation usf=userInformationDao.fingByUserId(user.getId());
		usf.setUserId(user.getId());
		usf.setAddress(userM.getAddress());
		if(userM.getAddress()!=null && !userM.getAddress().equals("")){
			usf.setAvatar(userM.getAvatar());
		}
		usf.setEmail(userM.getEmail());
		usf.setIdCard(userM.getIdCard());
		usf.setMobile(userM.getMobile());
		usf.setOldShopId(userM.getOldShopId());
		if(userM.getOpenId()!=null&&!userM.getOpenId().equals(""))
		usf.setOpenId(userM.getOpenId());
		usf.setPosition(userM.getPosition());
		usf.setQq(userM.getQq());
		usf.setSex(userM.getSex());
		if(userM.getShopId()!=null && !userM.getShopId().equals("")){
			usf.setShopId(userM.getShopId());
		}
		usf.setRealname(userM.getRealname());
		usf.setQrcodeId(userM.getQrcodeId());
		usf.setCodeAddress(userM.getCodeAddress());
		if(userM.getCityId()!=null&&!userM.getCityId().equals("")){
			usf.setCityId(userM.getCityId());
		}
		if(userM.getProvinceId()!=null && !userM.getProvinceId().equals("")){
			usf.setProvinceId(userM.getProvinceId());
		}
		usf.setCityGroup(userM.getCityGroup());
		BeanUtils.copyProperties(user,userM);
		userInformationDao.editUserInformation(usf);
		userDao.editUser(user);
		return userM;
	}

	@Override
	public UserInformation findEmpByUserId(String employeesId) {
		UserInformation u = userInformationDao.getUserInformationByUserId(employeesId);
		return u;
	}

	@Override
	public User findUserByOpenId(String openId) {
		
		return userDao.findUserByOpenId(openId);
	}

	@Override
	public User loginOnLine(String name, String password) {
		User user = userDao.getUserByNamePassword(name, SecurityUtil.md5(password));
		if(user!=null){
			return user;
		}
		return null;
	}

	@Override
	public void addOpenIdByUserId(String userId,String openId) {
		UserInformation info = userInformationDao.getUserInformationByUserId(userId);
		info.setOpenId(openId);
		userInformationDao.editUserInformation(info);
	}

	@Override
	public List<UserInformation> findUserRSByCityName(String cityName) {
		City c = cityDao.findCityByName(cityName);
		//根据城市获取所有护理师,显示预约人气最高的前10条记录
		List<UserInformation> allEmp = userInformationDao.getAllEmpByCity(c.getId(),10);
		//System.out.println(allEmp.size());
		return allEmp;
	}

	@Override
	public List<UserInformation> findUserRSForCountry() {
		//10:前10条
		return userInformationDao.getAllEmpByCountry(10);
	}

	@Override
	public List<UserInformation> getRSEmp(String shopId, String openId) {
		List<UserInformation> listEmp = new ArrayList<UserInformation>();
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			List<UserInformation> listE = userInformationDao.getRSEmpList(shopId,info.getUserId());
			//System.out.println("大小："+listE.size());
			if(listE.size()>0){//有预约
				//获取预约的所有employeesIds
				String[] employeesIds = new String[listE.size()];
				for(int i=0;i<listE.size();i++){
					listEmp.add(listE.get(i));
					employeesIds[i] = listE.get(i).getUserId();
				}
				//获取排除预约的员工
				List<UserInformation> listEmpUser = userInformationDao.findEmpRemoveRS(shopId,employeesIds);
				for(UserInformation u : listEmpUser){
					listEmp.add(u);
				}
			}else{//获取该门店所有员工
				List<UserInformation> listEmpUser = userInformationDao.findEmpRemoveRS(shopId,null);
				for(UserInformation u : listEmpUser){
					listEmp.add(u);
				}
			}
		}else{
			List<UserInformation> listEmpUser = userInformationDao.findEmpRemoveRS(shopId,null);
			for(UserInformation u : listEmpUser){
				listEmp.add(u);
			}
		}
		return listEmp;
	}
	
	@Override
	public User findByMobile(String mobile) {
		
		return userDao.findByMobile(mobile);
	}


	@Override
	public List<UserInformation> getBGEmp(String shopId, String mobile) {
		List<UserInformation> listEmp = new ArrayList<UserInformation>();
		UserInformation info = userInformationDao.findByMobile(mobile);
		if(info != null){
			List<UserInformation> listE = userInformationDao.getRSEmpList(shopId,info.getUserId());
			//System.out.println("大小："+listE.size());
			if(listE.size()>0){//有预约
				//获取预约的所有employeesIds
				String[] employeesIds = new String[listE.size()];
				for(int i=0;i<listE.size();i++){
					listEmp.add(listE.get(i));
					employeesIds[i] = listE.get(i).getUserId();
				}
				//获取排除预约的员工
				List<UserInformation> listEmpUser = userInformationDao.findEmpRemoveRS(shopId,employeesIds);
				for(UserInformation u : listEmpUser){
					listEmp.add(u);
				}
			}else{//获取该门店所有员工
				List<UserInformation> listEmpUser = userInformationDao.findEmpRemoveRS(shopId,null);
				for(UserInformation u : listEmpUser){
					listEmp.add(u);
				}
			}
		}else{
			List<UserInformation> listEmpUser = userInformationDao.findEmpRemoveRS(shopId,null);
			for(UserInformation u : listEmpUser){
				listEmp.add(u);
			}
		}
		return listEmp;
	}
	
	@Override
	public EasyuiDataGridJson datagridShop(EasyuiDataGrid dg,UserM userM, String id,String type) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		if("owner".equals(type)) {
			type = "('4','10')";
		}else if("staff".equals(type)) {
			type = "('1','9')";
		}
		String condition_1 = " and b.shopId='"+id+"' ";
		String userType = userM.getUserType();
		if(userType.equals("11")) {
			condition_1 = " and b.shopId in (";
			//TODO
			int i = 0 ;
			List<UserSubCenter> userSubcenterList = userSubCenterDao.getByUserId(userM.getId());
			for(UserSubCenter userSubCenter : userSubcenterList) {
				List<Shop> shopList = shopDao.findShopBySubcenterId(userSubCenter.getSubcenterId());
				for(Shop shop : shopList) {
					condition_1 = condition_1 + "'" + shop.getId() + "',";
					i++;
				}
			}
			if(i > 0) {
				condition_1 = condition_1.substring(0,condition_1.length() - 1);
				condition_1 = condition_1 + ") ";
			}else {
				condition_1 = " and b.shopId = 'null' ";
			}
		}
		String sql = "  a.id id,a.username name,a.userpassword pass,b.userlevel userlevel,b.shopid shopid,b.sex sex,b.email email,"
				+" b.mobile mobile,b.address address,b.qq qq,b.idcard idcard,b.avatar avatar,b.nowcoin nowcoin,b.totalcoin total,"
				+" b.position position,b.experience experience,b.realname realname,s.shopName shopName"
				+" from SYKJ_USER_TUSER a INNER JOIN SYKJ_USER_USERINFORMATION  b on a.id=b.userId LEFT JOIN sykj_area_shop s"
				+" on b.shopId=s.id where a.userType in "+type+condition_1;
		if(userM != null){
			if(userM.getRealname() != null && !userM.getRealname().trim().equals("")){
				sql += " and b.realname like '%%"+userM.getRealname().trim()+"%%'";
			}
			if(userM.getUserName() != null && !userM.getUserName().trim().equals("")){
				sql += " and a.username like '%%"+userM.getUserName().trim()+"%%'";
			}
		}
		StringBuffer faSql = new StringBuffer("select");
		faSql.append(sql);
		List<Object> values = new ArrayList<Object>();
	
		j.setTotal((long) userInformationDao.findSQL(faSql.toString()).size());// 设置总记录数

		// System.out.println(dg.getSort());
		if (dg.getSort() != null) {// 设置排序
			faSql.append(" order by ").append(dg.getSort()).append(" ")
					.append(dg.getOrder());
		}
		List<Object> objList = userInformationDao.findbySql(faSql.toString(),
				dg.getPage(), dg.getRows(), values);// 查询分页
		List<UserM> users = new ArrayList<UserM>();
		if (objList.size() > 0 && objList != null) {
			for (Object o : objList) {
				UserM u = new UserM();
				Object[] obj = (Object[]) o;
				u.setId((String) obj[0]);
				u.setUserName((String) obj[1]);
				u.setUserPassword((String) obj[2]);
				u.setUserLevel((String) obj[3]);
				u.setShopId((String) obj[4]);
				u.setSex((String) obj[5]);
				u.setEmail((String) obj[6]);
				u.setMobile((String) obj[7]);
				u.setAddress((String) obj[8]);
				u.setQq((String) obj[9]);
				u.setIdCard((String) obj[10]);
				u.setAvatar((String) obj[11]);
				if(obj[12] !=null){
					u.setNowCoin(Long.parseLong(obj[12].toString()));
				}else{
					u.setNowCoin(0L);
				}
				if(obj[13] !=null){
					u.setTotalCoin(Long.parseLong(obj[13].toString()));
				}else{
					u.setTotalCoin(0L);
				}
				u.setPosition((String) obj[14]); 
				if(obj[15] !=null){
					u.setExperience(Integer.parseInt(obj[15].toString()));
				}else{
					u.setExperience(0);
				}
				u.setRealname((String) obj[16]); 
				u.setShopName((String) obj[17]);
				users.add(u);
			}
		}
		j.setRows(users);// 设置返回的行
		
		return j;
	}

	@Override
	public UserInformation findAdminByShopId(String shopId) {
		
		return userInformationDao.findAdminByShopId(shopId);
	}

	//查询所有拥有门店的用户
	@Override
	public List<UserInformation> findAll() {
		
		return userInformationDao.findAll();
	}

	//编辑用户
	@Override
	public void editUserInformation(UserInformation u) {
		userInformationDao.editUserInformation(u);
	}

	@Override
	public User finsByShopIdAndUserType(String shopId) {
		
		return userDao.findByShopIdAndUserType(shopId);
	}

	@Override
	public UserInformation findByShopOpenId(String openId) {
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info == null){
			return null;
		}
		UserInformation dzInfo = userInformationDao.findAdminByShopId(info.getShopId());
		return dzInfo;
	}

	@Override
	public UserInformation findByOpenId(String openId) {
		return userInformationDao.getByOpenId(openId);
	}

	//根据用户名，电话查询数据库中不是当前用户的信息
	@Override
	public User findByNameAndMobile(String name, String id, String mobile) {
		
		return userDao.findByNameAndIMobile(name, id, mobile);
	}

	@Override
	public Boolean judgeUser(String openId) {
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			Shop s = shopDao.getShop(info.getShopId());
			if(s != null){
				if(s.getShopName() != null && s.getShopName().equals("丝域养发馆总部")){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public EasyuiDataGridJson datagridsStaff(EasyuiDataGrid dg, UserM userM,
			String userType,UserM um) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		String sql = "  a.id id,a.username name,a.userpassword pass,b.userlevel userlevel,b.shopid shopid,b.sex sex,b.email email,"
				+" b.mobile mobile,b.address address,b.qq qq,b.idcard idcard,b.avatar avatar,b.nowcoin nowcoin,b.totalcoin total,"
				+" b.position position,b.experience experience,b.realname realname,s.shopName shopName,b.cityId cityId,b.provinceId provinceId,"
				+" b.cityGroup cityGroup,c.cityName cityName,b.employeeAccount from SYKJ_USER_TUSER a INNER JOIN SYKJ_USER_USERINFORMATION  b on a.id=b.userId LEFT JOIN sykj_area_shop s"
				//+" on b.shopId=s.id LEFT JOIN sykj_area_city c on b.cityId=c.id where  a.userType='"+userType+"' and b.shopId='"+userM.getShopId()+"'";
				+" on b.shopId=s.id LEFT JOIN sykj_area_city c on b.cityId=c.id where  a.userType='"+userType+"'";
		
		StringBuffer faSql = new StringBuffer("select");
		faSql.append(sql);
		if (userM != null) {// 添加查询条件
			if (userM.getUserName() != null && !userM.getUserName().trim().equals("")) {
				faSql.append(" and a.username like '%%")
						.append(userM.getUserName().trim()).append("%%' ");
			}
			if (userM.getShopId() != null && !userM.getShopId().trim().equals("")) {
				faSql.append(" and b.shopId like '%%")
						.append(userM.getShopId().trim()).append("%%' ");
			}
			if(userM.getPosition() !=null && !userM.getPosition().trim().equals("")){
				faSql.append(" and b.position like '%%")
		               .append(userM.getPosition().trim()).append("%%' ");
			}
			if (userM.getShopName() != null && !userM.getShopName().trim().equals("")) {
				faSql.append(" and s.shopName like '%%")
						.append(userM.getShopName().trim()).append("%%' ");
			}

		}
		if(um!=null&&um.getUserType().equals("1")||um.getUserType().equals("4")||um.getUserType().equals("9")
				||um.getUserType().equals("10")){
			faSql.append(" and b.shopId='"+um.getShopId()+"'");
		}
	
		List<Object> values = new ArrayList<Object>();
	
		j.setTotal((long) userInformationDao.findSQL(faSql.toString()).size());// 设置总记录数

		// System.out.println(dg.getSort());
		if (dg.getSort() != null) {// 设置排序
			faSql.append(" order by ").append(dg.getSort()).append(" ")
					.append(dg.getOrder());
		}
		List<Object> objList = userInformationDao.findbySql(faSql.toString(),
				dg.getPage(), dg.getRows(), values);// 查询分页
		List<UserM> users = new ArrayList<UserM>();
		if (objList.size() > 0 && objList != null) {
			for (Object o : objList) {
				UserM u = new UserM();
				Object[] obj = (Object[]) o;
				u.setId((String) obj[0]);
				u.setUserName((String) obj[1]);
				u.setUserPassword((String) obj[2]);
				u.setUserLevel((String) obj[3]);
				u.setShopId((String) obj[4]);
				u.setSex((String) obj[5]);
				u.setEmail((String) obj[6]);
				u.setMobile((String) obj[7]);
				u.setAddress((String) obj[8]);
				u.setQq((String) obj[9]);
				u.setIdCard((String) obj[10]);
				u.setAvatar((String) obj[11]);
				if(obj[12] !=null){
					u.setNowCoin(Long.parseLong(obj[12].toString()));
				}else{
					u.setNowCoin(0L);
				}
				if(obj[13] !=null){
					u.setTotalCoin(Long.parseLong(obj[13].toString()));
				}else{
					u.setTotalCoin(0L);
				}
				u.setPosition((String) obj[14]); 
				if(obj[15] !=null){
					u.setExperience(Integer.parseInt(obj[15].toString()));
				}else{
					u.setExperience(0);
				}
				u.setRealname((String) obj[16]); 
				u.setShopName((String) obj[17]);
				u.setCityId((String) obj[18]);
				u.setProvinceId((String) obj[19]);
				u.setCityGroup((String) obj[20]);
				u.setCityName((String) obj[21]);
				u.setEmployeeAccount((String) obj[22]);
				users.add(u);
			}
		}
		if(um!=null&&(um.getUserType().equals("1")||um.getUserType().equals("9"))){
			users.clear();
		}
		j.setRows(users);// 设置返回的行
		return j;
	}





	@Override
	public EasyuiDataGridJson subcenterUserDatagrid(SystemContext syct,UserM userM,String userType) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		Pager<User> uPager = userDao.findSubcenterUser(syct, userM,userType);
		List<User> uList = uPager.getDatas();
		List<UserM> userMList = new ArrayList<UserM>();
		for(User user : uList){
			UserM um = new UserM();
			um.setId(user.getId());
			um.setUserName(user.getUserName());
			um.setUserPassword(user.getUserPassword());
			UserInformation info = userInformationDao.fingByUserId(user.getId());
			if(info != null){
				um.setUserLevel(info.getUserLevel());
				um.setShopId(info.getShopId());
				um.setSex(info.getSex());
				um.setEmail(info.getEmail());
				um.setMobile(info.getMobile());
				um.setAddress(info.getAddress());
				um.setQq(info.getQq());
				um.setIdCard(info.getIdCard());
				um.setAvatar(info.getAvatar());
				um.setNowCoin(info.getNowCoin());
				um.setTotalCoin(info.getTotalCoin());
				um.setExperience(info.getExperience());
				um.setRealname(info.getRealname());
				if(info.getShopId() != null && !info.getShopId().equals("")){
					Shop s = shopDao.getShop(info.getShopId());
					if(s != null){
						um.setShopName(s.getShopName());
					}
				}
//				if(info.getSubcenterAccount() != null && !info.getSubcenterAccount().equals("") && user.getUserType().equals("11")) {
				if(user.getUserType().equals("11")) {
					List<UserSubCenter> usubList = userSubCenterDao.getByUserId(user.getId());
					String sub = "";
					for(UserSubCenter userSubCenter : usubList) {
						Subcenter subcenter = subcenterDao.getById(userSubCenter.getSubcenterId());
						if(subcenter != null) {
							sub = sub + subcenter.getSubcenterName() + ",";
						}
					}
					if(sub.length() >= 1) {
						sub = sub.substring(0,sub.length() - 1);
					}
					um.setSubcenter(sub);
				}else if(user.getUserType().equals("13")) {
					List<Franchisee> fList = franchiseeDao.findByUserId(user.getId());
					String sub = "";
					for(Franchisee franchisee : fList) {
						Shop shop = shopDao.getShop(franchisee.getShopId());
						if(shop != null) {
							sub = sub + shop.getShopName() + ",";
						}
					}
					if(sub.length() >= 1) {
						sub = sub.substring(0,sub.length() - 1);
					}
					um.setSubcenter(sub);
				}
			}
			userMList.add(um);
		}
		j.setRows(userMList);
		j.setTotal(uPager.getTotalCount());
		return j;
	}

	@Override
	public int findUserByMobile(String shopId, String mobile) {
		// TODO Auto-generated method stub
		return 0;
	}

}
