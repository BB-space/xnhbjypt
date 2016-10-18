package com.sykj.app.dao.system;

import com.sykj.app.entity.system.SearchParam;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.IBaseDao;

/**
 * 搜索参数 
 */
public interface SearchParamDao extends IBaseDao<SearchParam>{
	
	/**
	 * 添加
	 * @param t
	 */
	public void addSearchParam(SearchParam t);
	
	/**
	 * 获取
	 * @param id
	 * @return
	 */
	public SearchParam getSearchParam(String id);
	
	/**
	 * 删除
	 * @param id
	 */
	public void deleteSearchParam(String id);
	
	/**
	 * 根据菜单Id、手机号码删除数据
	 * @param s
	 */
	public void deleteSearchParamByMenuIdMobile(SearchParam s);
	
	/**
	 * 
	 * @param t
	 * @return
	 */
	public SearchParam getSearchParamByMenuUserId(SearchParam t);
	
	/**
	 * 获得（分页）
	 */
	public Pager<SearchParam> findSearchParam(SystemContext syct, SearchParam t);

	
	public SearchParam findSearchParamByUserId(String userId, String src);
	
}
