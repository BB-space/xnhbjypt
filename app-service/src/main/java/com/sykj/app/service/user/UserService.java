package com.sykj.app.service.user;



import java.util.List;


import com.sykj.app.entity.user.MemberToEmployees;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;


/**
 * 后台用户管理
 * @author swh
 *
 */
public interface UserService {

	/**
	 * 添加用户
	 * @param userM
	 */
	public UserM addUser(UserM userM);
	
	/**
	 * 删除用户
	 * @param userM
	 */
	public void deleteUser(String ids);
	
	/**
	 * 编辑用户
	 */
	public UserM editUser(UserM userM);
	
	/**
	 * 查询用户列表
	 * @param dg
	 * @param user
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, UserM userM);
	
	
	/**
	 * 批量修改用户角色
	 * @param userIds
	 * @param roleId
	 */
	public void editUsersRole(String userIds, String roleId);
	
	/**
	 * 根据用户名和密码查询用户
	 * @param name
	 * @param password
	 * @return
	 */
	public UserM login(String name,String password);
	
	/**
	 * 根据用户名和密码查询用户
	 * @param name
	 * @param password
	 * @return
	 */
	public UserM findByNamePwd(String name,String password);
	
	/**
	 * 根据用户名和密码查询用户(在线客服登录)
	 */
	public User loginOnLine(String name,String password);
	
	/**
	 * 查询用户列表
	 * @param dg
	 * @param user
	 * @return
	 */
	public EasyuiDataGridJson datagrids(EasyuiDataGrid dg, UserM userM,String id);
	
	public EasyuiDataGridJson datagridsStaff(EasyuiDataGrid dg, UserM userM,String userType,UserM um);
	
	/**
	 * 添加
	 * @param userM
	 */
	public UserM addUsers(UserM userM);
	
//	/**
//	 *店长审核会员，使其成为员工
//	 */
//	public Integer edit(MemberToEmployees m, String id);
	
	/**
	 * 根据用户名查询用户信息
	 * @param name
	 * @return
	 */
	public User findByUserName(String name,String id);
	
	/**
	 * 根据用户名查询用户
	 * @param name
	 * @return
	 */
	public UserM findByName(String name);
	
	/**
	 * 根据用户名查询用户
	 * @param name
	 * @return
	 */
	public User findByUserName(String name);
	
	/**
	 * 根据编号查询用户
	 * @param id
	 * @return
	 */
	public User getId(String id);
	
	/**
	 * 根据门店和用户类型查询店长人数
	 * @param shopId
	 * @return
	 */
	public Integer getCount(String shopId);
	
	/**
	 * 根据门店,编号，用户类型查询店长人数
	 * @param shopId
	 * @return
	 */
	public Integer getCount(String shopId,String id);
	/**
	 * 根据门店编号查询员工
	 */
	public List<UserM> findUserByShopId(String shopId);
	/**
	 * 根据门店编号查询员工
	 */
	public List<UserM> findUserByShopId(String shopId,String userType);
	
	/**
	 * 根据分中心查找员工
	 * @param subcenterId
	 * @return
	 */
	public List<UserM> findBySubcenterId(String subcenterId);
	
	/**
	 * 查找所有店员
	 * @return
	 */
	public List<UserM> findByAllEmployee();
	
	/**
	 * 根据id查找员工用户
	 */
	public UserM getUserById(String id);
	
	public UserM editType(UserM userM, String id);
	
	/**
	 * 根据userId查找用户
	 */
	public UserInformation findEmpByUserId(String employeesId);
	
	/**
	 * 根据openId获取用户类型
	 */
	public User findUserByOpenId(String openId);
	
	/**
	 * 绑定openId
	 */
	public void addOpenIdByUserId(String userId, String openId);
	
	/**
	 * 查找预约人气最旺的前10条护理师
	 */
	//根据城市
	public List<UserInformation> findUserRSByCityName(String cityName);
	//全国
	public List<UserInformation> findUserRSForCountry();
	
	/**
	 * 根据shopId获取所有护理师,优先排列有预约过的
	 */
	public List<UserInformation> getRSEmp(String shopId, String openId);
	
	/**
	 * 根据电话号码获取用户类型
	 * @param mobile
	 * @return
	 */
	public User findByMobile(String mobile);
	
	/**
	 * 判断手机号是否存在
	 */
	public int findUserByMobile(String shopId, String mobile);
	
	/**
	 * 根据mobile获取所有护理师,优先排列有预约过的
	 */
	public List<UserInformation> getBGEmp(String shopId, String mobile);
	
	public EasyuiDataGridJson datagridShop(EasyuiDataGrid dg,UserM userM, String id,String type);
	
	/**
	 * 根据shopId查找店长
	 */
	public UserInformation findAdminByShopId(String shopId);
	
	/**
	 * 查询所有拥有门店的用户（zq）
	 * @return
	 */
	public List<UserInformation> findAll();
	
	/**
	 * 编辑用户（zq）
	 * @param u
	 */
	public void editUserInformation(UserInformation u);
	
	/**
	 * 根据门店店长身份
	 * @param shop
	 * @return
	 */
	public User finsByShopIdAndUserType(String shopId);
	
	/**
	 * 获取门店店长
	 */
	public UserInformation findByShopOpenId(String openId);
	
	public UserInformation findByOpenId(String openId);
	
	/**
	 * 根据用户名，电话查询数据库中不是当前用户的信息
	 * zq
	 * @param name
	 * @param id
	 * @param mobile
	 * @return
	 */
	public User findByNameAndMobile(String name,String id,String mobile);
	public Boolean judgeUser(String openId);
	



	/**
	 * 分中心用户列表
	 */
	public EasyuiDataGridJson subcenterUserDatagrid(SystemContext syct, UserM userM,String userType);
}
