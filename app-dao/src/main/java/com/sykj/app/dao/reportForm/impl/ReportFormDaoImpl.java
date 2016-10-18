package com.sykj.app.dao.reportForm.impl;

import java.util.List;
import java.util.UUID;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.sykj.app.dao.reportForm.ReportFormDao;

import com.sykj.app.model.reportForm.ReportFormM;
import com.sykj.common.dao.BaseDao;

@Repository("writeOffRecordDao")
public class ReportFormDaoImpl extends BaseDao<ReportFormM> implements ReportFormDao{

	@Override
	public List<Object> exportTenAndEighteen(String date,String type,int fromNo,int size) {
		String sql = "";
		if("ten".equals(type) || type == "ten") {
			sql = "select if(t1.openid is null,'',t1.openid) openId,"
					+ "if(t3.mobile is null,'',t3.mobile) mobile,"
					+ "if(t1.num1 is null,0,t1.num1) num1,"
					+ "if(t2.num2 is null,0,t2.num2) num2,'10元券' as cardType from ("
					+ "(select ga.openId openid,count(openid) num1 "
					+ "from sykj_award_getaward ga where ga.awardId = '1' "
					+ "and ga.createDateTime < ('"+date+"') group by openId) t1 "
					+ "left join "
					+ "(select ga.openid openid,if(count(openid) is null,0,count(openid)) num2,ga.shopId "
					+ "from sykj_award_getaward ga where awardId = '1' "
					+ "and ga.userTime < ('"+date+"') and status = '1' "
					+ "and shopid not in ('0646e9c9-a339-447d-a6d5-72c835a62072','4d2ca5e8-7d69-473a-96f3-474c1d9094a7') "
					+ "group by openId) t2 on t1.openid = t2.openid "
					+ "left join "
					+ "(select u.openid openid,u.mobile mobile "
					+ "from sykj_user_userinformation u ) t3 on t1.openid = t3.openid "
					+ ") where t1.openid is not null  order by num2 desc,num1 desc";
		}else {
			sql = "select if(t1.openId is null,'',t1.openId) openId,"
					+ "if(t3.mobile is null,'',t3.mobile) mobile,"
					+ "if(t1.num1 > 5 , 5 , t1.num1) num1,"
					+ "if(t2.num2 >= 1,1,0) num2,'18元券' as cardType from ("
					+ "(select m.openId openId,COUNT(m.openid) num1 from sykj_coupon_washhair_membercoupon m "
					+ "where m.openId is not null and m.OBTAINTIME < ('"+date+"') group by m.openId) t1 "
					+ "left join "
					+ "(select r.openid openId,count(r.openid) num2 from sykj_coupon_washhair_record r "
					+ "where r.openid is not null and r.EXPERIENCETIME < ('"+date+"') group by r.openid) t2 on t1.openId = t2.openId "
					+ "left join "
					+ "(select u.openid openid,u.mobile mobile from sykj_user_userinformation u ) t3 on t1.openid = t3.openid "
					+ ") order by num2 desc,num1 desc";
		}
		if(fromNo != 0 || size != 0) {
			sql = sql + " limit " + fromNo + ", " + size;
		}
		return this.findSQL(sql);
	}

	@Override
	public List<Object> exportShopTen(int fromNo,int size) {
		String sql = "select if(DATE_FORMAT(ga.usertime, '%Y-%m-%d') is null,'',DATE_FORMAT(ga.usertime, '%Y-%m-%d')),"
				+ "if(s.shopname is null,'',s.shopname),"
				+ "if(ui.realname is null,'',ui.realname),"
				+ "if(count(*) is null,0,count(*)) "
				+ "from sykj_award_getaward ga "
				+ "left join sykj_area_shop s on ga.shopid = s.id "
				+ "left join sykj_user_userinformation ui on ga.shopopenid = ui.openid "
				+ "where ga.status = 1 and s.shopname not in ('例子1121','丝荟测试门店') "
				+ "group by DATE_FORMAT(ga.usertime, '%Y-%m-%d'),ga.shopopenid "
				+ "order by DATE_FORMAT(ga.usertime, '%Y-%m-%d') desc,s.shopname desc,count(*) desc";
		if(fromNo != 0 || size != 0) {
			sql = sql + " limit " + fromNo + ", " + size;
		}
		return this.findSQL(sql);
	}

