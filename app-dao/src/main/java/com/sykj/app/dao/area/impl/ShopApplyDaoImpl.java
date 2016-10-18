package com.sykj.app.dao.area.impl;

import java.util.List;
import java.util.UUID;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sykj.app.dao.area.ShopApplyDao;
import com.sykj.app.dao.area.ShopDao;
import com.sykj.app.dao.user.UserSubCenterDao;
import com.sykj.app.entity.area.ShopApply;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.entity.user.UserInformation;
import com.sykj.app.entity.user.UserSubCenter;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.model.UserM;
import com.sykj.app.util.ConfigUtil;
import com.sykj.app.util.QRCodeUtil;
import com.sykj.common.dao.BaseDao;

@Repository("shopApplyDao")
public class ShopApplyDaoImpl extends BaseDao<ShopApply> implements ShopApplyDao {

	@Autowired
	private UserSubCenterDao userSubCenterDao;
	
	@Autowired
	private ShopDao shopDao;
	
	@Override
	public ShopApply getShop(String id) {
		
		return this.get(ShopApply.class, id);
	}

	@Override
	public void deleteShop(String id) {
		this.delete(this.getShop(id));
		
	}

	@Override
	public Pager<ShopApply> findShop(SystemContext syct, ShopApply Shop,UserM userM) {
		StringBuffer hql = new StringBuffer("from ShopApply t where 1=1");
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
			if(Shop.getStatus() !=null && !Shop.getStatus().trim().equals("")){
				hql.append(" and t.status ='"+Shop.getStatus()+"'");
			}
		}
		if(userM!=null){
			if(userM.getUserType().equals("13")||userM.getUserType().equals("11")){
				hql.append(" and t.pictures in('"+userM.getId()+"') ");
			}else if(!userM.getUserType().equals("0")&&!userM.getUserType().equals("5")
					&&!userM.getUserType().equals("8")&&!userM.getUserType().equals("7")
					&&!userM.getUserType().equals("12")){
				hql.append(" and t.pictures='admin'");//非管理员身份清空结果集
			}
		}
		hql.append(" order by t.status,createDatetime desc");
		return this.find(hql.toString(),syct);
	}

	@Override
	public List<ShopApply> findShopByCityId(String cityId) {
		
		return this.list("from ShopApply t where t.cityId='"+cityId+"'  ORDER BY t.shopNumber");
	}

	@Override
	public List<ShopApply> findShopByCityId(String cityId, String status) {

		return this.list("from ShopApply t where t.cityId='"+cityId+"' and t.status='"+status+"' order by t.seq");
	}
	
	@Override
	public List<ShopApply> findShopBySrContent(String cityId, String rscontent) {

		return this.list("from ShopApply t where t.cityId='"+cityId+"' and t.shopName like '%"+rscontent+"%' order by t.seq desc");
	}
	
	@Override
	public List<ShopApply> findShopBySrContentType(String cityId, String rscontent,String shopType) {
		
		return this.list("from ShopAppy t where t.cityId='"+cityId+"' and t.shopName like '%"+rscontent+"%' and t.shopType='"+shopType+"' order by t.seq desc");
	}

	@Override
	public List<ShopApply> findShopBySubcenterId(String subcenterId) {
		
		return this.list("from ShopApply t where t.subcenterId='"+subcenterId+"'");
	}


	@Override
	public List<ShopApply> findAllShop() {
		
		return this.list("from ShopApply where 1=1");
	}

	@Override
	public List<ShopApply> findShopByName(String shopName) {
		
		return this.list("from ShopApply s where s.shopName like '%%"+shopName+"%%'");
	}


	@Override
	public List<ShopApply> findShop() {
		String hql = "from ShopApply t ";
		return this.list(hql);
	}

	@Override
	public List<ShopApply> find(String shopName) {
		StringBuffer hql = new StringBuffer("from ShopApply t where 1=1");
		if (shopName != null && !shopName.trim().equals("")) {
			hql.append(" and t.shopName like '%%").append(shopName.trim()).append("%%' ");
		}
		return this.list(hql.toString());
	}

	@Override
	public List<ShopApply> getShopByHeat(int rowNum) {
		StringBuffer sbf = new StringBuffer("select * from SYKJ_AREA_SHOPApply s where s.id in ");
		sbf.append("( select shopid from ");
		sbf.append("( select count(*) num,shopid from sykj_user_UserReservation group by shopid order by num desc) ");
		sbf.append("where rownum<").append(10).append(")");
		String sql = sbf.toString();
		return this.listBySql(sql,ShopApply.class, true);
	}

	@Override
	public List<ShopApply> getShopByCommit(int rowNum) {
		StringBuffer sbf = new StringBuffer("select * from SYKJ_AREA_SHOP s where s.id in ");
		sbf.append("( select shopid from ");
		sbf.append("( select count(*) num,shopid from SYKJ_MALL_COMMENT_RECORD r,sykj_user_UserReservation u where r.goodsid=u.productid group by u.shopid order by num desc) ");
		sbf.append("where rownum<").append(10).append(")");
		String sql = sbf.toString();
		return this.listBySql(sql,ShopApply.class, true);
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
	public List<ShopApply> getByCondition() {
		String sql="select * from sykj_area_shopApply where to_char(createdatetime,'yyyy-mm-dd')>='2015-08-18' ";
		SQLQuery query=getSession().createSQLQuery(sql).addEntity(ShopApply.class);
		List<ShopApply> list=query.list();
		return list;
	}

	@Override
	public List<ShopApply> findTestShop() {
		
		return this.list("from ShopApply s where s.shopName like '%测试%'");
	}

	@Override
	public ShopApply findShopByOpenId(String openId) {
		String hql = "from Shop s where s.id=(select u.shopId from UserInformation u where u.openId='"+openId+"')";
		return this.get(hql);
	}

	@Override
	public List<ShopApply> findShopRSByCityId(String cityId, int number) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shopApply s ");
		sbf.append("where s.cityid='").append(cityId).append("' ");
		sbf.append("and s.id in ( select shopid from( ");
		sbf.append("select u.shopid,count(u.shopid) num from sykj_user_UserReservation u group by u.shopid order by num desc ");
		sbf.append(") where rownum<=").append(number).append(" ) ");
		
		String sql = sbf.toString();
		return this.listBySql(sql, ShopApply.class, true);
	}

	@Override
	public List<ShopApply> getRSShopByCityId(String userId, String cityId) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shopApply s ");
		sbf.append("where s.id in (select a.shopid from ");
		sbf.append("(select u.shopid,count(u.shopid) num from sykj_user_userreservation u ")
		    .append("where u.userid='").append(userId).append("' group by u.shopid ")
		    .append(" order by num desc ")
		    .append(")a ");
		sbf.append(") and s.cityid ='").append(cityId).append("'");
		
		String sql = sbf.toString();
		return this.listBySql(sql, ShopApply.class, true);
	}
	
	@Override
	public List<ShopApply> getRSShopByCityIds(String userId,String[] cityStr) {
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
		return this.listBySql(sql, ShopApply.class, true);
	}

	@Override
	public List<ShopApply> getShopByCityId(String cityId, String[] shopIds) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shopapply s where ");
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
		return this.listBySql(sql, ShopApply.class, true);
	}
	@Override
	public List<ShopApply> getShopByCityIds(String[] cityStr, String[] shopIds) {
		StringBuffer sbf = new StringBuffer("select * from sykj_area_shopapply s where ");
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
		return this.listBySql(sql, ShopApply.class, true);
	}


	@Override
	public ShopApply getShopByNumber(String shopNumber) {
		String hql = "from ShopApply s where s.shopNumber='"+shopNumber+"'";
		return this.get(hql);
	}
	
	//根据门店短编码查询
	@Override
	public ShopApply getByShortNumber(String shortNumber) {
		String hql = "from ShopApply s where s.shortNumber='"+shortNumber+"'";
		return this.get(hql);
	}

	@Override
	public List<ShopApply> findZYShopByCityId(String cityId) {
		String hql = "from ShopApply s where s.shopType='直营' and cityId='"+cityId+"' order by s.seq desc ";
		return this.list(hql);
	}

	@Override
	public List<Object> findShopInfoByCityGroup(String cityGroup) {
		String sql = "select t.shortNumber,t2.cityGroup from sykj_area_shopapply t inner join sykj_area_city t2"
				+ " on t.cityId =t2.id where t.shortNumber is not null and t.shortNumber!=''"
				+ " and t2.cityGroup in "+cityGroup;
		return this.findSQL(sql);
	}

	@Override
	public List<ShopApply> findZhuZhongFo(String belong,String shopType) {
		String hql = "from ShopApply s where s.belong='"+belong+"' and s.shopType='"+shopType+"' "
				   + "and s.cityId in (select id from City where cityName in ('珠海市','中山市','佛山市'))";
		return this.list(hql);
	}

	//查询此区域下的门店 zq
	@Override
	public List<ShopApply> findByCityGroup(String cityGroup) {
		String hql=" from ShopApply s where s.cityId in (select t.id from City t where t.cityGroup='"+cityGroup+"')"
				+" and s.shortNumber is not null and s.shortNumber !='' and (s.shopType='直营' or s.isReserve='1')";	
		return  this.list(hql);
	}

	@Override
	public List<ShopApply> findZhiYing() {
		String hql = "from ShopApply s where s.shopType='直营' and s.shortNumber != '' and s.shortNumber is not null";
		return this.list(hql);
	}

}
