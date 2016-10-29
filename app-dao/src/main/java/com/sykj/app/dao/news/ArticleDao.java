package com.sykj.app.dao.news;

import com.sykj.app.entity.news.Article;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

public interface ArticleDao extends IBaseDao<Article> {

	/**
	 * 根据新闻类型查找新闻
	 */
	public Pager<Article> findArticlePager(SystemContext syct,String type);


}
