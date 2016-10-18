package com.sykj.app.service.user;

import java.util.List;

import com.sykj.app.entity.user.MemberToEmployees;
import com.sykj.app.entity.user.SubordinateUser;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.UserM;


/**
 * 申请成为员工
 * @author zq
 *
 */
public interface MemberToEmployeesService {
	
	/**
	 * 用户申请员工
	 */
	public int addEmployees(String openId,MemberToEmployees m);
	
	/**
	 * 查看提交申请的记录
	 * @param status
	 * @return
	 */
	public List<MemberToEmployees> findByStatus(String shopId);
	
	/**
	 * 根据申请编号查询申请人信息
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
	 * 使其成为员工
	 * @param phone
	 * @return
	 */
	public int updateStatus(String id,/*Integer code,*/String shopId);
	
	/**
	 * 拒绝成为员工
	 * @param id
	 */
	public void updateMemberStatus(String id,String shopId);

}