	@Override
	public List<Object> exportFriend(String date,int fromNo,int size) {
		String sql = "select if(t1.openId is null,'',t1.openId) openid,"
				+ "if(t3.mobile is null,'',t3.mobile) mobile,"
				+ "if(t1.num1 is null,'0',t1.num1) num1,"
				+ "if(t2.num2 is null,'0',t2.num2) num2,"
				+ "(if(t4.num3 is null,'0',t4.num3)+ if(t5.num4 is null,'0',t5.num4)) num3,"
				+ "if(t5.num4 is null,'0',t5.num4) num4 from ("
				+ "(select uci.openid openid,count(uci.openid) num1 "
				+ "from sykj_savings_usercarditem uci where uci.itemid = 'f9aed2e7-9f1e-4dd4-85a2-123456790' "
				+ "and uci.createtime < '"+date+"' group by uci.OPENID ) t1 "
				+ "left join "
				+ "(select i.fromopenid fromopenid,count(i.fromopenid) num2 "
				+ "from sykj_savings_itemgive i where i.itemid = 'f9aed2e7-9f1e-4dd4-85a2-123456790' "
				+ "and senddatetime < '"+date+"' group by i.fromopenid) t2 on t2.fromopenid = t1.openid "
				+ "left join "
				+ "(select u.openid openid,u.mobile mobile from sykj_user_userinformation u) t3 on t3.openid = t1.openid "
				+ "left join "
				+ "(select i.fromopenid fromopenid,count(i.fromopenid) num3 "
				+ "from sykj_savings_itemgive i where i.itemid = 'f9aed2e7-9f1e-4dd4-85a2-123456790' "
				+ "and updatedatetime < '"+date+"' and i.status = 1 group by i.fromopenid) t4 on t4.fromopenid = t1.openid "
				+ "left join "
				+ "(select i.fromopenid fromopenid,count(i.fromopenid) num4 "
				+ "from sykj_savings_itemgive i where i.itemid = 'f9aed2e7-9f1e-4dd4-85a2-123456790' "
				+ "and updatedatetime < '"+date+"' and i.status = 2 group by i.fromopenid) t5 on t5.fromopenid = t1.openid "
				+ ") order by t5.num4 desc,t4.num3 desc,t2.num2 desc,t1.num1 desc";
		if(fromNo != 0 || size != 0) {
			sql = sql + " limit " + fromNo + ", " + size;
		}
		return this.findSQL(sql);
	}

	@Override
	public List<Object> exportShopFriend(int fromNo,int size) {
		String sql = "select if(DATE_FORMAT(igu.usetime, '%Y-%m-%d') is null,'',DATE_FORMAT(igu.usetime, '%Y-%m-%d')) date,"
				+ "if(s.shopname is null,'',s.shopname) shopname,"
				+ "if(ui.realname is null,'',ui.realname) staffname,"
				+ "if(count(igu.scaneropenid) is null,0,count(igu.scaneropenid)) num "
				+ "from sykj_savings_itemgiveuse igu left join "
				+ "sykj_savings_itemgive ig on igu.itemgiveid = ig.id "
				+ "left join sykj_area_shop s on igu.shopid = s.id "
				+ "left join sykj_user_userinformation ui on igu.scaneropenid = ui.openid "
				+ "where ig.itemid = 'f9aed2e7-9f1e-4dd4-85a2-123456790' and igu.status = 1 "
				+ "and s.shopname != '例子1121' and s.shopname is not null "
				+ "group by DATE_FORMAT(igu.usetime, '%Y-%m-%d'),igu.scaneropenid "
				+ "order by date desc,shopname desc, num desc ";
		if(fromNo != 0 || size != 0) {
			sql = sql + " limit " + fromNo + ", " + size;
		}
		return this.findSQL(sql);
	}

