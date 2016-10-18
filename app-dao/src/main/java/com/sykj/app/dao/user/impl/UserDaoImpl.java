package com.sykj.app.dao.user.impl;



import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.UserDao;
import com.sykj.app.entity.user.User;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.common.dao.BaseDao;

@Repository("userDao")
public class UserDaoImpl extends BaseDao<User> implements UserDao{

	@Override
	public void addUser(User user) {
		this.add(user);
		
	}

	@Override
	public void deleteUser(String id) {
		this.delete(this.getUser(id));
		
	}

	@Override
	public void editUser(User user) {
		this.update(user);
		
	}

	@Override
	public Pager<User> findUser(SystemContext syct, UserM userM) {
		StringBuffer hql = new StringBuffer("from User t where 1=1");
//		List<Object> args = new ArrayList<Object>();
		if(userM !=null){// 添加查询条件
			if (userM.getUserName() != null && !userM.getUserName().trim().equals("")) {
				hql.append(" and t.userName like '%%").append(userM.getUserName().trim()).append("%%' ");
			}
		}
		hql.append(" order by t.createDateTime desc");
		return this.find(hql.toString(),syct);
	}

	@Override
	public User getUser(String id) {
		return this.get(User.class, id);
	}

	@Override
	public Long countUser() {
		
		return this.count("select count(*) from User t where 1=1", null);
	}

	@Override
	public User getUserByNamePassword(String username, String password) {
		
		return this.get("from User t where t.userName='"+username+"' and t.userPassword='"+password+"'");
	}

	@Override
	public User getUserByUsername(String username) {
		
		return this.get("from User t where t.userName='"+username+"'");
	}
	
	@Override
	public User getUserByUsername(String username,String id) {
		
		return this.get("from User t where t.userName='"+username+"' and t.userType='"+id+"'");
	}

	//记录店长人数
	@Override
	public Integer getCount(String shopId) {
		String hql="from  User t,UserInformation i"
				+" where t.id=i.userId and t.userType='4' and i.shopId='"+shopId+"'";
		return this.list(hql).size();
	}

	//记录不是当前用户店长人数
	@Override
	public Integer getCount(String shopId,String id) {
		String hql="from  User t,UserInformation i"
				+" where t.id=i.userId and t.userType='4' and i.shopId='"+shopId+"' and t.id!='"+id+"'";
		return this.list(hql).size();
	}

	@Override
	public User findUserByOpenId(String openId) {
		String hql = "select u from User u, UserInformation info where u.id=info.userId and info.openId='"+openId+"'";
		return this.get(hql);
	}

	//根据电话查询用户类型
	@Override
	public User findByMobile(String mobile) {
		String hql = "select u from User u, UserInformation info where u.id=info.userId and info.mobile='"+mobile+"'";
		return this.get(hql);
	}

	//根据用户类型查询用户信息
	@Override
	public List<Object> findByUserType(String id) {
		String sql="select a.id id,a.username name,b.openId openId,b.realname realname"
				+" from SYKJ_USER_TUSER a INNER JOIN SYKJ_USER_USERINFORMATION  b on a.id=b.userId LEFT JOIN sykj_area_shop s"
				+" on b.shopId=s.id where  a.userType='"+id+"'";
		return this.findSQL(sql);
	}

	@Override
	public User findByShopIdAndUserType(String shopId) {
		String hql="from User t where t.userType='4' and t.id in (select userId from UserInformation where shopId='"+shopId+"')";
		return this.get(hql);
	}

	//根据用户名，电话查询数据库中不是当前用户的信息
	@Override
	public User findByNameAndIMobile(String name, String id,String mobile) {
		StringBuffer hql=new StringBuffer("from  User t where t.id!='"+id+"'");
		if(name!=null && !name.equals("")){
			hql.append(" and t.userName='"+name+"'");
		}
		if(mobile !=null && !mobile.equals("")){
			hql.append(" and t.id in (select userId from UserInformation where mobile='"+mobile+"')");
		}
		return this.get(hql.toString());
	}

	@Override
	public Pager<User> findSubcenterUser(SystemContext syct, UserM userM,String userType) {
		StringBuffer hql = new StringBuffer("from User t where userType='"+userType.trim()+"'");
		if (userM != null) {// 添加查询条件
			if (userM.getUserName() != null && !userM.getUserName().trim().equals("")) {
				hql.append(" and t.userName like '%%").append(userM.getUserName().trim()).append("%%' ");
			}
		}
		hql.append(" order by t.createDateTime desc");
		return this.find(hql.toString(),syct);
	}

}
	
