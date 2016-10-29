package com.sykj.app.service.question.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.question.UserQuestionDao;
import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.question.UserQuestionM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.question.UserQuestionService;

@Service("userQuestionService")
public class UserQuestionServiceImpl extends BaseServiceImpl implements UserQuestionService{

	@Resource
	private UserQuestionDao userQuestionDao;

	@Override
	public void addUserQuestion(UserQuestion question) {
		
		question.setQuestionId(UUID.randomUUID().toString());
		question.setCreateDateTime(new Date());
		question.setStatus("未解决");
		
		userQuestionDao.addUserQuestion(question);
	}

	@Override
	public EasyuiDataGridJson findUserQuestion(SystemContext syct, UserQuestionM question) {
		EasyuiDataGridJson edgj = new EasyuiDataGridJson();
		Pager<UserQuestion> pPager = userQuestionDao.findUserQuestion(syct, question);
		List<UserQuestion> list = pPager.getDatas();
		List<UserQuestionM> mlist = new ArrayList<UserQuestionM>(); 
		if(list.size() > 0){
			for (UserQuestion sp : list) {
				UserQuestionM spm = new UserQuestionM();
				BeanUtils.copyProperties(sp, spm);
				mlist.add(spm);
			}
		}
		edgj.setRows(mlist);
		edgj.setTotal(pPager.getTotalCount());
		return edgj;
	}
	
	
	
}
