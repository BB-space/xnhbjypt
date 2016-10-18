package com.sykj.app.dao.user;

import java.util.List;

import com.sykj.app.entity.user.MemberToEmployees;
import com.sykj.app.entity.user.User;
import com.sykj.common.dao.IBaseDao;

public interface MemberToEmployeesDao extends IBaseDao<MemberToEmployees>{

	/**
	 * 提交申请成为员工
	 */
	public void addMemberToEmployees(MemberToEmployees memberToEmployees);
	
	/**
	 * 根据状态查询是否提交申请
	 * @param status
	 * @return
	 */
	public List<MemberToEmployees> fingByStatus(String shopId);
	
	/**
	 * 根据申请人编号查询申请人信息
	 * @param id
	 * @return
	 */
	public MemberToEmployees findById(String id);
	
	/**
	 * 对申请人进行编辑
	 * @param m
	 */
	public void updateMemberToEmployees(MemberToEmployees m);
	
	/**
	 * 根据申请账号查询申请记录
	 * @param phone
	 * @return
	 */
	public List<MemberToEmployees> getPhone(String phone);
	
}
