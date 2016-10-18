package com.sykj.app.service.system;

import java.util.List;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.system.SearchParam;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.SystemContext;

/**
 * 系统参数
 */
public interface SearchParamService {
	
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
	 * @param ids
	 */
	public void deleteSearchParam(String ids);
	
	/**
	 * 查询列表
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, SearchParam t);
	
	/**
	 * 根据用户Id，菜单src查找
	 * @param userId
	 * @param src
	 * @return
	 */
	public List<City> findSearchParamByUserId(String userId, String src);
	
	/**
	 * 查找城市
	 * @return
	 */
	public List<City> findSearchCity();
}
