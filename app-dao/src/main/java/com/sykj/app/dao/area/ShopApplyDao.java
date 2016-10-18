package com.sykj.app.dao.area;

import java.util.List;

import com.sykj.app.entity.area.ShopApply;
import com.sykj.app.entity.area.ShopApply;

import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.common.dao.IBaseDao;

public interface ShopApplyDao extends IBaseDao<ShopApply>{

	/**
	 * 查找所有门店
	 */
	public List<ShopApply> findAllShop();
	
	/**
	 * 查找所有测试门店
	 */
	public List<ShopApply> findTestShop();
	/**
	 * 查找门店
	 */
	public ShopApply getShop(String id);
	/**
	 * 根据门店编码查找门店
	 */
	public ShopApply getShopByNumber(String shopNumber);
	
	public ShopApply getByShortNumber(String shortNumber);
	
	/**
	 * 删除门店
	 */
	public void deleteShop(String id);
	
	/**
	 * 根据门店名称模糊查找门店
	 */
	public List<ShopApply> findShopByName(String shopName);
	
	/**
	 * 获得所有门店（分页）
	 */
	public Pager<ShopApply> findShop(SystemContext syct, ShopApply Shop,UserM userM);
	
	/**
	 * 根据城市获得门店
	 */
	public List<ShopApply> findShopByCityId(String cityId);
	/**
	 * 根据城市返回未开通门店 
	 */
	public List<ShopApply> findShopByCityId(String cityId,String status);

	/**
	 * 根据城市搜索门店 
	 */
	public List<ShopApply> findShopBySrContent(String cityId, String rscontent);
	
	public List<ShopApply> findShopBySrContentType(String cityId, String rscontent,String shopType);
	
	/**
	 * 根据分中心获得门店
	 */
	public List<ShopApply> findShopBySubcenterId(String subcenterId);
	
	/**
	 * 根据ID查找对象集合
	 * @param id
	 * @return
	 */
	public List<ShopApply> findShop();
	
	/**
	 * 根据条件查询
	 * @param shopName
	 * @return
	 */
	public List<ShopApply> find(String shopName);
	
	/**
	 * 获取预约门店
	 * rowNum : 代表行数
	 */
	//人气最旺  的门店
	public List<ShopApply> getShopByHeat(int rowNum);
	//好评最高 的门店
	public List<ShopApply> getShopByCommit(int rowNum);
	
	/**
	 * 生成门店二维码
	 */
	public String createQRCode(String url,String id);

	
	public List<ShopApply> getByCondition();
	
	/**
	 * 根据openId获取门店
	 */
	public ShopApply findShopByOpenId(String openId);
	/**
	 * 获取该城市预约数最多的前10家门店记录
	 */
	public List<ShopApply> findShopRSByCityId(String cityId, int number);
	
	/**
	 * 获取该用户预约过的门店
	 */
	public List<ShopApply> getRSShopByCityId(String userId, String cityId);
	/**
	 * 根据多个城市获取门店
	 */
	public List<ShopApply> getRSShopByCityIds(String userId, String[] cityStr);
	
	/**
	 * 根据城市获取门店，并排序
	 * shopIds:预约的门店
	 */
	public List<ShopApply> getShopByCityId(String cityId, String[] shopIds);
	//多个城市
	public List<ShopApply> getShopByCityIds(String[] cityStr, String[] shopIds);
	/**
	 * 获取该市的直营门店
	 */
	public List<ShopApply> findZYShopByCityId(String cityId);
	
	/**
	 * 获取珠中佛丝域直营门店
	 */
	public List<ShopApply> findZhuZhongFo(String belong,String shopType);
	
	/**
	 * 根据区域获取门店
	 */
	public List<Object> findShopInfoByCityGroup(String cityGroup);
	
	/**
	 * 查询此区域下的门店
	 * zq
	 * @param cityGroup
	 * @return
	 */
	public List<ShopApply> findByCityGroup(String cityGroup);
	
	/**
	 * 查找所有直营门店
	 * @return
	 */
	public List<ShopApply> findZhiYing();
}
