package com.sykj.app.service.area;

import java.util.List;

import com.sykj.app.entity.area.ShopApply;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;

public interface ShopApplyService {
	
	/**
	 * 添加门店
	 * @param Shop
	 */
	public ShopApply addShop(ShopApply shop);
	
	/**
	 * 添加门店(带二维码)
	 * @param Shop
	 */
	public ShopApply addShop(ShopApply shop,String shopid,String url,UserM userM);
	
	/**
	 * 删除门店
	 * @param Shop
	 */
	public void deleteShop(String ids);
	
	/**
	 * 编辑门店
	 */
	public ShopApply editShop(ShopApply shop);
	
	
	public ShopApply editShopAudit(String shopId,String status);
	
	/**
	 * 查询门店列表
	 * @param dg
	 * @param Shop
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, ShopApply shop,UserM userM);
	
	/**
	 * 根据城市获得门店
	 */
	public List<ShopApply> getShopByCityId(String cityId);
	
	/**
	 * 获得未开通门店 
	 */
	public List<ShopApply> getShopByCityId(String cityId,String status);
	
	/**
	 * 根据城市搜索门店
	 */
	public List<ShopApply> getShopBySrContent(String cityId,String rscontent);
	
	public List<ShopApply> getShopBySrContentType(String cityId,String rscontent,String shopType);
	
	/**
	 * 根据分中心获得门店
	 */
	public List<ShopApply> getShopBySubcenterId(String subcenterId);

	
	/**
	 * 查找所有门店
	 */
	public List<ShopApply> findAllShop();
	
	/**
	 * 根据门店名称模糊查找
	 */
	public List<ShopApply> findShopByName(String shopName);

	
	/**
	 * 获得所有门店
	 * @return
	 */
	public List<ShopApply> getAll();

	/**
	 * 根据编号查询门店
	 * @param id
	 * @return
	 */
	public ShopApply getId(String id);
	
	/**
	 * 根据门店编码查找门店
	 */
	public ShopApply getShopByNumber(String shopNumber);
	
	/**
	 * 根据条件查找
	 * rowNum:查找的行数
	 */
	public List<ShopApply> find(String shopName);
	
	/**
	 * 生成门店二维码
	 */
	public String createQRCode(String url,String id);
	
	/**
	 * 根据条件查询
	 * @return
	 */
	public List<ShopApply> getByCondition();

	/**
	 * 预约门店
	 */
	//查找人气最高的纪录
	public List<ShopApply> getReserForHeat(int rowNum);
	//查找好评最高的记录
	public List<ShopApply> getReserForCommit(int rowNum);
	
	/**
	 * 获得所有测试门店
	 */
	public List<ShopApply> getTestAll();
	
	/**
	 * 根据openId获取门店
	 */
	public ShopApply findShopByOpenId(String openId);
	
	/**
	 * 根据城市获取预约门店---预约门店的离我最近
	 */
	public List<ShopApply> findShopRSByCityName(String cityName);
	
	/**
	 * 编辑门店图集
	 * @param id
	 */
	public void updateShopPictures(ShopApply shop);
	
	/**
	 * 编辑门店的最少上班人数
	 */
	public Integer editShopMinEmp(ShopApply shop);
	/**
	 * 获取一个城市的门店并排序
	 */
	public List<ShopApply> getShopByCity(String openId, String cityId);
	
	/**
	 * 获取珠海中山丝荟预约门店
	 */
	public List<ShopApply> getShopByHZS(String openId,String[] cityStr);
	
	/**
	 * 获取禅城顺德预约门店
	 */
	public List<ShopApply> getShopByCS(String openId);
	
	/**
	 * 批量导入更新门店
	 */
	public List<ShopApply> addOrUpdateShop(List<ShopApply> shopList);
	/**
	 * 获取直营门店
	 */
	public List<ShopApply> getZYShopByCityId(String cityId);
	/**
	 * 判断员工是否是珠中佛店员
	 */
	public Boolean judgeEmployeeByShop(String openId);
	
	/**
	 * 查询此区域下的门店
	 * zq
	 * @param cityGroup
	 * @return
	 */
	public List<ShopApply> findByCityGroup(String cityGroup);
	
	/**
	 * 根据门店短编号查询
	 * @param shortNumber
	 * @return
	 */
	public ShopApply getByShortNumber(String shortNumber);
	
	/**
	 * 判断扫码人
	 */
	public Boolean judgeScannerShop(String shopOpenId);
	
	/**
	 * 查找所有直营门店
	 * @return
	 */
	public List<ShopApply> findZhiYing();
	
	/**
	 * 根据分中心
	 * 获得门店树
	 */
	public List<EasyuiTreeNode> tree(String subcenterId);
}
