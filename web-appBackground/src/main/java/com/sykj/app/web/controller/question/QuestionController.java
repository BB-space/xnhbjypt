package com.sykj.app.web.controller.question;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.EasyuiDataGrid;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.FrontUserM;
import com.sykj.app.model.Json;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.question.UserQuestionM;
import com.sykj.app.service.question.UserQuestionService;
import com.sykj.app.service.user.FrontUserService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/question")
public class QuestionController extends BaseController{
	@Resource
	private UserQuestionService userQuestionService;
	@Resource
	private FrontUserService frontUserService;
	
	@RequestMapping(params="question")
	public String question(HttpSession session) {
		
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			if(b){  //已经实名认证
				return "/question/question";
			}
		}
		return "/safe/safe_userSetting";
	}
	
	@RequestMapping(params="questionColumn")
	public String questionColumn(HttpSession session) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			if(b){  //已经实名认证
				return "/question/questionColumn";
			}
		}
		return "/safe/safe_userSetting";
	}
	
	/**
	 * 提交问题
	 * @param userQuestion
	 * @param session
	 * @param req
	 * @param response
	 * @return
	 */
	@RequestMapping(params="submitQuestion")
	@ResponseBody
	public Json submitQuestion(UserQuestion userQuestion, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			userQuestion.setLoginName(frontUserM.getUserName());
			
			userQuestionService.addUserQuestion(userQuestion);
			j.setSuccess(true);
		}
		return j;
	}
	
	/**
	 * 获取问题列表
	 * @param dg
	 * @param searchParam
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(params="questionParamDatagrid")
	@ResponseBody
	public EasyuiDataGridJson questionDatagrid(EasyuiDataGrid dg, UserQuestionM userQuestion) {
		SystemContext syct=new SystemContext();
		syct.setNumPerPage(dg.getRows());
		syct.setOrder(dg.getOrder());
		syct.setPageNum(dg.getPage());
		syct.setSort(dg.getSort());
		return userQuestionService.findUserQuestion(syct, userQuestion);
	}
	
}
