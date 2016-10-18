package com.sykj.app.service.area;

import java.util.List;

import com.sykj.app.entity.area.Shop;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.SystemContext;

public interface ShopService {
	
	/**
	 * 添加门店
	 * @param Shop
	 */
	public Shop addShop(Shop shop);
	
	/**
	 * 添加门店(带二维码)
	 * @param Shop
	 */
	public Shop addShop(Shop shop,String shopid,String url);
	
	/**
	 * 删除门店
	 * @param Shop
	 */
	public void deleteShop(String ids);
	
	/**
	 * 编辑门店
	 */
	public Shop editShop(Shop shop);
	
	/**
	 * 查询门店列表
	 * @param dg
	 * @param Shop
	 * @return
	 */
	public EasyuiDataGridJson datagrid(SystemContext syct, Shop shop);
	
	/**
	 * 根据城市获得门店
	 */
	public List<Shop> getShopByCityId(String cityId);
	
	/**
	 * 获得未开通门店 
	 */
	public List<Shop> getShopByCityId(String cityId,String status);
	
	/**
	 * 根据城市搜索门店
	 */
	public List<Shop> getShopBySrContent(String cityId,String rscontent);
	
	public List<Shop> getShopBySrContentType(String cityId,String rscontent,String shopType);
	
	/**
	 * 根据分中心获得门店
	 */
	public List<Shop> getShopBySubcenterId(String subcenterId);

	
	/**
	 * 查找所有门店
	 */
	public List<Shop> findAllShop();
	
	/**
	 * 根据门店名称模糊查找
	 */
	public List<Shop> findShopByName(String shopName);

	
	/**
	 * 获得所有门店
	 * @return
	 */
	public List<Shop> getAll();

	/**
	 * 根据编号查询门店
	 * @param id
	 * @return
	 */
	public Shop getId(String id);
	
	/**
	 * 根据门店编码查找门店
	 */
	public Shop getShopByNumber(String shopNumber);
	
	/**
	 * 根据条件查找
	 * rowNum:查找的行数
	 */
	public List<Shop> find(String shopName);
	
	/**
	 * 生成门店二维码
	 */
	public String createQRCode(String url,String id);
	
	/**
	 * 根据条件查询
	 * @return
	 */
	public List<Shop> getByCondition();

	/**
	 * 预约门店
	 */
	//查找人气最高的纪录
	public List<Shop> getReserForHeat(int rowNum);
	//查找好评最高的记录
	public List<Shop> getReserForCommit(int rowNum);
	
	/**
	 * 获得所有测试门店
	 */
	public List<Shop> getTestAll();
	
	/**
	 * 根据openId获取门店
	 */
	public Shop findShopByOpenId(String openId);
	
	/**
	 * 根据城市获取预约门店---预约门店的离我最近
	 */
	public List<Shop> findShopRSByCityName(String cityName);
	
	/**
	 * 编辑门店图集
	 * @param id
	 */
	public void updateShopPictures(Shop shop);
	
	/**
	 * 编辑门店的最少上班人数
	 */
	public Integer editShopMinEmp(Shop shop);
	/**
	 * 获取一个城市的门店并排序
	 */
	public List<Shop> getShopByCity(String openId, String cityId);
	
	/**
	 * 获取珠海中山丝荟预约门店
	 */
	public List<Shop> getShopByHZS(String openId,String[] cityStr);
	
	/**
	 * 获取禅城顺德预约门店
	 */
	public List<Shop> getShopByCS(String openId);
	
	/**
	 * 批量导入更新门店
	 */
	public List<Shop> addOrUpdateShop(List<Shop> shopList);
	/**
	 * 获取直营门店
	 */
	public List<Shop> getZYShopByCityId(String cityId);
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
	public List<Shop> findByCityGroup(String cityGroup);
	
	/**
	 * 根据门店短编号查询
	 * @param shortNumber
	 * @return
	 */
	public Shop getByShortNumber(String shortNumber);
	
	/**
	 * 判断扫码人
	 */
	public Boolean judgeScannerShop(String shopOpenId);
	
	/**
	 * 查找所有直营门店
	 * @return
	 */
	public List<Shop> findZhiYing();
	
	/**
	 * 根据分中心
	 * 获得门店树
	 */
	public List<EasyuiTreeNode> tree(String subcenterId);
}
