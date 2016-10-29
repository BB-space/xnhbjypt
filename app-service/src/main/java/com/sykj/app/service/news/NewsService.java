package com.sykj.app.service.news;

import java.util.List;

import com.sykj.app.entity.news.Article;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;

public interface NewsService {

	/**
	 * 根据新闻类型查找新闻列表
	 */
	public Pager<Article> findArticleByType(SystemContext syct,String type);
	
	public Article getArticleById(String id);
}
