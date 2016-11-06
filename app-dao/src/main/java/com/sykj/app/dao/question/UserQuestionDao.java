package com.sykj.app.dao.question;

import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.question.UserQuestionM;
import com.sykj.common.dao.IBaseDao;

public interface UserQuestionDao extends IBaseDao<UserQuestion>{

	/**
	 * 查找提问记录
	 */
	public UserQuestion getUserQuestion(String id);
	/**
	 * 添加提问记录
	 */
	public void addUserQuestion(UserQuestion question);
	
	/**
	 * 删除提问记录
	 */
	public void cancelQuestion(String id);
	/**
	 * 获得所有提问记录（分页）
	 */
	public Pager<UserQuestion> findUserQuestion(SystemContext syct, UserQuestionM question);
	
}
