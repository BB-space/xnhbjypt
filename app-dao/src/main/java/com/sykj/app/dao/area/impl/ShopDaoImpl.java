package com.sykj.app.dao.area.impl;

import java.util.List;
import java.util.UUID;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.entity.area.Shop;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.util.ConfigUtil;
import com.sykj.app.util.QRCodeUtil;
import com.sykj.common.dao.BaseDao;

@Repository("shopDao")
public class ShopDaoImpl extends BaseDao<Shop> implements ShopDao {

	@Override
	public Shop getShop(String id) {
		
		return this.get(Shop.class, id);
	}

	@Override
	public void deleteShop(String id) {
		this.delete(this.getShop(id));
		
	}

	@Override
	public Pager<Shop> findShop(SystemContext syct, Shop Shop) {
		StringBuffer hql = new StringBuffer("from Shop t where 1=1");
		if(Shop !=null){// 添加查询条件
			if (Shop.getShopName() != null && !Shop.getShopName().trim().equals("")) {
				hql.append(" and t.shopName like '%%").append(Shop.getShopName().trim()).append("%%' ");
			}
			if (Shop.getShopType() != null && !Shop.getShopType().trim().equals("")) {
				hql.append(" and t.shopType like '%%").append(Shop.getShopType().trim()).append("%%' ");
			}
			if(Shop.getCityName()!= null && !Shop.getCityName().trim().equals("")) {
				hql.append(" and t.cityId in (select id from City where cityName like '%")
				   .append(Shop.getCityName().trim()).append("%')");
			}
		}
		return this.find(hql.toString(),syct);
	}

	@Override
	public List<Shop> findShopByCityId(String cityId) {
		
		return this.list("from Shop t where t.cityId='"+cityId+"'  ORDER BY t.shopNumber");
	}

	@Override
	public List<Shop> findShopByCityId(String cityId, String status) {

		return this.list("from Shop t where t.cityId='"+cityId+"' and t.status='"+status+"' order by t.seq");
	}
	
	@Override
	public List<Shop> findShopBySrContent(String cityId, String rscontent) {

		return this.list("from Shop t where t.cityId='"+cityId+"' and t.shopName like '%"+rscontent+"%' order by t.seq desc");
	}
	
	@Override
	public List<Shop> findShopBySrContentType(String cityId, String rscontent,String shopType) {
		
		return this.list("from Shop t where t.cityId='"+cityId+"' and t.shopName like '%"+rscontent+"%' and t.shopType='"+shopType+"' order by t.seq desc");
	}

	@Override
	public List<Shop> findShopBySubcenterId(String subcenterId) {
		
		return this.list("from Shop t where t.subcenterId='"+subcenterId+"'");
	}


	@Override
	public List<Shop> findAllShop() {
		
		return this.list("from Shop where 1=1");
	}

	@Override
	public List<Shop> findShopByName(String shopName) {
		
		return this.list("from Shop s where s.shopName like '%%"+shopName+"%%'");
	}


	@Override
	public List<Shop> findShop() {
		String hql = "from Shop t ";
		return this.list(hql);
	}

	@Override
	public List<Shop> find(String shopName) {
		StringBuffer hql = new StringBuffer("from Shop t where 1=1");
		if (shopName != null && !shopName.trim().equals("")) {
			hql.append(" and t.shopName like '%%").append(shopName.trim()).append("%%' ");
		}
		return this.list(hql.toString());
	}

	@Override
	public List<Shop> getShopByHeat(int rowNum) {
		StringBuffer sbf = new StringBuffer("select * from SYKJ_AREA_SHOP s where s.id in ");
		sbf.append("( select shopid from ");
		sbf.append("( select count(*) num,shopid from sykj_user_UserReservation group by shopid order by num desc) ");
		sbf.append("where rownum<").append(10).append(")");
		String sql = sbf.toString();
		return this.listBySql(sql,Shop.class, true);
	}

