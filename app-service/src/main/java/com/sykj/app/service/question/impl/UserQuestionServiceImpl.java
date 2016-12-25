package com.sykj.app.service.question.impl;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.question.UserQuestionDao;
import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.question.UserQuestionM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.question.UserQuestionService;
import com.sykj.app.util.DateUtil;

@Service("userQuestionService")
public class UserQuestionServiceImpl extends BaseServiceImpl implements UserQuestionService{

	@Resource
	private UserQuestionDao userQuestionDao;

	@Override
	public void addUserQuestion(UserQuestion question) {
		
		question.setQuestionId(UUID.randomUUID().toString());
		question.setCreateDateTime(DateUtil.format(new Date()));
		question.setSeq(0);
		question.setStatus("未解决");
		
		userQuestionDao.addUserQuestion(question);
	}

	@Override
	public Pager<UserQuestion> findUserQuestion(SystemContext syct, UserQuestionM question) {
		return userQuestionDao.findUserQuestion(syct, question);
	}

	@Override
	public void deleteQuestion(UserQuestion question) {
		userQuestionDao.deleteQuestion(question.getQuestionId());
	}
	
}
