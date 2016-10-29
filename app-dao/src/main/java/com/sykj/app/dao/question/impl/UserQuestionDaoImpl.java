package com.sykj.app.dao.question.impl;



import org.springframework.stereotype.Repository;

import com.sykj.app.dao.question.UserQuestionDao;
import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.question.UserQuestionM;
import com.sykj.common.dao.BaseDao;

@Repository("userQuestionDao")
public class UserQuestionDaoImpl extends BaseDao<UserQuestion> implements UserQuestionDao{

	@Override
	public UserQuestion getUserQuestion(String id) {
		return this.get("from UserQuestion t where t.questionId='"+id+"'");
	}

	@Override
	public void addUserQuestion(UserQuestion question) {
		
		this.add(question);
	}

	@Override
	public Pager<UserQuestion> findUserQuestion(SystemContext syct, UserQuestionM question) {
		StringBuffer hql = new StringBuffer("from UserQuestion t where 1=1");
		if(question !=null){// 添加查询条件
			if (question.getStatus() != null && !question.getStatus().trim().equals("")) {
				hql.append(" and t.status = '").append(question.getStatus().trim()).append("' ");
			}
		}
		hql.append(" order by t.createDateTime desc");
		return this.find(hql.toString(),syct);
	}

	

}
	
