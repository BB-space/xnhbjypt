package com.sykj.app.service.question;

import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.question.UserQuestionM;


/**
 * 前台注册登录
 * @author lsq
 *
 */
public interface UserQuestionService {

	/**
	 * 添加提问记录
	 */
	public void addUserQuestion(UserQuestion question);
	
	/**
	 * 删除提问记录
	 */
	public void cancelQuestion(UserQuestion question);
	
	/**
	 * 获得所有提问记录（分页）
	 */
	public Pager<UserQuestion> findUserQuestion(SystemContext syct, UserQuestionM question);
}
