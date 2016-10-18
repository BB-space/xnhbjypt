package com.sykj.app.dao.user;

import java.util.List;










import org.hibernate.Query;

import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.common.dao.IBaseDao;

public interface UserInformationDao extends IBaseDao<UserInformation>{

	/**
	 * 查找用户
	 */
	public UserInformation getUserInformation(String id);
	
	/**
	 * 根据门店ID查找所有该店会员
	 */
	public List<UserInformation> findAllMember(String shopId);
	/**
	 * 根据门店ID查找所有该店员工
	 */
	public List<UserInformation> findAllEmployees(String shopId);
	/**
	 * 根据门店ID查找所有该店人员
	 */
	public List<UserInformation> findAllEmployees(String shopId,String userType);
	/**
	 * 根据分中心查找员工
	 * @param subcenterId
	 * @return
	 */
	public List<Object> findBySubcenterId(String subcenterId);
	
	/**
	 * 查找所有店员
	 * @return
	 */
	public List<Object> findByAllEmployee();
	
	/**
	 * 根据用户IDS和门店ID查找早班排班用户集合
	 */
	public List<UserInformation> findUserEarlyById(String ids,String shopId);
	
	/**
	 * 根据用户IDS和门店ID查找晚班排班用户集合
	 */
	public List<UserInformation> findUserNightById(String ids,String shopId);

	/**
	 * 根据用户ID查找用户
	 */
	public UserInformation getUserInformationByUserId(String userId);
	
	/**
	 * 根据门店ID查找用户
	 */
	public List<UserInformation> getUserInformationByShopId(String shopId);
	
	/**
	 * 根据门店ID查找用户
	 */
	public List<UserInformation> getUserInformationByShopId(String shopId,String userType);
	
	/**
	 * 删除用户
	 */
	public void deleteUserInformation(String id);
	
	/**
	 * 修改用户
	 */
	public void editUserInformation(UserInformation userInformation);
	
	/**
	 * 获得所有用户（分页）
	 */
	public Pager<UserInformation> findUserInformation(SystemContext syct, UserM userM);
	
	/**
	 * 获得所有用户总记录数
	 */
	public Long countUserInformation();
	
	/**
	 * 执行SQL返回数组对象集合
	 */
	public List<Object> findSQL(String sql);
	
	/**
	 * 执行SQL返回数组对象分页集合
	 */
	public List<Object> findbySql(String sql, int page, int rows, List<Object> param);
	
	/**
	 * 根据用户编号查询信息
	 * @param id
	 * @return
	 */
	public UserInformation fingByUserId(String id);
	
	/**
	 * 根据openID查询用户
	 * @param openId
	 * @return
	 */
	public UserInformation getByOpenId(String openId);
	
	/**
	 * 根据cityId获取所有护理师
	 * number:前10条记录
	 */
	public List<UserInformation> getAllEmpByCity(String cityId, int number);
	
	/**
	 * 根据userID删除
	 * @param userId
	 */
	public void deleteUserInfo(String userId);

	public List<UserInformation> getAllEmpByCountry(int num);
	
	/**
	 * 根据shopId查找员工数
	 */
	public Integer findEmpByShopId(String shopId);
	
	/**
	 * 根据shopId查找该店员工，按用户预约员工次数排序
	 */
	public List<UserInformation> getRSEmpList(String shopId, String userId);
	/**
	 * 获取排除有预约的护理师列表
	 */
	public List<UserInformation> findEmpRemoveRS(String shopId, String[] employeesIds);
	
	/**
	 * 根据电话号码查询此信息
	 * @param mobile
	 * @return
	 */
	public UserInformation findByMobile(String mobile);
	
	/**
	 * 查找app会员
	 */
	public List<Object> getMember(String mobile, String realname, int from, int size);
	/**
	 * 查找app会员总数
	 */
	public int getMemberCount(String mobile, String realname);
	
	/**
	 * 查找Erp会员
	 */
	public List<Object> getMemberFromErp(String mobile, String realname, int from, int to);
	
	/**
	 * 查找Erp会员总数
	 */
	public int getMemberFromErpCount(String mobile, String realname);
	
	/**
	 * 根据门店id获取门店店员包括店长
	 * @param shopId
	 * @return
	 */
	public List<UserInformation> getAllEmps(String shopId);
	
	/**
	 * 按门店获得所有用户（分页）
	 */
	public Pager<UserInformation> findUserByShop(SystemContext syct, UserM userM,String shopId);

	/**
	 * 获取绑定的用户
	 */
	public List<UserInformation> getBoundMember();

	/**
	 * 根据shopId查找店长
	 */
	public UserInformation findAdminByShopId(String shopId);
	
	/**
	 * 根据手机号查找
	 * @param mobileNo
	 * @return
	 */
	public UserInformation getUserInformationByMobileNo(String mobileNo);
	
	/**
	 * 查询所有拥有门店的用户
	 * zq
	 * @return
	 */
	public List<UserInformation> findAll();

	public List<Object> getAllUser();
	
	public List<UserInformation> getUserInformationByShopIdAndAccount(String shopId);
	
	public UserInformation findByEmployeeAccount(String employeeAccount);
}
