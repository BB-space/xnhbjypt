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
import com.sykj.app.dao.area.ProvinceDao;
import com.sykj.app.dao.area.ShopApplyDao;
import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.dao.user.UserInformationDao;
import com.sykj.app.dao.user.UserSubCenterDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.area.Province;
import com.sykj.app.entity.area.ShopApply;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.app.service.area.ShopApplyService;
import com.sykj.app.service.area.ShopService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.ObjectAttribute;

@Service("shopApplyService")
public class ShopApplyServiceImpl extends BaseServiceImpl implements ShopApplyService{

	@Resource
	private ShopApplyDao shopApplyDao;
	@Resource
	private CityDao cityDao;
	@Resource
	private ProvinceDao provinceDao;
	@Resource
	private UserInformationDao userInformationDao;
	@Resource
	private UserSubCenterDao userSubCenterDao;
	
	@Override
	public ShopApply addShop(ShopApply shop) {
		ShopApply s = new ShopApply();
		shop.setCreateDateTime(new Date());
		shop.setId(UUID.randomUUID().toString());
		BeanUtils.copyProperties(shop, s);
		return shopApplyDao.add(s);
	}
	
	@Override
	public ShopApply addShop(ShopApply shop,String shopid,String url,UserM userM) {
		url = url + "resources/img/shop/" + shopid + ".png";
		ShopApply s = new ShopApply();
		shop.setCreateDateTime(new Date());
		/*if(shop.getShopType() != null && shop.getShopType().equals("加盟")){
			shop.setId(shop.getId());
		}else{
			shop.setId(shopid);
		}*/
		shop.setCodeAddress(url);
		BeanUtils.copyProperties(shop, s);
		s.setId(UUID.randomUUID().toString());
		s.setPictures(userM.getId());
		UserInformation uf = userInformationDao.getUserInformationByUserId(userM.getId());
		s.setShortNumber(userM.getUserName());//加盟商手机
		s.setLocation(uf.getRealname());//加盟商姓名
		s.setShopType("加盟");
		s.setBelong("丝域");
		s.setStatus("0");
		return shopApplyDao.add(s);
	}

	@Override
	public void deleteShop(String ids) {
		for (String id : ids.split(",")) {
			ShopApply shop = shopApplyDao.getShop(id);
			if (shop != null) {
				shopApplyDao.deleteShop(id);
			}
		}
		
	}

	@Override
	public ShopApply editShop(ShopApply shop) {
		//System.out.println(shop.getShortNumber()+"***");
		ShopApply s = shopApplyDao.getShop(shop.getId());
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
		shopApplyDao.update(s);
		return s;
	}
	
