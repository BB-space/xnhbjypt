package com.sykj.app.web.controller.question;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sykj.app.entity.question.UserQuestion;
import com.sykj.app.model.FrontUserM;
import com.sykj.app.model.Json;
import com.sykj.app.model.Pager;
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
	public String questionColumn(UserQuestionM userQuestion, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			if(b){  //已经实名认证
				String page = request.getParameter("page");
				if (page == null) {
					page = "1";
				}
				SystemContext syct=new SystemContext();
				syct.setPageNum(Integer.parseInt(page));
				long pageTimes;// 页数
				int pageSize = 10;// 每页显示记录数
				syct.setNumPerPage(pageSize);
				userQuestion.setLoginName(frontUserM.getUserName());
				userQuestion.setStatus("未解决");
				Pager<UserQuestion> pager = userQuestionService.findUserQuestion(syct, userQuestion);
				long totalNum = pager.getTotalCount();// 总记录数
				if (totalNum % pageSize == 0) {
					pageTimes = totalNum / pageSize;
				} else {
					pageTimes = totalNum / pageSize + 1;
				}

				try {
					request.setAttribute("questionList", pager.getDatas());
					request.setAttribute("totalNum", totalNum);
					request.setAttribute("currentPage", Integer.parseInt(page));
					request.setAttribute("pageTimes", pageTimes);
				} catch (Exception e) {

				}
				
				return "/question/questionColumn";
			}
		}
		return "/safe/safe_userSetting";
	}
	
	@RequestMapping(params="questionColumn2")
	public String questionColumn2(UserQuestionM userQuestion, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		FrontUserM frontUserM = (FrontUserM) session.getAttribute("frontUserM");
		if(frontUserM != null){
			//检查用户是否实名认证
			boolean b = frontUserService.certification(frontUserM.getId());
			if(b){  //已经实名认证
				String page = request.getParameter("page");
				if (page == null) {
					page = "1";
				}
				SystemContext syct=new SystemContext();
				syct.setPageNum(Integer.parseInt(page));
				long pageTimes;// 页数
				int pageSize = 10;// 每页显示记录数
				syct.setNumPerPage(pageSize);
				userQuestion.setLoginName(frontUserM.getUserName());
				userQuestion.setStatus("解决");
				Pager<UserQuestion> pager = userQuestionService.findUserQuestion(syct, userQuestion);
				long totalNum = pager.getTotalCount();// 总记录数
				if (totalNum % pageSize == 0) {
					pageTimes = totalNum / pageSize;
				} else {
					pageTimes = totalNum / pageSize + 1;
				}

				try {
					request.setAttribute("questionList", pager.getDatas());
					request.setAttribute("totalNum", totalNum);
					request.setAttribute("currentPage", Integer.parseInt(page));
					request.setAttribute("pageTimes", pageTimes);
				} catch (Exception e) {

				}
				return "/question/questionColumn2";
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
	
	@RequestMapping(params="cancelQuestion")
	@ResponseBody
	public Json deleteQuestion(UserQuestion userQuestion, HttpSession session,
			HttpServletRequest req,HttpServletResponse response) {
		Json j = new Json();
		userQuestionService.deleteQuestion(userQuestion);
		j.setSuccess(true);
		return j;
	}
	
}
