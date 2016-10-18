package com.sykj.app.dao.user.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.user.MemberToEmployeesDao;
import com.sykj.app.entity.user.MemberToEmployees;
import com.sykj.app.entity.user.User;
import com.sykj.common.dao.BaseDao;

@Repository("memberToEmployeesDao")
public class MemberToEmployeesDaoImpl extends BaseDao<MemberToEmployees>
		implements MemberToEmployeesDao {

	@Override
	public void addMemberToEmployees(MemberToEmployees memberToEmployees) {
		this.add(memberToEmployees);
		
	}
	
	//根据状态查看提交申请
	@Override
	public List<MemberToEmployees> fingByStatus(String shopId) {
		String hql="from MemberToEmployees u where  u.shopId='"+shopId+"' order by u.createDateTime desc";
		return this.list(hql);
	}

	//根据申请人编号查询申请人信息
	@Override
	public MemberToEmployees findById(String id) {
		
		return this.get(MemberToEmployees.class, id);
	}

	//对申请人进行编辑
	@Override
	public void updateMemberToEmployees(MemberToEmployees m) {
		this.update(m);
	}

	//根据申请账号查看申请记录
	@Override
	public List<MemberToEmployees> getPhone(String phone) {
		String hql="from MemberToEmployees t where t.mobile='"+phone+"'";
		return this.list(hql);
	}

	


}