	@Override
	public List<Shop> getShopByCommit(int rowNum) {
		StringBuffer sbf = new StringBuffer("select * from SYKJ_AREA_SHOP s where s.id in ");
		sbf.append("( select shopid from ");
		sbf.append("( select count(*) num,shopid from SYKJ_MALL_COMMENT_RECORD r,sykj_user_UserReservation u where r.goodsid=u.productid group by u.shopid order by num desc) ");
		sbf.append("where rownum<").append(10).append(")");
		String sql = sbf.toString();
		return this.listBySql(sql,Shop.class, true);
	}

	@Override
	public String createQRCode(String url,String id) {
		String shopid = null;
		if(id != null && !"".equals(id) ) {
			shopid = id;
		} else {
			shopid = UUID.randomUUID().toString();
		}
		String urls = url + "resources/img/shop/" + shopid + ".png";
		/*String url = getClass().getResource("/").toString();
		url = url.substring(6, url.lastIndexOf("/"));
		url = url.substring(0,url.lastIndexOf("/")).substring(0,url.lastIndexOf("/"));
		url = url.substring(0,url.lastIndexOf("/"));
		url = url + "/resources/img/shop/"+content+".png";
		System.out.println(url);*/
		String picture="/resources/upload/goodsPicture/logo.png";
		String uploadDirs=url+picture;
		String content = ConfigUtil.DOMAIN_URL+"/wx/wxSkip.do?toFocusOn&state="+shopid;
		try {
			QRCodeUtil.encode(content, uploadDirs, urls, true);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return shopid;
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Shop> getByCondition() {
		String sql="select * from sykj_area_shop where to_char(createdatetime,'yyyy-mm-dd')>='2015-08-18' ";
		SQLQuery query=getSession().createSQLQuery(sql).addEntity(Shop.class);
		List<Shop> list=query.list();
		return list;
	}

	@Override
	public List<Shop> findTestShop() {
		
		return this.list("from Shop s where s.shopName like '%测试%'");
	}

	@Override
	public Shop findShopByOpenId(String openId) {
		String hql = "from Shop s where s.id=(select u.shopId from UserInformation u where u.openId='"+openId+"')";
		return this.get(hql);
	}

	@Override
	public List<Shop> findShopRSByCityId(String cityId, int number) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shop s ");
		sbf.append("where s.cityid='").append(cityId).append("' ");
		sbf.append("and s.id in ( select shopid from( ");
		sbf.append("select u.shopid,count(u.shopid) num from sykj_user_UserReservation u group by u.shopid order by num desc ");
		sbf.append(") where rownum<=").append(number).append(" ) ");
		
		String sql = sbf.toString();
		return this.listBySql(sql, Shop.class, true);
	}

	@Override
	public List<Shop> getRSShopByCityId(String userId, String cityId) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shop s ");
		sbf.append("where s.id in (select a.shopid from ");
		sbf.append("(select u.shopid,count(u.shopid) num from sykj_user_userreservation u ")
		    .append("where u.userid='").append(userId).append("' group by u.shopid ")
		    .append(" order by num desc ")
		    .append(")a ");
		sbf.append(") and s.cityid ='").append(cityId).append("'");
		
		String sql = sbf.toString();
		return this.listBySql(sql, Shop.class, true);
	}
	
	@Override
	public List<Shop> getRSShopByCityIds(String userId,String[] cityStr) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shop s ");
		sbf.append("where s.id in (select a.shopid from ");
		sbf.append("(select u.shopid,count(u.shopid) num from sykj_user_userreservation u ")
		    .append("where u.userid='").append(userId).append("' group by u.shopid ")
		    .append(" order by num desc ")
		    .append(")a ");
		sbf.append(") and ");
		if(cityStr !=null){
			sbf.append("s.cityId in(");
			for(int i=0;i<cityStr.length;i++){
				if(i<cityStr.length-1){
					sbf.append("'").append(cityStr[i]).append("'").append(",");
				}else{
					sbf.append("'").append(cityStr[i]).append("'");
				}
			}
			sbf.append(" ) ");
		}
//		sbf.append("order by s.seq desc");
		
