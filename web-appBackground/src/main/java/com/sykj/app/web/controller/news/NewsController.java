package com.sykj.app.web.controller.news;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sykj.app.entity.news.Article;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.news.NewsService;
import com.sykj.app.web.controller.BaseController;

@Controller
@RequestMapping("/news")
public class NewsController extends BaseController {

	@Resource
	private NewsService newsService;

	/**
	 * 官方新闻列表
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(params = "index")
	public ModelAndView index(HttpServletRequest request, HttpSession session, Model model) {
		ModelAndView mv = this.getModelAndView();
		String page = request.getParameter("page");
		String typeId = request.getParameter("typeName");
		Pager<Article> particle =null;
		Pager<Article> particle2=null;
		if (page == null) {
			page = "1";
		}
		long pageTimes;// 页数
		int pageSize = 5;// 每页显示记录数
		SystemContext syct = new SystemContext();
		syct.setNumPerPage(pageSize);
		syct.setPageNum(Integer.parseInt(page));
		if (typeId == null || typeId.equals("官方公告")) {
			 particle = newsService.findArticleByType(syct, "官方公告");
			particle2 = newsService.findArticleByType(syct, "新闻资讯");
		} else {
			particle = newsService.findArticleByType(syct, "新闻资讯");
			particle2 = newsService.findArticleByType(syct, "官方公告");
		}
		
		long totalNum = particle.getTotalCount();// 总记录数
		if (totalNum % pageSize == 0) {
			pageTimes = totalNum / pageSize;
		} else {
			pageTimes = totalNum / pageSize + 1;
		}

		try {
			mv.setViewName("news/index2");
			mv.addObject("articleList", particle.getDatas());
			mv.addObject("articleList2", particle2.getDatas());
			mv.addObject("totalNum", totalNum);
			mv.addObject("currentPage", Integer.parseInt(page));
			mv.addObject("pageTimes", pageTimes);
		} catch (Exception e) {

		}
		return mv;

	}

	@RequestMapping(params = "detail")
	public ModelAndView detail(HttpServletRequest request, HttpSession session, Model model) {
		ModelAndView mv = this.getModelAndView();
		String id = request.getParameter("id");
		Article articleDetail = newsService.getArticleById(id);
		mv.setViewName("news/detail");
		mv.addObject("articleDetail", articleDetail);

		// return "front/news/detail";
		return mv;
	}
}
