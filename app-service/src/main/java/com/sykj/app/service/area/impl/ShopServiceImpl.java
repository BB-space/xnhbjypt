package com.sykj.app.service.area.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.area.CityDao;
import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.ShopService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.ObjectAttribute;

@Service("shopService")
public class ShopServiceImpl extends BaseServiceImpl implements ShopService{

	@Resource
	private ShopDao shopDao;
	@Resource
	private CityDao cityDao;
	@Resource
	private UserInformationDao userInformationDao;
	
	@Override
	public Shop addShop(Shop shop) {
		Shop s = new Shop();
		shop.setCreateDateTime(new Date());
		shop.setId(UUID.randomUUID().toString());
		BeanUtils.copyProperties(shop, s);
		return shopDao.add(s);
	}
	
	@Override
	public Shop addShop(Shop shop,String shopid,String url) {
		url = url + "resources/img/shop/" + shopid + ".png";
		Shop s = new Shop();
		shop.setCreateDateTime(new Date());
		if(shop.getShopType() != null && shop.getShopType().equals("加盟")){
			shop.setId(shop.getId());
		}else{
			shop.setId(shopid);
		}
		shop.setCodeAddress(url);
		BeanUtils.copyProperties(shop, s);
		return shopDao.add(s);
	}

	@Override
	public void deleteShop(String ids) {
		for (String id : ids.split(",")) {
			Shop shop = shopDao.getShop(id);
			if (shop != null) {
				shopDao.deleteShop(id);
			}
		}
		
	}

	@Override
	public Shop editShop(Shop shop) {
		//System.out.println(shop.getShortNumber()+"***");
		Shop s = shopDao.getShop(shop.getId());
		if(shop.getCityId()!=null && !shop.getCityId().equals("")){
			s.setCityId(shop.getCityId());
		}else{
			if(s.getCityId()!=null){
				shop.setCityId(s.getCityId());
			}
		}
		if(shop.getSubcenterId()!=null && !shop.getSubcenterId().equals("")){
			s.setSubcenterId(shop.getSubcenterId());
		}else{
			if(s.getSubcenterId()!=null){
				shop.setSubcenterId(s.getSubcenterId());
			}
		}
		if(shop.getIsReserve() != null && !shop.getIsReserve().equals("")){
			s.setIsReserve(shop.getIsReserve());
		}else{
			if(s.getIsReserve()!=null){
				shop.setIsReserve(s.getIsReserve());
			}
		}
		BeanUtils.copyProperties(shop, s);
		//System.out.println(s.getShortNumber());
		shopDao.update(s);
		return s;
	}

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, Shop shop) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		Pager<Shop> pShop = shopDao.findShop(syct, shop);
		List<Shop> shopList = new ArrayList<Shop>();
		List<Shop> sList = pShop.getDatas();
		if(sList!=null && sList.size()>0){
			for(Shop s : sList){
//				System.out.println("id:"+s.getId());
				if(s.getCityId()!=null){
					City c = cityDao.getCity(s.getCityId());
					if(c!=null){
						s.setCityName(c.getCityName());
					}
				}
				shopList.add(s);
			}
		}
		j.setRows(shopList);
