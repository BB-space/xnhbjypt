package com.sykj.app.service.news.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.news.ArticleDao;
import com.sykj.app.entity.news.Article;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.news.NewsService;
import com.sykj.app.util.ClobUtil;
import com.sykj.app.util.DateUtil;
import com.sykj.app.util.HtmlUtil;

@SuppressWarnings("unchecked")
@Service("newsService")
public class NewsServiceImpl extends BaseServiceImpl implements NewsService{

	@Resource
	private ArticleDao articleDao;
	
	@Override
	public Pager<Article> findArticleByType(SystemContext syct,String type) {
		if(type==null){
			type="官方公告";
		}
		Pager<Article> pa = articleDao.findArticlePager(syct,type);
		List<Article> aList = new ArrayList();
		for(Article a:pa.getDatas()){
			try {
				a.setContentStr(HtmlUtil.delHTMLTag(ClobUtil.ClobToString(a.getContent())));
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			a.setMdTime(DateUtil.formatDay(DateUtil.format(a.getCreateDateTime())));
			aList.add(a);
		}
		pa.setDatas(aList);
		return pa;
	}

	@Override
	public Article getArticleById(String id) {
		Article a = articleDao.get(Article.class, id);
		try {
			a.setContentStr(ClobUtil.ClobToString(a.getContent()));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return a;
	}


}
