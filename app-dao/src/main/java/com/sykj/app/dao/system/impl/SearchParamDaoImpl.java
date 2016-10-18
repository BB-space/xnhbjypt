package com.sykj.app.dao.system.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sykj.app.dao.system.SearchParamDao;
import com.sykj.app.entity.area.Province;
import com.sykj.app.entity.system.SearchParam;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.common.dao.BaseDao;

@Repository("searchParamDao")
public class SearchParamDaoImpl extends BaseDao<SearchParam> implements
		SearchParamDao {

	@Override
	public void addSearchParam(SearchParam t) {
		this.add(t);
	}

	@Override
	public SearchParam getSearchParam(String id) {
		return this.get("from SearchParam t where t.id='"+id+"'");
	}

	@Override
	public void deleteSearchParam(String id) {
		this.delete(this.getSearchParam(id));
	}
	
	@Override
	public void deleteSearchParamByMenuIdMobile(SearchParam s) {
		String hql = "delete from SearchParam t where t.menuId='"+s.getMenuId()+"' and t.mobile='"+s.getMobile()+"'"; 
		this.updateByHql(hql);
	}

	@Override
	public SearchParam getSearchParamByMenuUserId(SearchParam t) {
		String hql = " from SearchParam t where t.menuId='"+t.getMenuId()+"' and t.mobile='"+t.getMobile()+"'";
		List<SearchParam> list = this.list(hql);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	@Override
	public Pager<SearchParam> findSearchParam(SystemContext syct, SearchParam t) {
		StringBuffer hql = new StringBuffer("from SearchParam t where 1=1 ORDER BY t.createDateTime desc");
		return this.find(hql.toString(),syct);
	}

	@Override
	public SearchParam findSearchParamByUserId(String userId, String src) {
//		StringBuffer hql = new StringBuffer("SELECT * from sykj_system_searchparam"
//				+ " WHERE mobile=(SELECT MOBILE from sykj_user_userinformation where USERID='"+userId+"')"
//						+ " and menuId = (SELECT ID from sykj_system_menu where src = '"+src+"')");
		StringBuffer hql = new StringBuffer("from SearchParam"
				+ " WHERE mobile=(SELECT mobile from UserInformation where userId='"+userId+"')"
						+ " and menuId = (SELECT id from Menu where src = '"+src+"')");
		return this.get(hql.toString());
		
	}
	
	
}