		String sql = sbf.toString();
		return this.listBySql(sql, Shop.class, true);
	}

	@Override
	public List<Shop> getShopByCityId(String cityId, String[] shopIds) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shop s where ");
		if(shopIds != null){
			sbf.append("s.id not in(");
			for(int i=0;i<shopIds.length;i++){
				if(i<shopIds.length-1){
					sbf.append("'").append(shopIds[i]).append("'").append(",");
				}else{
					sbf.append("'").append(shopIds[i]).append("'");
				}
			}
			sbf.append(" ) and ");
		}
		sbf.append("s.cityid='").append(cityId).append("' and s.shopType='直营' order by s.seq desc");
		
		String sql = sbf.toString();
		return this.listBySql(sql, Shop.class, true);
	}
	@Override
	public List<Shop> getShopByCityIds(String[] cityStr, String[] shopIds) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shop s where ");
		if(shopIds != null){
			sbf.append("s.id not in(");
			for(int i=0;i<shopIds.length;i++){
				if(i<shopIds.length-1){
					sbf.append("'").append(shopIds[i]).append("'").append(",");
				}else{
					sbf.append("'").append(shopIds[i]).append("'");
				}
			}
			sbf.append(" ) and ");
		}
		if(cityStr != null){
			sbf.append("s.cityId in(");
			for(int i=0;i<cityStr.length;i++){
				if(i<cityStr.length-1){
					sbf.append("'").append(cityStr[i]).append("'").append(",");
				}else{
					sbf.append("'").append(cityStr[i]).append("'");
				}
			}
			sbf.append(" ) and ");
		}
//		sbf.append("s.cityid='").append(cityId).append("' ");
		sbf.append("s.shopType='直营' order by s.seq desc");
		
		String sql = sbf.toString();
		return this.listBySql(sql, Shop.class, true);
	}


	@Override
	public Shop getShopByNumber(String shopNumber) {
		String hql = "from Shop s where s.shopNumber='"+shopNumber+"'";
		return this.get(hql);
	}
	
	//根据门店短编码查询
	@Override
	public Shop getByShortNumber(String shortNumber) {
		String hql = "from Shop s where s.shortNumber='"+shortNumber+"'";
		return this.get(hql);
	}

	@Override
	public List<Shop> findZYShopByCityId(String cityId) {
		String hql = "from Shop s where s.shopType='直营' and cityId='"+cityId+"' order by s.seq desc ";
		return this.list(hql);
	}

	@Override
	public List<Object> findShopInfoByCityGroup(String cityGroup) {
		String sql = "select t.shortNumber,t2.cityGroup from sykj_area_shop t inner join sykj_area_city t2"
				+ " on t.cityId =t2.id where t.shortNumber is not null and t.shortNumber!=''"
				+ " and t2.cityGroup in "+cityGroup;
		return this.findSQL(sql);
	}

	@Override
	public List<Shop> findZhuZhongFo(String belong,String shopType) {
		String hql = "from Shop s where s.belong='"+belong+"' and s.shopType='"+shopType+"' "
				   + "and s.cityId in (select id from City where cityName in ('珠海市','中山市','佛山市'))";
		return this.list(hql);
	}

	//查询此区域下的门店 zq
	@Override
	public List<Shop> findByCityGroup(String cityGroup) {
		String hql=" from Shop s where s.cityId in (select t.id from City t where t.cityGroup='"+cityGroup+"')"
				+" and s.shortNumber is not null and s.shortNumber !='' and (s.shopType='直营' or s.isReserve='1')";	
		return  this.list(hql);
	}

	@Override
	public List<Shop> findZhiYing() {
		String hql = "from Shop s where s.shopType='直营' and s.shortNumber != '' and s.shortNumber is not null";
		return this.list(hql);
	}

}
