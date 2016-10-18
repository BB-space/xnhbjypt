/**
 * 
 */
package com.sykj.common.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;

import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;

/**
 * @author Administrator
 *
 */
@SuppressWarnings("unchecked")
public class BaseDao<T> implements IBaseDao<T> {
	
	private SessionFactory sessionFactory;
	/**
	 * 创建一个Class的对象来获取泛型的class
	 */
	private Class<?> clz;
	
	public Class<?> getClz() {
		if(clz==null) {
			//获取泛型的Class对象
			clz = ((Class<?>)
					(((ParameterizedType)(this.getClass().getGenericSuperclass())).getActualTypeArguments()[0]));
		}
		return clz;
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}
	
	@Inject
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	protected Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#add(java.lang.Object)
	 */
	@Override
	public T add(T t) {
		getSession().save(t);
		return t;
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#update(java.lang.Object)
	 */
	@Override
	public void update(T t) {
		getSession().update(t);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#delete(int)
	 */
	@Override
	public void delete(int id) {
		getSession().delete(this.load(id));
	}
	public void delete(T o) {
		getSession().delete(o);
	}
	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#load(int)
	 */
	@Override
	public T load(int id) {
		return (T)getSession().load(getClz(), id);
	}
	@Override
	public T get(Class<T> c, Serializable id) {
		return (T) this.getSession().get(c, id);
	}
	
	public T get(String hql){
		List l = this.list(hql, null);
		if (l != null && l.size() > 0) {
			return (T) l.get(0);
		}
		return null;
	}
	
	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#list(java.lang.String, java.lang.Object[])
	 */
	public List<T> list(String hql, List<Object> args) {
		return this.list(hql, args, null);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#list(java.lang.String, java.lang.Object)
	 */
	public List<T> list(String hql, Object arg) {
		List<Object> args =new ArrayList<Object>();
		args.add(arg);
		return this.list(hql, args);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#list(java.lang.String)
	 */
	public List<T> list(String hql) {
		return this.list(hql,null);
	}
	
	private String initSort(String hql) {
		SystemContext syct = new SystemContext();
		String order = syct.getOrder();
		String sort = syct.getSort();
		if(sort!=null&&!"".equals(sort.trim())) {
			hql+=" order by "+sort;
			if(!"desc".equals(order)) hql+=" asc";
			else hql+=" desc";
		}
		return hql;
	}
	
	@SuppressWarnings("rawtypes")
	private void setAliasParameter(Query query,Map<String,Object> alias) {
		if(alias!=null) {
			Set<String> keys = alias.keySet();
			for(String key:keys) {
				Object val = alias.get(key);
				if(val instanceof Collection) {
					//查询条件是列表
					query.setParameterList(key, (Collection)val);
				} else {
					query.setParameter(key, val);
				}
			}
		}
	}
	
	private void setParameter(Query query,List<Object> args) {
		if(args!=null&&args.size()>0) {
			int index = 0;
			for(Object arg:args) {
				query.setParameter(index++, arg);
			}
		}
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#list(java.lang.String, java.lang.Object[], java.util.Map)
	 */
	public List<T> list(String hql, List<Object> args, Map<String, Object> alias) {
		hql = initSort(hql);
		Query query = getSession().createQuery(hql);
		setAliasParameter(query, alias);
		setParameter(query, args);
		return query.list();
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#list(java.lang.String, java.util.Map)
	 */
	public List<T> listByAlias(String hql, Map<String, Object> alias) {
		return this.list(hql, null, alias);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#find(java.lang.String, java.lang.Object[])
	 */
	public Pager<T> find(String hql, List<Object> args,SystemContext syct) {
		return this.find(hql, args, null,syct);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#find(java.lang.String, java.lang.Object)
	 */
	public Pager<T> find(String hql, Object arg) {
		return this.find(hql, new Object[]{arg});
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#find(java.lang.String)
	 */
	public Pager<T> find(String hql,SystemContext syct) {
		return this.find(hql,null,syct);
	}
	
	@SuppressWarnings("rawtypes")
	private void setPagers(Query query,Pager pager,SystemContext syct) {
		Integer pageSize = syct.getNumPerPage();
		Integer pageOffset = syct.getPageNum();
		if(pageOffset==null||pageOffset<0) pageOffset = 1;
		if(pageSize==null||pageSize<0) pageSize = 10;
		pager.setCurrentPage(pageOffset);
		pager.setNumPerPage(pageSize);
		query.setFirstResult((pageOffset - 1) * pageSize).setMaxResults(pageSize);
	}
	
	private String getCountHql(String hql,boolean isHql) {
		String e = hql.substring(hql.indexOf("from"));
		String c = "select count(*) "+e;
		if(isHql)
			c = c.replaceAll("fetch", "");
		return c;
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#find(java.lang.String, java.lang.Object[], java.util.Map)
	 */
	public Pager<T> find(String hql, List<Object> args, Map<String, Object> alias,SystemContext syct) {
		hql = initSort(hql);
		String cq = getCountHql(hql,true);
		Query cquery = getSession().createQuery(cq);
		Query query = getSession().createQuery(hql);
		//设置别名参数
		setAliasParameter(query, alias);
		setAliasParameter(cquery, alias);
		//设置参数
		setParameter(query, args);
		setParameter(cquery, args);
		Pager<T> pager = new Pager<T>();
		setPagers(query,pager,syct);
		List<T> datas = query.list();
		pager.setDatas(datas);
		long total = (Long)cquery.uniqueResult();
		pager.setTotalCount(total);
		return pager;
	}
	
	public List<T> find(String hql, int page, int rows, List<Object> param) {
		Query q = this.getSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
	}
	public Long count(String hql, List<Object> param) {
		Query q = this.getSession().createQuery(hql);
		if (param != null && param.size() > 0) {
			for (int i = 0; i < param.size(); i++) {
				q.setParameter(i, param.get(i));
			}
		}
		return (Long) q.uniqueResult();
	}
	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#find(java.lang.String, java.util.Map)
	 */
	public Pager<T> findByAlias(String hql, Map<String, Object> alias,SystemContext syct) {
		return this.find(hql,null, alias,syct);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#queryObject(java.lang.String, java.lang.Object[])
	 */
	public Object queryObject(String hql,List<Object> args) {
		return this.queryObject(hql, args,null);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#queryObject(java.lang.String, java.lang.Object)
	 */
	public Object queryObject(String hql, Object arg) {
		return this.queryObject(hql, new Object[]{arg});
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#queryObject(java.lang.String)
	 */
	public Object queryObject(String hql) {
		return this.queryObject(hql,null);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#updateByHql(java.lang.String, java.lang.Object[])
	 */
	public void updateByHql(String hql, List<Object> args) {
		Query query = getSession().createQuery(hql);
		setParameter(query, args);
		query.executeUpdate();
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#updateByHql(java.lang.String, java.lang.Object)
	 */
	public void updateByHql(String hql, Object arg) {
		this.updateByHql(hql,new Object[]{arg});
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#updateByHql(java.lang.String)
	 */
	public void updateByHql(String hql) {
		this.updateByHql(hql,null);
	}
	
	public void updateBySql(String sql, List<Object> args) {
		Query query = getSession().createSQLQuery(sql);
		setParameter(query, args);
		query.executeUpdate();
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#updateByHql(java.lang.String, java.lang.Object)
	 */
	public void updateBySql(String sql, Object arg) {
		this.updateBySql(sql,new Object[]{arg});
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#updateByHql(java.lang.String)
	 */
	public void updateBySql(String sql) {
		this.updateBySql(sql,null);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#listBySql(java.lang.String, java.lang.Object[], java.lang.Class, boolean)
	 */
	public <N extends Object>List<N> listBySql(String sql, List<Object> args, Class<?> clz,
			boolean hasEntity) {
		return this.listBySql(sql, args, null, clz, hasEntity);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#listBySql(java.lang.String, java.lang.Object, java.lang.Class, boolean)
	 */
	public <N extends Object>List<N> listBySql(String sql, Object arg, Class<?> clz,
			boolean hasEntity) {
		return this.listBySql(sql, new Object[]{arg}, clz, hasEntity);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#listBySql(java.lang.String, java.lang.Class, boolean)
	 */
	public <N extends Object>List<N> listBySql(String sql, Class<?> clz, boolean hasEntity) {
		return this.listBySql(sql, null, clz, hasEntity);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#listBySql(java.lang.String, java.lang.Object[], java.util.Map, java.lang.Class, boolean)
	 */
	public <N extends Object>List<N> listBySql(String sql, List<Object> args,
			Map<String, Object> alias, Class<?> clz, boolean hasEntity) {
		sql = initSort(sql);
		SQLQuery sq = getSession().createSQLQuery(sql);
		setAliasParameter(sq, alias);
		setParameter(sq, args);
		if(hasEntity) {
			sq.addEntity(clz);
		} else 
			sq.setResultTransformer(Transformers.aliasToBean(clz));
		return sq.list();
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#listBySql(java.lang.String, java.util.Map, java.lang.Class, boolean)
	 */
	public <N extends Object>List<N> listByAliasSql(String sql, Map<String, Object> alias,
			Class<?> clz, boolean hasEntity) {
		return this.listBySql(sql, null, alias, clz, hasEntity);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#findBySql(java.lang.String, java.lang.Object[], java.lang.Class, boolean)
	 */
	public <N extends Object>Pager<N> findBySql(String sql, List<Object> args, Class<?> clz,
			boolean hasEntity,SystemContext syct) {
		return this.findBySql(sql, args, null, clz, hasEntity,syct);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#findBySql(java.lang.String, java.lang.Object, java.lang.Class, boolean)
	 */
	public <N extends Object>Pager<N> findBySql(String sql, Object arg, Class<?> clz,
			boolean hasEntity) {
		return this.findBySql(sql, null, clz, hasEntity,null);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#findBySql(java.lang.String, java.lang.Class, boolean)
	 */
	public <N extends Object>Pager<N> findBySql(String sql, Class<?> clz, boolean hasEntity) {
		return this.findBySql(sql, null, clz, hasEntity);
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#findBySql(java.lang.String, java.lang.Object[], java.util.Map, java.lang.Class, boolean)
	 */
	public <N extends Object>Pager<N> findBySql(String sql,List<Object> args,
			Map<String, Object> alias, Class<?> clz, boolean hasEntity,SystemContext syct) {
		sql = initSort(sql);
		String cq = getCountHql(sql,false);
		SQLQuery sq = getSession().createSQLQuery(sql);
		SQLQuery cquery = getSession().createSQLQuery(cq);
		setAliasParameter(sq, alias);
		setAliasParameter(cquery, alias);
		setParameter(sq, args);
		setParameter(cquery, args);
		Pager<N> pages = new Pager<N>();
		setPagers(sq,pages,syct);
		if(hasEntity) {
			sq.addEntity(clz);
		} else {
			sq.setResultTransformer(Transformers.aliasToBean(clz));
		}
		List<N> datas = sq.list();
		pages.setDatas(datas);
		long total = ((BigInteger)cquery.uniqueResult()).longValue();
		pages.setTotalCount(total);
		return pages;
	}

	/* (non-Javadoc)
	 * @see org.konghao.baisc.dao.IBaseDao#findBySql(java.lang.String, java.util.Map, java.lang.Class, boolean)
	 */
	public <N extends Object>Pager<N> findByAliasSql(String sql, Map<String, Object> alias,
			Class<?> clz, boolean hasEntity,SystemContext syct) {
		return this.findBySql(sql, null, alias, clz, hasEntity,syct);
	}

	public Object queryObject(String hql,List<Object> args,
			Map<String, Object> alias) {
		Query query = getSession().createQuery(hql);
		setAliasParameter(query, alias);
		setParameter(query, args);
		return query.uniqueResult();
	}

	public Object queryObjectByAlias(String hql, Map<String, Object> alias) {
		return this.queryObject(hql,null,alias);
	}

	public Integer getMaxId(String hql){
		return (Integer)getSession().createQuery(hql).uniqueResult();
	}
	
	public Integer getIntegerBySql(String sql){
		
		return ((BigInteger) getSession().createSQLQuery(sql).uniqueResult()).intValue();
	}
	
	public List<Object> findSQL(String sql){
		Query q = this.getSession().createSQLQuery(sql);
		return q.list();
	}
	
}
