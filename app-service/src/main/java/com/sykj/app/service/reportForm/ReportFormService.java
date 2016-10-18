package com.sykj.app.service.reportForm;

import java.util.List;

import com.sykj.app.model.reportForm.Friend;
import com.sykj.app.model.reportForm.ItemGood;
import com.sykj.app.model.reportForm.ShopFriend;
import com.sykj.app.model.reportForm.ShopItemGood;
import com.sykj.app.model.reportForm.ShopTen;
import com.sykj.app.model.reportForm.TenAndEighteen;
import com.sykj.app.service.BaseService;

public interface ReportFormService extends BaseService{

	/**
	 * 根据类型导出10元券报表或18元券报表
	 * @param type
	 * @return
	 */
	public List<TenAndEighteen> exportTenAndEighteens(String type,int page,int rows);
	
	/**
	 * 导出门店核销10元券报表
	 * @return
	 */
	public List<ShopTen> exportShopTen(int page,int rows);
	
	/**
	 * 导出亲友券报表
	 * @return
	 */
	public List<Friend> exportFriend(int page,int rows);
	
	/**
	 * 导出门店核销亲友券报表
	 * @return
	 */
	public List<ShopFriend> exportShopFriend(int page,int rows);
	
	/**
	 * 导出会员项目券和产品券报表
	 * @return
	 */
	public List<ItemGood> exportItemGood(int page,int rows);
	
	/**
	 * 根据类型导出门店核销项目券、348产品券、108产品券报表
	 * @param type
	 * @return
	 */
	public List<ShopItemGood> exportShopItemGood(String type,int page,int rows);
	
}
