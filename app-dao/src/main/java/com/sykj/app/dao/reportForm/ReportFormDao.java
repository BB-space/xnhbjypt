package com.sykj.app.dao.reportForm;

import java.util.List;


import com.sykj.app.model.reportForm.ReportFormM;
import com.sykj.common.dao.IBaseDao;

public interface ReportFormDao extends IBaseDao<ReportFormM>{

	/**
	 * 根据类型导出10元券报表或18元券报表
	 * @param type
	 * @return
	 */
	public List<Object> exportTenAndEighteen(String date,String type,int fromNo,int size);
	
	/**
	 * 导出门店核销10元券报表
	 * @return
	 */
	public List<Object> exportShopTen(int fromNo,int size);
	
	/**
	 * 导出亲友券报表
	 * @return
	 */
	public List<Object> exportFriend(String date,int fromNo,int size);
	
	/**
	 * 导出门店核销亲友券报表
	 * @return
	 */
	public List<Object> exportShopFriend(int fromNo,int size);
	
	/**
	 * 导出会员项目券和产品券报表
	 * @return
	 */
	public List<Object> exportItemGood(String date,int fromNo,int size);
	
	/**
	 * 根据类型导出门店核销项目券、348产品券、108产品券报表
	 * @param type
	 * @return
	 */
	public List<Object> exportShopItemGood(String type,int fromNo,int size);
}