	@Override
	public List<Object> exportItemGood(String date,int fromNo,int size) {
		String sql = "select if(t.openId is null,'',t.openId) OPENID,"
				+ "if(t5.mobile is null,'',t5.mobile) mobile,"
				+ "if(t1.num1 is null,0,t1.num1) no1,if(t2.num2 is null,0,t2.num2) no2,"
				+ "if(t12.num12 is null,0,t12.num12) no3,if(t13.num13 is null,0,t13.num13) no4,"
				+ "if(t3.num3 is null,0,t3.num3) no5,if(t4.num4 is null,0,t4.num4) no6,"
				+ "if(t8.num8 is null,0,t8.num8) no7,if(t9.num9 is null,0,t9.num9) no8,"
				+ "if(t6.num6 is null,0,t6.num6) no9,if(t7.num7 is null,0,t7.num7) no10,"
				+ "if(t10.num10 is null,0,t10.num10) no11,if(t11.num11 is null,0,t11.num11) no12 from ("
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num1 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = 'acaaae0f-bc0c-4e1a-bb3d-0d0e73f7b26b' "
				+ "and uci.CREATETIME < ('"+date+"') "
				+ "group by uci.openid) t "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num1 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = 'acaaae0f-bc0c-4e1a-bb3d-0d0e73f7b26b' "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid = 'erpfwq' "
				+ "group by uci.openid) t1 on t1.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num2 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = 'acaaae0f-bc0c-4e1a-bb3d-0d0e73f7b26b' "
				+ "and uci.status = 3 "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid = 'erpfwq' "
				+ "group by uci.openid) t2 on t2.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num12 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = 'acaaae0f-bc0c-4e1a-bb3d-0d0e73f7b26b' "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid != 'erpfwq' "
				+ "group by uci.openid) t12 on t12.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num13 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = 'acaaae0f-bc0c-4e1a-bb3d-0d0e73f7b26b' "
				+ "and uci.status = 3 "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid != 'erpfwq' "
				+ "group by uci.openid) t13 on t13.openid = t12.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num3 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f3c3f' "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid = 'erpzpq' "
				+ "group by uci.openid) t3 on t3.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num4 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f3c3f' "
				+ "and uci.status = 3 "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid = 'erpzpq' "
				+ "group by uci.openid) t4 on t4.openid = t3.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num8 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f3c3f' "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid != 'erpzpq' "
				+ "group by uci.openid) t8 on t8.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num9 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f3c3f' "
				+ "and uci.status = 3 "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid != 'erpzpq' "
				+ "group by uci.openid) t9 on t9.openid = t8.openid left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num6 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f4211' "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid = 'erpzpq' "
				+ "group by uci.openid) t6 on t6.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num7 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f4211' "
				+ "and uci.status = 3 "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid = 'erpzpq' "
				+ "group by uci.openid) t7 on t7.openid = t6.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num10 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f4211' "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid != 'erpzpq' "
				+ "group by uci.openid) t10 on t10.openid = t.openid "
				+ "left join "
				+ "(select uci.openid openid ,COUNT(uci.OPENID) num11 "
				+ "from sykj_savings_usercarditem uci "
				+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f4211' "
				+ "and uci.status = 3 "
				+ "and uci.CREATETIME < ('"+date+"') and uci.usercardid != 'erpzpq' "
				+ "group by uci.openid) t11 on t11.openid = t10.openid "
				+ "left join "
				+ "(select u.openid openid,u.mobile mobile from sykj_user_userinformation u) t5 on t5.openid = t.openid "
				+ ") order by no2 desc,no1 desc,no4 desc,no3 desc,no6 desc,no5 desc,"
				+ "no8 desc,no7 desc,no10 desc,no9 desc,no12 desc,no11 desc";
		if(fromNo != 0 || size != 0) {
			sql = sql + " limit " + fromNo + ", " + size;
		}
		return this.findSQL(sql);
	}

