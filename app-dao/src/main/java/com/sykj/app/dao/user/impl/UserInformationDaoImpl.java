package com.sykj.app.dao.user.impl;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.common.dao.BaseDao;

@Repository("userInformationDao")
public class UserInformationDaoImpl extends BaseDao<UserInformation> implements UserInformationDao{

	@Override
	public UserInformation getUserInformation(String id) {
		return this.get(UserInformation.class, id);
	}

	@Override
	public void deleteUserInformation(String id) {
		this.delete(this.getUserInformation(id));
		
	}

	@Override
	public void editUserInformation(UserInformation userInformation) {
		this.update(userInformation);
		
	}

	@Override
	public Pager<UserInformation> findUserInformation(SystemContext syct,
			UserM userM) {
		StringBuffer hql = new StringBuffer("from UserInformation t where 1=1");
		return this.find(hql.toString(),syct);
	}

	@Override
	public Long countUserInformation() {

		return this.count("select count(*) from UserInformation t where 1=1", null);
	}

	@Override
	public UserInformation getUserInformationByUserId(String userId) {
		
		return this.get("from UserInformation t where t.userId='"+userId+"'");
	}

	@Override
	public List<UserInformation> getUserInformationByShopId(String shopId) {
		
		return this.list("from UserInformation t where t.shopId='"+shopId+"'");
	}
	
	@Override
	public List<UserInformation> getUserInformationByShopId(String shopId,String userType) {
		
		if(userType.equals("1") || userType.equals("9")) {
			return this.list("from UserInformation where shopId='"+shopId+"' and userId in(select id from User where userType in ('1','9'))");
		}else if(userType.equals("4") || userType.equals("10")) {
			return this.list("from UserInformation where shopId='"+shopId+"' and userId in(select id from User where userType in ('4','10'))");
		}else {
			return this.list("from UserInformation where shopId='"+shopId+"' ");
		}
		
	}

	@Override
	public List<UserInformation> findUserEarlyById(String ids, String shopId) {
		StringBuffer sbf = new StringBuffer("from UserInformation t where 1=1");
		sbf.append(" and t.shopId='").append(shopId).append("'").append(" and t.userId in (");
		String[] userIds = ids.split(",");
		for(int i =0;i<userIds.length;i++){
			String id=userIds[i];
			if(i<userIds.length-1){
				sbf.append("'").append(id).append("'").append(",");
			}else{
				sbf.append("'").append(id).append("'");
			}
		}
		sbf.append(")");
		return this.list(sbf.toString());
	}

	@Override
	public List<UserInformation> findUserNightById(String ids, String shopId) {
		StringBuffer sbf = new StringBuffer("from UserInformation t where 1=1");
		sbf.append(" and t.shopId='").append(shopId).append("'").append(" and t.userId not in (");
		String[] userIds = ids.split(",");
		for(int i =0;i<userIds.length;i++){
			String id=userIds[i];
			if(i<userIds.length-1){
			sbf.append("'").append(id).append("'").append(",");
			}else{
				sbf.append("'").append(id).append("'");
			}
		}
		sbf.append(")");
		return this.list(sbf.toString());
	}

	@Override
	public List<UserInformation> findAllMember(String shopId) {
		String hql = "select b from User a,UserInformation b where a.id=b.userId and a.userType='2' and b.shopId='"+shopId+"'";
		return this.list(hql);
	}

	@Override
	public List<UserInformation> findAllEmployees(String shopId) {
		String hql = "select b from User a,UserInformation b where a.id=b.userId and a.userType='1' and b.shopId='"+shopId+"'";
		return this.list(hql);
	}
	
	@Override
	public List<UserInformation> findAllEmployees(String shopId,String userType) {
		String hql = "select b from User a,UserInformation b where a.id=b.userId and a.userType='"+userType+"' and b.shopId='"+shopId+"'";
		return this.list(hql);
	}

	@Override
	public List<Object> findBySubcenterId(String subcenterId) {
		String sql = "select t.userId,t.realname,t.shopid,t.employeeAccount from sykj_user_userinformation t, sykj_area_shop t2, "
				+ "sykj_area_city t3,sykj_area_subcenter t4,sykj_user_tuser t5 "
				+ "where t4.id = '"+subcenterId+"' and t5.userType in ('1','9') "
				+ "and t.shopid = t2.id and t2.cityid = t3.id and t2.subcenterId = t4.ID and t.userid = t5.id";
		return this.findSQL(sql);
	}
	