//		j.setRows(pShop.getDatas());
		j.setTotal(pShop.getTotalCount());
		return j;
	}

	@Override
	public List<Shop> getShopByCityId(String cityId) {
		return shopDao.findShopByCityId(cityId);
	}

	@Override
	public List<Shop> getShopByCityId(String cityId, String status) {
		
		return shopDao.findShopByCityId(cityId, status);
	}
	
	@Override
	public List<Shop> getShopBySrContent(String cityId, String rscontent) {
		
		return shopDao.findShopBySrContent(cityId, rscontent);
	}
	
	@Override
	public List<Shop> getShopBySrContentType(String cityId, String rscontent,String shopType) {
		
		return shopDao.findShopBySrContentType(cityId, rscontent,shopType);
	}
	
	@Override
	public List<Shop> getShopBySubcenterId(String subcenterId) {
		
		return shopDao.findShopBySubcenterId(subcenterId);
	}


	@Override
	public List<Shop> findAllShop() {
		
		return shopDao.findAllShop();
	}

	@Override
	public List<Shop> findShopByName(String shopName) {
		
		return shopDao.findShopByName(shopName);
	}


	@Override
	public List<Shop> getAll() {
		
		return shopDao.findShop();
	}

	//根据编号查询门店
	@Override
	public Shop getId(String id) {
		
		return shopDao.getShop(id);
	}

	@Override
	public List<Shop> find(String shopName) {
		
		return shopDao.find(shopName);
	}

	@Override
	public List<Shop> getReserForHeat(int rowNum) {
		List<Shop> list = shopDao.getShopByHeat(rowNum);//获取排名前10条数据
		return list;
	}

	@Override
	public String createQRCode(String url,String id) {
		String content = shopDao.createQRCode(url,id);
		return content;
	}

	@Override
	public List<Shop> getReserForCommit(int rowNum) {
		List<Shop> list = shopDao.getShopByCommit(rowNum);//获取排名前10条数据
		return null;
	}

	@Override
	public List<Shop> getByCondition() {
		
		return shopDao.getByCondition();
	}

	@Override
	public List<Shop> getTestAll() {
		
		return shopDao.findTestShop();
	}

	@Override
	public Shop findShopByOpenId(String openId) {
		
		return shopDao.findShopByOpenId(openId);
	}

	@Override
	public List<Shop> findShopRSByCityName(String cityName) {
		City c = cityDao.findCityByName(cityName);
		if(c != null){
			List<Shop> listS = shopDao.findShopRSByCityId(c.getId(),10);
			return listS;
		}
		return null;
	}

	//编辑门店图集
	@Override
	public void updateShopPictures(Shop shop) {
		shopDao.update(shop);
	}

	/**
	 * 0：表示成功
	 * 1：表示早班人数大于总门店人数
	 * 2：表示晚班人数大于宗门点人数
	 */
	@Override
	public Integer editShopMinEmp(Shop shop) {
		int empCount = userInformationDao.findEmpByShopId(shop.getId());
		if(shop.getMinimumEarlyWorking() > empCount){
			return 1;
		}
		if(shop.getMinimumNightWorking() > empCount){
			return 2;
		}
		shopDao.update(shop);
		return 0;
	}

	@Override
	public List<Shop> getShopByCity(String openId, String cityId) {
		List<Shop> listS = new ArrayList<Shop>();
		//1.判断该openId是否有预约过
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			List<Shop> listRSZhuHai = shopDao.getRSShopByCityId(info.getUserId(),cityId);
			if(listRSZhuHai.size()>0){//有预约
				//获取预约的所有shopIds
				String[] shopIds = new String[listRSZhuHai.size()];
				for(int i=0;i<listRSZhuHai.size();i++){
					listS.add(listRSZhuHai.get(i));
					shopIds[i] = listRSZhuHai.get(i).getId();
				}
				List<Shop> listShopZH = shopDao.getShopByCityId(cityId,shopIds);
				for(Shop s : listShopZH){
					listS.add(s);
				}
			}else{//根据门店排序
				List<Shop> listShopZH = shopDao.getShopByCityId(cityId,null);
				for(Shop s :listShopZH){
					listS.add(s);
				}
			}
		}else{
			List<Shop> listShopZH = shopDao.getShopByCityId(cityId,null);
			for(Shop s :listShopZH){
				listS.add(s);
			}
		}
		return listS;
	}
	

	@Override
	public Shop getShopByNumber(String shopNumber) {
		
		return shopDao.getShopByNumber(shopNumber);
	}

	@Override
	public List<Shop> addOrUpdateShop(List<Shop> shopList) {
		List<Shop> sl = new ArrayList<Shop>();
		for(Shop shop:shopList){
			Shop s = shopDao.getShopByNumber(shop.getShopNumber());
			if(null==s){
				this.addShop(shop);
				sl.add(shop);
			}else{
				s.setShortName(shop.getShortName());
				shopDao.update(s);
			}
		}
		return sl;
	}

	@Override
	public List<Shop> getShopByHZS(String openId,String[] cityStr) {
		List<Shop> listS = new ArrayList<Shop>();
		//1.判断该openId是否有预约过
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			//查询该用户的预约
			List<Shop> listRSZhuHai = shopDao.getRSShopByCityIds(info.getUserId(),cityStr);
			if(listRSZhuHai.size()>0){//有预约
				//获取预约的所有shopIds
				String[] shopIds = new String[listRSZhuHai.size()];
				for(int i=0;i<listRSZhuHai.size();i++){
					listS.add(listRSZhuHai.get(i));
					shopIds[i] = listRSZhuHai.get(i).getId();
				}
				List<Shop> listShopZH = shopDao.getShopByCityIds(cityStr,shopIds);
				for(Shop s : listShopZH){
					listS.add(s);
				}
			}else{//根据门店排序
				List<Shop> listShopZH = shopDao.getShopByCityIds(cityStr,null);
				for(Shop s :listShopZH){
					listS.add(s);
				}
			}
		}else{
			List<Shop> listShopZH = shopDao.getShopByCityIds(cityStr,null);
			for(Shop s :listShopZH){
				listS.add(s);
			}
		}
		return listS;
	}

	@Override
	public List<Shop> getShopByCS(String openId) {
		//获得佛山门店
		City c = cityDao.findCityByName("佛山市");
		List<Shop> fsList = new ArrayList<Shop>();
		if(c != null){
			fsList = this.getShopByCity(openId,c.getId());
		}
		return fsList;
	}

	@Override
	public List<Shop> getZYShopByCityId(String cityId) {
		return shopDao.findZYShopByCityId(cityId);
	}

	@Override
	public Boolean judgeEmployeeByShop(String openId) {
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null ){
			if(info.getShopId() != null){
				Shop s = shopDao.get(Shop.class, info.getShopId());
				if(s != null){
					City c = cityDao.getCity(s.getCityId());
					if(c != null){
						if(c.getCityGroup().equals("zzf") && s.getShopType().equals("直营") && s.getBelong().equals("丝域")){
							return true;
						}
					}
				}
			}
			
		}
		return false;
	}

	//查询此区域下的门店 zq
	@Override
	public List<Shop> findByCityGroup(String cityGroup) {
		
		return shopDao.findByCityGroup(cityGroup);
	}

	//根据门店短编号查询
	@Override
	public Shop getByShortNumber(String shortNumber) {
		return shopDao.getByShortNumber(shortNumber);
	}

	@Override
	public Boolean judgeScannerShop(String shopOpenId) {
		Shop s = shopDao.findShopByOpenId(shopOpenId);
		if(s != null){
			if(s.getShopType().equals("直营")){
				City c = cityDao.getCity(s.getCityId());
				if(c != null){
					if(c.getCityGroup().equals("gz") || c.getCityGroup().equals("sh") 
							|| c.getCityGroup().equals("zzf")){
						return true;
					}
				}
			}
		}
		return false;
	}

	@Override
	public List<Shop> findZhiYing() {
		return shopDao.findZhiYing();
	}

	@Override
	public List<EasyuiTreeNode> tree(String subcenterId) {
		List<Shop> shopList = shopDao.findShopBySubcenterId(subcenterId);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (Shop shop : shopList) {
			tree.add(tree(shop, false));
		}
		return tree;
	}
	
	private EasyuiTreeNode tree(Shop shop, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(shop.getId());
		node.setText(shop.getShopName());
		Map<String, Object> attributes = new HashMap<String, Object>();
		node.setAttributes(attributes);
		return node;
	}
}