	@Override
	public List<Object> exportShopItemGood(String type,int fromNo,int size) {
		String sql = "";
		if("fuwu".equals(type) || type == "fuwu") {
			sql = "select if(DATE_FORMAT(igu.usetime, '%Y-%m-%d') is null,'',DATE_FORMAT(igu.usetime, '%Y-%m-%d')) date,"
					+ "if(s.shopName is null,'',s.shopName) shopName,"
					+ "if(ui.realname is null,'',ui.realname) realname,"
					+ "if(count(igu.scaneropenid) is null,0,count(igu.scaneropenid)) num,"
					+ "if(uci.usercardid = 'erpfwq','线下','线上') status,'服务券' as cardType "
					+ "from sykj_savings_itemgiveuse igu "
					+ "inner join sykj_savings_usercarditem uci on uci.id = igu.itemgiveId "
					+ "inner join sykj_area_shop s on s.id = igu.shopId "
					+ "inner join sykj_user_userinformation ui on igu.scaneropenid = ui.openid "
					+ "where uci.itemid = 'acaaae0f-bc0c-4e1a-bb3d-0d0e73f7b26b' "
					+ "and igu.status = 1 and s.shopname != '例子1121' "
					+ "group by DATE_FORMAT(igu.usetime, '%Y-%m-%d'),igu.scaneropenid,uci.usercardid "
					+ "order by date desc,shopName desc , num desc,status desc";
		}else if("goodOne".equals(type) || type == "goodOne") {
			sql = "select if(DATE_FORMAT(igu.usetime, '%Y-%m-%d') is null,'',DATE_FORMAT(igu.usetime, '%Y-%m-%d')) date,"
					+ "if(s.shopName is null,'',s.shopName) shopName,"
					+ "if(ui.realname is null,'',ui.realname) realname,"
					+ "if(count(igu.scaneropenid) is null,0,count(igu.scaneropenid)) num,"
					+ "if(uci.usercardid = 'erpzpq','线下','线上') status,'348产品券' as cardType "
					+ "from sykj_savings_itemgiveuse igu "
					+ "inner join sykj_savings_usercarditem uci on uci.id = igu.itemgiveId "
					+ "inner join sykj_area_shop s on s.id = igu.shopId "
					+ "inner join sykj_user_userinformation ui on igu.scaneropenid = ui.openid "
					+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f3c3f' "
					+ "and igu.status = 1 and s.shopname != '例子1121' "
					+ "group by DATE_FORMAT(igu.usetime, '%Y-%m-%d'), igu.scaneropenid,uci.usercardid "
					+ "order by date desc,shopName desc , num desc,status desc";
		}else {
			sql = "select if(DATE_FORMAT(igu.usetime, '%Y-%m-%d') is null,'',DATE_FORMAT(igu.usetime, '%Y-%m-%d')) date,"
					+ "if(s.shopName is null,'',s.shopName) shopName,"
					+ "if(ui.realname is null,'',ui.realname) realname,"
					+ "if(count(igu.scaneropenid) is null,0,count(igu.scaneropenid)) num,"
					+ "if(uci.usercardid = 'erpzpq','线下','线上') status,'108产品券' as cardType "
					+ "from sykj_savings_itemgiveuse igu "
					+ "inner join sykj_savings_usercarditem uci on uci.id = igu.itemgiveId "
					+ "inner join sykj_area_shop s on s.id = igu.shopId "
					+ "inner join sykj_user_userinformation ui on igu.scaneropenid = ui.openid "
					+ "where uci.ITEMID = '1f7f9021-20e3-40ef-ac36-f754dc4f4211' and igu.status = 1 and s.shopname != '例子1121' "
					+ "group by DATE_FORMAT(igu.usetime, '%Y-%m-%d') ,igu.scaneropenid,uci.usercardid "
					+ "order by date desc,shopName desc , num desc,status desc";
		}
		if(fromNo != 0 || size != 0) {
			sql = sql + " limit " + fromNo + ", " + size;
		}
		return this.findSQL(sql);
	}
}