	@Override
	public ShopApply editShopAudit(String shopId,String status) {
		ShopApply shopApply = shopApplyDao.getShop(shopId);
		shopApply.setStatus(status);
		shopApplyDao.update(shopApply);
		return shopApply;
	}
	

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, ShopApply shop,UserM userM) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		
		Pager<ShopApply> pShop = shopApplyDao.findShop(syct, shop,userM);
		List<ShopApply> shopList = new ArrayList<ShopApply>();
		List<ShopApply> sList = pShop.getDatas();
		if(sList!=null && sList.size()>0){
			for(ShopApply s : sList){
//				System.out.println("id:"+s.getId());
				if(s.getCityId()!=null){
					City c = cityDao.getCity(s.getCityId());
					if(c!=null){
						s.setCityName(c.getCityName());
					}
				}
				if(s.getProvinceId()!=null){
					Province p = provinceDao.getProvince(s.getProvinceId());
					if(p!=null){
						s.setProvinceName(p.getProvinceName());
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
	public List<ShopApply> getShopByCityId(String cityId) {
		return shopApplyDao.findShopByCityId(cityId);
	}

	@Override
	public List<ShopApply> getShopByCityId(String cityId, String status) {
		
		return shopApplyDao.findShopByCityId(cityId, status);
	}
	
	@Override
	public List<ShopApply> getShopBySrContent(String cityId, String rscontent) {
		
		return shopApplyDao.findShopBySrContent(cityId, rscontent);
	}
	
	@Override
	public List<ShopApply> getShopBySrContentType(String cityId, String rscontent,String shopType) {
		
		return shopApplyDao.findShopBySrContentType(cityId, rscontent,shopType);
	}
	
	@Override
	public List<ShopApply> getShopBySubcenterId(String subcenterId) {
		
		return shopApplyDao.findShopBySubcenterId(subcenterId);
	}


	@Override
	public List<ShopApply> findAllShop() {
		
		return shopApplyDao.findAllShop();
	}

	@Override
	public List<ShopApply> findShopByName(String shopName) {
		
		return shopApplyDao.findShopByName(shopName);
	}


	@Override
	public List<ShopApply> getAll() {
		
		return shopApplyDao.findShop();
	}

	//根据编号查询门店
	@Override
	public ShopApply getId(String id) {
		
		return shopApplyDao.getShop(id);
	}

	@Override
	public List<ShopApply> find(String shopName) {
		
		return shopApplyDao.find(shopName);
	}

	@Override
	public List<ShopApply> getReserForHeat(int rowNum) {
		List<ShopApply> list = shopApplyDao.getShopByHeat(rowNum);//获取排名前10条数据
		return list;
	}

	@Override
	public String createQRCode(String url,String id) {
		String content = shopApplyDao.createQRCode(url,id);
		return content;
	}

	@Override
	public List<ShopApply> getReserForCommit(int rowNum) {
		List<ShopApply> list = shopApplyDao.getShopByCommit(rowNum);//获取排名前10条数据
		return null;
	}

	@Override
	public List<ShopApply> getByCondition() {
		
		return shopApplyDao.getByCondition();
	}

	@Override
	public List<ShopApply> getTestAll() {
		
		return shopApplyDao.findTestShop();
	}

	@Override
	public ShopApply findShopByOpenId(String openId) {
		
		return shopApplyDao.findShopByOpenId(openId);
	}

	@Override
	public List<ShopApply> findShopRSByCityName(String cityName) {
		City c = cityDao.findCityByName(cityName);
		if(c != null){
			List<ShopApply> listS = shopApplyDao.findShopRSByCityId(c.getId(),10);
			return listS;
		}
		return null;
	}

	//编辑门店图集
	@Override
	public void updateShopPictures(ShopApply shop) {
		shopApplyDao.update(shop);
	}

	/**
	 * 0：表示成功
	 * 1：表示早班人数大于总门店人数
	 * 2：表示晚班人数大于宗门点人数
	 */
	@Override
	public Integer editShopMinEmp(ShopApply shop) {
		int empCount = userInformationDao.findEmpByShopId(shop.getId());
		if(shop.getMinimumEarlyWorking() > empCount){
			return 1;
		}
		if(shop.getMinimumNightWorking() > empCount){
			return 2;
		}
		shopApplyDao.update(shop);
		return 0;
	}

	@Override
	public List<ShopApply> getShopByCity(String openId, String cityId) {
		List<ShopApply> listS = new ArrayList<ShopApply>();
		//1.判断该openId是否有预约过
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			List<ShopApply> listRSZhuHai = shopApplyDao.getRSShopByCityId(info.getUserId(),cityId);
			if(listRSZhuHai.size()>0){//有预约
				//获取预约的所有shopIds
				String[] shopIds = new String[listRSZhuHai.size()];
				for(int i=0;i<listRSZhuHai.size();i++){
					listS.add(listRSZhuHai.get(i));
					shopIds[i] = listRSZhuHai.get(i).getId();
				}
				List<ShopApply> listShopZH = shopApplyDao.getShopByCityId(cityId,shopIds);
				for(ShopApply s : listShopZH){
					listS.add(s);
				}
			}else{//根据门店排序
				List<ShopApply> listShopZH = shopApplyDao.getShopByCityId(cityId,null);
				for(ShopApply s :listShopZH){
					listS.add(s);
				}
			}
		}else{
			List<ShopApply> listShopZH = shopApplyDao.getShopByCityId(cityId,null);
			for(ShopApply s :listShopZH){
				listS.add(s);
			}
		}
		return listS;
	}
	

	@Override
	public ShopApply getShopByNumber(String shopNumber) {
		
		return shopApplyDao.getShopByNumber(shopNumber);
	}

	@Override
	public List<ShopApply> addOrUpdateShop(List<ShopApply> shopList) {
		List<ShopApply> sl = new ArrayList<ShopApply>();
		for(ShopApply shop:shopList){
			ShopApply s = shopApplyDao.getShopByNumber(shop.getShopNumber());
			if(null==s){
				this.addShop(shop);
				sl.add(shop);
			}else{
				s.setShortName(shop.getShortName());
				shopApplyDao.update(s);
			}
		}
		return sl;
	}

	@Override
	public List<ShopApply> getShopByHZS(String openId,String[] cityStr) {
		List<ShopApply> listS = new ArrayList<ShopApply>();
		//1.判断该openId是否有预约过
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null){
			//查询该用户的预约
			List<ShopApply> listRSZhuHai = shopApplyDao.getRSShopByCityIds(info.getUserId(),cityStr);
			if(listRSZhuHai.size()>0){//有预约
				//获取预约的所有shopIds
				String[] shopIds = new String[listRSZhuHai.size()];
				for(int i=0;i<listRSZhuHai.size();i++){
					listS.add(listRSZhuHai.get(i));
					shopIds[i] = listRSZhuHai.get(i).getId();
				}
				List<ShopApply> listShopZH = shopApplyDao.getShopByCityIds(cityStr,shopIds);
				for(ShopApply s : listShopZH){
					listS.add(s);
				}
			}else{//根据门店排序
				List<ShopApply> listShopZH = shopApplyDao.getShopByCityIds(cityStr,null);
				for(ShopApply s :listShopZH){
					listS.add(s);
				}
			}
		}else{
			List<ShopApply> listShopZH = shopApplyDao.getShopByCityIds(cityStr,null);
			for(ShopApply s :listShopZH){
				listS.add(s);
			}
		}
		return listS;
	}

	@Override
	public List<ShopApply> getShopByCS(String openId) {
		//获得佛山门店
		City c = cityDao.findCityByName("佛山市");
		List<ShopApply> fsList = new ArrayList<ShopApply>();
		if(c != null){
			fsList = this.getShopByCity(openId,c.getId());
		}
		return fsList;
	}

	@Override
	public List<ShopApply> getZYShopByCityId(String cityId) {
		return shopApplyDao.findZYShopByCityId(cityId);
	}

	@Override
	public Boolean judgeEmployeeByShop(String openId) {
		UserInformation info = userInformationDao.getByOpenId(openId);
		if(info != null ){
			if(info.getShopId() != null){
				ShopApply s = shopApplyDao.get(ShopApply.class, info.getShopId());
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
	public List<ShopApply> findByCityGroup(String cityGroup) {
		
		return shopApplyDao.findByCityGroup(cityGroup);
	}

	//根据门店短编号查询
	@Override
	public ShopApply getByShortNumber(String shortNumber) {
		return shopApplyDao.getByShortNumber(shortNumber);
	}

	@Override
	public Boolean judgeScannerShop(String shopOpenId) {
		ShopApply s = shopApplyDao.findShopByOpenId(shopOpenId);
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
	public List<ShopApply> findZhiYing() {
		return shopApplyDao.findZhiYing();
	}

	@Override
	public List<EasyuiTreeNode> tree(String subcenterId) {
		List<ShopApply> shopList = shopApplyDao.findShopBySubcenterId(subcenterId);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (ShopApply shop : shopList) {
			tree.add(tree(shop, false));
		}
		return tree;
	}
	
	private EasyuiTreeNode tree(ShopApply shop, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(shop.getId());
		node.setText(shop.getShopName());
		Map<String, Object> attributes = new HashMap<String, Object>();
		node.setAttributes(attributes);
		return node;
	}

}