	@Override
	public List<Object> findByAllEmployee() {
		String sql = "select t.userId,t.realname,t.shopid,t.employeeAccount from sykj_user_userinformation t, sykj_area_shop t2, "
				+ "sykj_area_city t3,sykj_area_subcenter t4,sykj_user_tuser t5 "
				+ "where t5.userType in ('1','9') and t.employeeAccount is not null "
				+ "and t.shopid = t2.id and t2.cityid = t3.id and t2.subcenterId = t4.ID and t.userid = t5.id";
		return this.findSQL(sql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> findSQL(String sql){
		Query q = this.getSession().createSQLQuery(sql);
		return q.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> findbySql(String sql, int page, int rows, List<Object> param){
		 SQLQuery q = this.getSession().createSQLQuery(sql);
			if (param != null && param.size() > 0) {
				for (int i = 0; i < param.size(); i++) {
					q.setParameter(i, param.get(i));
				}
			}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}

	@Override
	public UserInformation fingByUserId(String id) {
		String hql="from UserInformation u where u.userId='"+id+"'";
		Query query=getSession().createQuery(hql);
		UserInformation u=(UserInformation) query.uniqueResult();
		return u;
	}

	@Override
	public UserInformation getByOpenId(String openId) {
		String hql="from UserInformation u where u.openId='"+openId+"'";
		return this.get(hql);
	}

	@Override
	public List<UserInformation> getAllEmpByCity(String cityId, int number) {
		//获取该城市的所有护理师
		StringBuffer sbf = new StringBuffer("select * from sykj_user_userinformation u ");
		sbf.append("where u.shopid in ( ");
		sbf.append("select s.id from sykj_area_shop s where s.cityid='").append(cityId).append("' ");
		sbf.append(") and u.userid in ( ");
		sbf.append("select t.id from sykj_user_tuser t where t.usertype='1' ) ");
		//预约数排序前10条
		sbf.append("and u.userid in  ( ");
		sbf.append("select employeesid from ( ");
		sbf.append("select u.employeesid,count(u.employeesid) num from sykj_user_UserReservation u group by u.employeesid  order by num desc ");
		sbf.append(") where rownum<=").append(number).append(") ");
		
		String sql = sbf.toString();
		return this.listBySql(sql, UserInformation.class, true);
	}

	@Override
	public List<UserInformation> getAllEmpByCountry(int num) {
		//获取所有护理师
		StringBuffer sbf = new StringBuffer("select * from sykj_user_userinformation u ");
		sbf.append("where u.userid in ( ");
		sbf.append("select t.id from sykj_user_tuser t where t.usertype='1' ) ");
		//预约数排序前10条
		sbf.append("and u.userid in ( ");
		sbf.append("select employeesid from ( ");
		sbf.append("select u.employeesid,count(u.employeesid) num from sykj_user_UserReservation u group by u.employeesid  order by num desc ");
		sbf.append(") where rownum<=").append(num).append(") ");
		
		String sql = sbf.toString();
		return this.listBySql(sql, UserInformation.class, true);
	}

	@Override
	public void deleteUserInfo(String userId) {
		String hql="delete from SYKJ_USER_USERINFORMATION u where u.userId='"+userId+"'";
		SQLQuery query=getSession().createSQLQuery(hql).addEntity(UserInformation.class);
		query.executeUpdate();
	}

	@Override
	public Integer findEmpByShopId(String shopId) {
		String hql = "from UserInformation u where u.shopId='"+shopId+"'";
		return this.list(hql).size();
	}

	@Override
	public List<UserInformation> getRSEmpList(String shopId, String userId) {
		StringBuffer sbf = new StringBuffer("select * from sykj_user_userinformation u ");
		sbf.append("where u.userid in ( ");
		sbf.append("select a.employeesid from ( ")
		       .append("select u.employeesid,count(u.employeesid) num from sykj_user_userreservation u ")
		       .append("where u.userid='").append(userId).append("' and u.shopid='")
		       .append(shopId).append("' group by u.employeesid order by num desc) a ");
		sbf.append(") and u.shopid='").append(shopId).append("'");
		
		String sql = sbf.toString();
		return this.listBySql(sql, UserInformation.class, true);

	}

	@Override
	public List<UserInformation> findEmpRemoveRS(String shopId,String[] employeesIds) {
		StringBuffer sbf = new StringBuffer("select * from sykj_user_userinformation u ");
		sbf.append("where u.shopId='").append(shopId).append("' ");
		sbf.append("and u.userid = (select t.id from sykj_user_tuser t where t.usertype='1' and t.id=u.userid)");
		if(employeesIds != null){
			sbf.append("and u.userId not in(");
			for(int i=0;i<employeesIds.length;i++){
				if(i<employeesIds.length-1){
					sbf.append("'").append(employeesIds[i]).append("'").append(",");
				}else{
					sbf.append("'").append(employeesIds[i]).append("'");
				}
			}
			sbf.append(" ) ");
		}
		
		String sql = sbf.toString();
		return this.listBySql(sql, UserInformation.class, true);
	}

	//根据电话号码查询此信息
	@Override
	public UserInformation findByMobile(String mobile) {
		String hql="from UserInformation t where t.mobile='"+mobile+"'";
		return this.get(hql);
	}

	@Override
	public List<Object> getMember(String mobile, String realname, int from, int size) {
		
		StringBuffer sbf = new StringBuffer("select t.ID, t.mobile, t.realname"
				+ " from sykj_user_UserInformation t, sykj_user_tuser t2 "
				+ " where t.userid=t2.id and t2.usertype in ('1','2','4') and t.openId is not null and t.openId != '' ");
				
		if(mobile != null && mobile != ""){
			sbf.append(" and t.mobile like '%"+mobile+"%'");
		}
		if(realname != null && realname != ""){
			sbf.append(" and t.realname like '%"+realname+"%'");
		}
		
		sbf.append(" limit " + from + ", " + size);
		
		return this.findSQL(sbf.toString());
		
	}
	
	@Override
	public int getMemberCount(String mobile, String realname) {
		StringBuffer sbf = new StringBuffer("select count(*) from sykj_user_UserInformation t, sykj_user_tuser t2 "
				+ " where t.userid=t2.id and t2.usertype in ('1','2','4') and t.openId is not null and t.openId != '' ");
				
		if(mobile != null && mobile != ""){
			sbf.append(" and t.mobile like '%"+mobile+"%'");
		}
		if(realname != null && realname != ""){
			sbf.append(" and t.realname like '%"+realname+"%'");
		}
		List<Object> list = this.findSQL(sbf.toString());
		return ((BigInteger) list.get(0)).intValue();
	}

	@Override
	public List<Object> getMemberFromErp(String mobile, String realname, int from, int to) {
		StringBuffer sbf = new StringBuffer("select * from ( select *, ROW_NUMBER() OVER(Order by t.fldCompanyName1) AS RowNumber"
				+ " from  ( SELECT cast(a.fldCompanyCode as varchar) fldCompanyCode, cast(a.fldMemberNo as varchar) fldMemberNo,"
				+ "	cast(a.fldMobileNo as varchar) fldMobileNo, cast(c.fldCompanyName1 as varchar) fldCompanyName1,"
				+ "	cast(a.fldName1 as varchar) fldName1 FROM tblMember a INNER JOIN tblCompany c"
				+ "	ON c.fldCompanyCode = a.fldCompanyCode 	where a.fldMobileNo != '' and a.fldName1 != ''");
		
		if(mobile != null && mobile != ""){
			sbf.append(" and a.fldMobileNo like '%"+mobile+"%'");
		}
		if(realname != null && realname != ""){
			sbf.append(" and a.fldName1 like '%"+realname+"%'");
		}
		sbf.append(")  as t ) as b where RowNumber BETWEEN "+ from +" and "+ to);
		
		return this.findSQL(sbf.toString());
	}

	@Override
	public int getMemberFromErpCount(String mobile, String realname) {
		StringBuffer sbf = new StringBuffer("SELECT COUNT(*) FROM tblMember a INNER JOIN tblCompany c ON"
				+ " c.fldCompanyCode = a.fldCompanyCode where a.fldMobileNo != ''");
		if(mobile != null && mobile != ""){
			sbf.append(" and a.fldMobileNo like '%"+mobile+"%'");
		}
		if(realname != null && realname != ""){
			sbf.append(" and a.fldName1 like '%"+realname+"%'");
		}
		List<Object> list = this.findSQL(sbf.toString());
		return (int) list.get(0);
	}

	@Override
	public List<UserInformation> getAllEmps(String shopId) {
		String hql = "select b from User a,UserInformation b where a.id=b.userId and (a.userType='1' or a.userType='4') and b.shopId='"+shopId+"'";
		return this.list(hql);
	}

	@Override
	public Pager<UserInformation> findUserByShop(SystemContext syct, UserM userM,String shopId) {
		StringBuffer hql = new StringBuffer("from UserInformation t where t.shopId='"+shopId+"'");
		return this.find(hql.toString(),syct);
	}

	@Override
	public List<UserInformation> getBoundMember() {
		String hql = " from UserInformation t where t.status in ('0','1') and t.openId is not null and "
				+ " t.openId != '' and t.mobile is not null and t.mobile != '' ";
		return this.list(hql);
	}

	@Override
	public UserInformation findAdminByShopId(String shopId) {
		String hql = "from UserInformation where shopId='"+shopId+"' and userId in(select id from User where userType='4')";
		return this.get(hql);
	}

	@Override
	public UserInformation getUserInformationByMobileNo(String mobileNo) {
		String hql = "from UserInformation where mobile='"+mobileNo+"'";
		return this.get(hql);
	}

	//查询所有拥有门店的用户信息
	@Override
	public List<UserInformation> findAll() {
		String hql="from UserInformation t where t.shopId!=''";
		return this.list(hql);
	}

	@Override
	public List<Object> getAllUser() {
		String sql="SELECT mobile from sykj_user_userinformation where openId in (SELECT openId from sykj_savings_usercarditem WHERE ITEMID='f9aed2e7-9f1e-4dd4-85a2-123456790' and `STATUS`=0) ";
		return this.findSQL(sql);
	}

	@Override
	public List<UserInformation> getUserInformationByShopIdAndAccount(
			String shopId) {
		
		return this.list("select t from UserInformation t,User t2 where t.userId=t2.id and t2.userType in ('1','9') and t.shopId='"+shopId+"' and t.employeeAccount is not null");
	}

	@Override
	public UserInformation findByEmployeeAccount(String employeeAccount) {
		String hql = "from UserInformation where employeeAccount='"+employeeAccount+"'";
		return this.get(hql);
	}
	
}
