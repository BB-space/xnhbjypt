package com.sykj.app.dao.news.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.news.ArticleDao;
import com.sykj.app.entity.news.Article;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("articleDao")
public class ArticleDaoImpl extends BaseDao<Article> implements ArticleDao {

	@Override
	public Pager<Article> findArticlePager(SystemContext syct,String type){
		System.out.println(syct.getNumPerPage()+"***"+syct.getPageNum());
		String hql = "from Article t where 1=1 and t.typeName='"+type+"'";
		return this.find(hql, syct);
	}


}
