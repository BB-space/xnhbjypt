/**
 * 
 */
package com.sykj.app.service.reportForm.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.reportForm.GSQCardDao;
import com.sykj.app.model.reportForm.ChouJiangM;
import com.sykj.app.model.reportForm.GSQCardM;
import com.sykj.app.model.reportForm.RoseBuyM;
import com.sykj.app.model.reportForm.RoseCardM;
import com.sykj.app.model.reportForm.RoseSendM;
import com.sykj.app.model.reportForm.ShopCityM;
import com.sykj.app.model.reportForm.TwelveM;
import com.sykj.app.model.reportForm.ZZFCardM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.reportForm.GSQCardService;
import com.sykj.app.util.DateUtil;

/**
 * @author wjl 2016年1月9日 下午3:04:40
 */
@Service("gsqCardService")
public class GSQCardServiceImpl extends BaseServiceImpl implements GSQCardService{

	@Resource
	private GSQCardDao gsqCardDao;
	
	@Override
	public Map<String, List<GSQCardM>> makeForm(String endTime,List<String> strList) {
		// TODO Auto-generated method stub
		Map<String,List<GSQCardM>> map = new HashMap<String,List<GSQCardM>>();
		List<GSQCardM> list1 = new ArrayList<GSQCardM>();
		List<GSQCardM> list2 = new ArrayList<GSQCardM>();
		List<GSQCardM> list3 = new ArrayList<GSQCardM>();
		List<GSQCardM> list4 = new ArrayList<GSQCardM>();
		List<GSQCardM> list5 = new ArrayList<GSQCardM>();
		List<GSQCardM> list6 = new ArrayList<GSQCardM>();
		
		for(String str : strList) {
			System.out.println("-------------------------------------------------");
			System.out.println("str="+str);
			List<Object> list = gsqCardDao.findFormList(endTime, str);
			for(Object object : list) {
				Object[] obj = (Object[])object;
				GSQCardM m = new GSQCardM();
				m.setNowDate(DateUtil.getDaysAdd(null,-1));
				m.setShopName(obj[0].toString());
				m.setLineCardNum1(Integer.valueOf(obj[1].toString()));
				m.setLineCardNum2(Integer.valueOf(obj[2].toString()));
				m.setOnLineCardNum(Integer.valueOf(obj[3].toString()));
				m.setFriendNum1(Integer.valueOf(obj[4].toString()));
				m.setFriendNum2(Integer.valueOf(obj[5].toString()));
				m.setFriendNum3(Integer.valueOf(obj[6].toString()));
				m.setLuckDrawNum1(Integer.valueOf(obj[7].toString()));
				m.setLuckDrawNum2(Integer.valueOf(obj[8].toString()));
				m.setFriendNum4(Integer.valueOf(obj[9].toString()));
				m.setOnLineCardNum2(Integer.valueOf(obj[10].toString()));
				if("广州市".equals(str) || "天津市".equals(str)){
					list2.add(m);
				}else if("深圳市".equals(str) || "北京市".equals(str)){
					list1.add(m);
				}else if("海口市".equals(str) || "上海市".equals(str)){
					list3.add(m);
				}else if("西安市".equals(str)) {
					list4.add(m);
				}else if("成都市".equals(str)) {
					list5.add(m);
				}else if("重庆市".equals(str)) {
					list6.add(m);
				}
			}
		}
		map.put("0",list1);
		map.put("1",list2);
		map.put("2",list3);
		if(list4.size() > 0 && list5.size() > 0 && list6.size() > 0) {
			map.put("3", list4);
			map.put("4", list5);
			map.put("5", list6);
		}
		return map;
	}

	@Override
	public Map<String, List<ZZFCardM>> zzfForm(String endTime,List<String> strList) {
		// TODO Auto-generated method stub
		Map<String,List<ZZFCardM>> map = new HashMap<String,List<ZZFCardM>>();
		List<ZZFCardM> list1 = new ArrayList<ZZFCardM>();
		List<ZZFCardM> list2 = new ArrayList<ZZFCardM>();
		List<ZZFCardM> list3 = new ArrayList<ZZFCardM>();
		for(String str : strList) {
			System.out.println("-------------------------------------------------");
			System.out.println("str="+str);
			List<Object> list = gsqCardDao.findzzfFormList(endTime, str);
			for(Object object : list) {
				Object[] obj = (Object[])object;
				ZZFCardM m = new ZZFCardM();
				m.setNowDate(DateUtil.getDaysAdd(null,-1));
				m.setShopName(obj[0].toString());
				m.setLineCardNum1(Integer.valueOf(obj[1].toString()));
				m.setLineCardNum2(Integer.valueOf(obj[2].toString()));
				m.setOnLineCardNum(Integer.valueOf(obj[3].toString()));
				m.setFriendNum1(Integer.valueOf(obj[4].toString()));
				m.setFriendNum2(Integer.valueOf(obj[5].toString()));
				m.setFriendNum3(Integer.valueOf(obj[6].toString()));
				m.setFriendNum4(Integer.valueOf(obj[7].toString()));
				m.setOnLineCardNum2(Integer.valueOf(obj[8].toString()));
				if("中山市".equals(str)){
					list2.add(m);
				}else if("珠海市".equals(str)){
					list1.add(m);
				}else if("佛山市".equals(str)){
					list3.add(m);
				}
			}
		}
		map.put("0",list1);
		map.put("1",list2);
		map.put("2",list3);
		return map;
	}

	@Override
	public Map<String, List<RoseCardM>> roseForm(String beginTime,String endTime, List<String> strList) {
		// TODO Auto-generated method stub
		Map<String,List<RoseCardM>> map = new HashMap<String,List<RoseCardM>>();
		List<RoseCardM> list1 = new ArrayList<RoseCardM>();
		List<RoseCardM> list2 = new ArrayList<RoseCardM>();
		List<RoseCardM> list3 = new ArrayList<RoseCardM>();
		List<RoseCardM> list4 = new ArrayList<RoseCardM>();
		List<RoseCardM> list5 = new ArrayList<RoseCardM>();
		List<RoseCardM> list6 = new ArrayList<RoseCardM>();
		List<RoseCardM> list7 = new ArrayList<RoseCardM>();
		List<RoseCardM> list8 = new ArrayList<RoseCardM>();
		List<RoseCardM> list9 = new ArrayList<RoseCardM>();
		List<RoseCardM> list10 = new ArrayList<RoseCardM>();
		List<RoseCardM> list11 = new ArrayList<RoseCardM>();
		List<RoseCardM> list12 = new ArrayList<RoseCardM>();
		for(String str : strList) {
			System.out.println("-------------------------------------------------");
			System.out.println("str="+str);
			List<Object> list = gsqCardDao.findRoseFormList(beginTime, endTime, str);
			for(Object object : list) {
				Object[] obj = (Object[])object;
				RoseCardM m = new RoseCardM();
				m.setNowDate(obj[0].toString());
				m.setBanding(Integer.valueOf(obj[1].toString()));
				m.setLuckDraw(Integer.valueOf(obj[2].toString()));
				m.setOnLine69(Integer.valueOf(obj[3].toString()));
				m.setLine69(Integer.valueOf(obj[4].toString()));
				m.setGive(Integer.valueOf(obj[5].toString()));
				m.setSend69(Integer.valueOf(obj[6].toString()));
				m.setUse69(Integer.valueOf(obj[7].toString()));
				m.setOnLine198(Integer.valueOf(obj[8].toString()));
				m.setLine198(Integer.valueOf(obj[9].toString()));
				m.setSend198(Integer.valueOf(obj[10].toString()));
				m.setUse198(Integer.valueOf(obj[11].toString()));
				if("珠海市".equals(str)){
					list1.add(m);
				}else if("中山市".equals(str)){
					list2.add(m);
				}else if("佛山市".equals(str)){
					list3.add(m);
				}else if("广州市".equals(str)){
					list4.add(m);
				}else if("深圳市".equals(str)){
					list5.add(m);
				}else if("海口市".equals(str)){
					list6.add(m);
				}else if("北京市".equals(str)){
					list7.add(m);
				}else if("天津市".equals(str)){
					list8.add(m);
				}else if("上海市".equals(str)){
					list9.add(m);
				}else if("西安市".equals(str)){
					list10.add(m);
				}else if("成都市".equals(str)){
					list11.add(m);
				}else if("重庆市".equals(str)){
					list12.add(m);
				}
				
			}
		}
		map.put("0",list1);
		map.put("1",list2);
		map.put("2",list3);
		map.put("3",list4);
		map.put("4",list5);
		map.put("5",list6);
		map.put("6",list7);
		map.put("7",list8);
		map.put("8",list9);
		map.put("9",list10);
		map.put("10",list11);
		map.put("11",list12);
		return map;
	}
	
	@Override
	public Map<String, List<GSQCardM>> btsxcyForm(String endTime,List<String> strList) {
		// TODO Auto-generated method stub
		Map<String,List<GSQCardM>> map = new HashMap<String,List<GSQCardM>>();
		List<GSQCardM> list1 = new ArrayList<GSQCardM>();
		List<GSQCardM> list2 = new ArrayList<GSQCardM>();
		List<GSQCardM> list3 = new ArrayList<GSQCardM>();
		List<GSQCardM> list4 = new ArrayList<GSQCardM>();
		List<GSQCardM> list5 = new ArrayList<GSQCardM>();
		List<GSQCardM> list6 = new ArrayList<GSQCardM>();
		
		for(String str : strList) {
			System.out.println("-------------------------------------------------");
			System.out.println("str="+str);
			List<Object> list = gsqCardDao.findBtsxcyFormList(endTime, str);
			for(Object object : list) {
				Object[] obj = (Object[])object;
				GSQCardM m = new GSQCardM();
				m.setNowDate(DateUtil.getDaysAdd(null,-1));
				m.setShopName(obj[0].toString());
				m.setLineCardNum1(Integer.valueOf(obj[1].toString()));
				m.setLineCardNum2(Integer.valueOf(obj[2].toString()));
				m.setOnLineCardNum(Integer.valueOf(obj[3].toString()));
				m.setFriendNum1(Integer.valueOf(obj[4].toString()));
				m.setFriendNum2(Integer.valueOf(obj[5].toString()));
				m.setFriendNum3(Integer.valueOf(obj[6].toString()));
				m.setLuckDrawNum1(Integer.valueOf(obj[7].toString()));
				m.setLuckDrawNum2(Integer.valueOf(obj[8].toString()));
				m.setFriendNum4(Integer.valueOf(obj[9].toString()));
				m.setOnLineCardNum2(Integer.valueOf(obj[10].toString()));
				if("广州市".equals(str) || "天津市".equals(str)){
					list2.add(m);
				}else if("深圳市".equals(str) || "北京市".equals(str)){
					list1.add(m);
				}else if("海口市".equals(str) || "上海市".equals(str)){
					list3.add(m);
				}else if("西安市".equals(str)) {
					list4.add(m);
				}else if("成都市".equals(str)) {
					list5.add(m);
				}else if("重庆市".equals(str)) {
					list6.add(m);
				}
			}
		}
		map.put("0",list1);
		map.put("1",list2);
		map.put("2",list3);
		if(list4.size() > 0 && list5.size() > 0 && list6.size() > 0) {
			map.put("3", list4);
			map.put("4", list5);
			map.put("5", list6);
		}
		return map;
	}

	@Override
	public List<RoseBuyM> roseBuy() {
		// TODO Auto-generated method stub
		List<RoseBuyM> list = new ArrayList<RoseBuyM>();
		List<Object> objList = gsqCardDao.roseBuy();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			RoseBuyM rbm = new RoseBuyM();
			rbm.setTime(obj[0].toString());
			rbm.setZh1(Integer.valueOf(obj[1].toString()));
			rbm.setZs1(Integer.valueOf(obj[3].toString()));
			rbm.setFs1(Integer.valueOf(obj[5].toString()));
			rbm.setGz1(Integer.valueOf(obj[7].toString()));
			rbm.setSz1(Integer.valueOf(obj[9].toString()));
			rbm.setHk1(Integer.valueOf(obj[11].toString()));
			rbm.setBj1(Integer.valueOf(obj[13].toString()));
			rbm.setTj1(Integer.valueOf(obj[15].toString()));
			rbm.setSh1(Integer.valueOf(obj[17].toString()));
			rbm.setXa1(Integer.valueOf(obj[19].toString()));
			rbm.setCd1(Integer.valueOf(obj[21].toString()));
			rbm.setCq1(Integer.valueOf(obj[23].toString()));
			rbm.setZh2(Integer.valueOf(obj[2].toString()));
			rbm.setZs2(Integer.valueOf(obj[4].toString()));
			rbm.setFs2(Integer.valueOf(obj[6].toString()));
			rbm.setGz2(Integer.valueOf(obj[8].toString()));
			rbm.setSz2(Integer.valueOf(obj[10].toString()));
			rbm.setHk2(Integer.valueOf(obj[12].toString()));
			rbm.setBj2(Integer.valueOf(obj[14].toString()));
			rbm.setTj2(Integer.valueOf(obj[16].toString()));
			rbm.setSh2(Integer.valueOf(obj[18].toString()));
			rbm.setXa2(Integer.valueOf(obj[20].toString()));
			rbm.setCd2(Integer.valueOf(obj[22].toString()));
			rbm.setCq2(Integer.valueOf(obj[24].toString()));
			list.add(rbm);
		}
		return list;
	}

	@Override
	public List<RoseSendM> roseSend() {
		// TODO Auto-generated method stub
		List<RoseSendM> list = new ArrayList<RoseSendM>();
		List<Object> objList = gsqCardDao.roseSend();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			RoseSendM rsm = new RoseSendM();
			rsm.setTime(obj[0].toString());
			rsm.setZh1(Integer.valueOf(obj[1].toString()));
			rsm.setZs1(Integer.valueOf(obj[2].toString()));
			rsm.setFs1(Integer.valueOf(obj[3].toString()));
			rsm.setGz1(Integer.valueOf(obj[4].toString()));
			rsm.setSz1(Integer.valueOf(obj[5].toString()));
			rsm.setHk1(Integer.valueOf(obj[6].toString()));
			rsm.setBj1(Integer.valueOf(obj[7].toString()));
			rsm.setTj1(Integer.valueOf(obj[8].toString()));
			rsm.setSh1(Integer.valueOf(obj[9].toString()));
			rsm.setXa1(Integer.valueOf(obj[10].toString()));
			rsm.setCd1(Integer.valueOf(obj[11].toString()));
			rsm.setCq1(Integer.valueOf(obj[12].toString()));
			rsm.setZh2(Integer.valueOf(obj[13].toString()));
			rsm.setZs2(Integer.valueOf(obj[14].toString()));
			rsm.setFs2(Integer.valueOf(obj[15].toString()));
			rsm.setGz2(Integer.valueOf(obj[16].toString()));
			rsm.setSz2(Integer.valueOf(obj[17].toString()));
			rsm.setHk2(Integer.valueOf(obj[18].toString()));
			rsm.setBj2(Integer.valueOf(obj[19].toString()));
			rsm.setTj2(Integer.valueOf(obj[20].toString()));
			rsm.setSh2(Integer.valueOf(obj[21].toString()));
			rsm.setXa2(Integer.valueOf(obj[22].toString()));
			rsm.setCd2(Integer.valueOf(obj[23].toString()));
			rsm.setCq2(Integer.valueOf(obj[24].toString()));
			rsm.setZh3(Integer.valueOf(obj[25].toString()));
			rsm.setZs3(Integer.valueOf(obj[26].toString()));
			rsm.setFs3(Integer.valueOf(obj[27].toString()));
			rsm.setGz3(Integer.valueOf(obj[28].toString()));
			rsm.setSz3(Integer.valueOf(obj[29].toString()));
			rsm.setHk3(Integer.valueOf(obj[30].toString()));
			rsm.setBj3(Integer.valueOf(obj[31].toString()));
			rsm.setTj3(Integer.valueOf(obj[32].toString()));
			rsm.setSh3(Integer.valueOf(obj[33].toString()));
			rsm.setXa3(Integer.valueOf(obj[34].toString()));
			rsm.setCd3(Integer.valueOf(obj[35].toString()));
			rsm.setCq3(Integer.valueOf(obj[36].toString()));
			list.add(rsm);
		}
		return list;
	}

	@Override
	public List<RoseBuyM> roseBuy_198() {
		// TODO Auto-generated method stub
		List<RoseBuyM> list = new ArrayList<RoseBuyM>();
		List<Object> objList = gsqCardDao.roseBuy_198();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			RoseBuyM rbm = new RoseBuyM();
			rbm.setTime(obj[0].toString());
			rbm.setZh1(Integer.valueOf(obj[1].toString()));
			rbm.setZs1(Integer.valueOf(obj[3].toString()));
			rbm.setFs1(Integer.valueOf(obj[5].toString()));
			rbm.setGz1(Integer.valueOf(obj[7].toString()));
			rbm.setSz1(Integer.valueOf(obj[9].toString()));
			rbm.setHk1(Integer.valueOf(obj[11].toString()));
			rbm.setBj1(Integer.valueOf(obj[13].toString()));
			rbm.setTj1(Integer.valueOf(obj[15].toString()));
			rbm.setSh1(Integer.valueOf(obj[17].toString()));
			rbm.setXa1(Integer.valueOf(obj[19].toString()));
			rbm.setCd1(Integer.valueOf(obj[21].toString()));
			rbm.setCq1(Integer.valueOf(obj[23].toString()));
			rbm.setZh2(Integer.valueOf(obj[2].toString()));
			rbm.setZs2(Integer.valueOf(obj[4].toString()));
			rbm.setFs2(Integer.valueOf(obj[6].toString()));
			rbm.setGz2(Integer.valueOf(obj[8].toString()));
			rbm.setSz2(Integer.valueOf(obj[10].toString()));
			rbm.setHk2(Integer.valueOf(obj[12].toString()));
			rbm.setBj2(Integer.valueOf(obj[14].toString()));
			rbm.setTj2(Integer.valueOf(obj[16].toString()));
			rbm.setSh2(Integer.valueOf(obj[18].toString()));
			rbm.setXa2(Integer.valueOf(obj[20].toString()));
			rbm.setCd2(Integer.valueOf(obj[22].toString()));
			rbm.setCq2(Integer.valueOf(obj[24].toString()));
			list.add(rbm);
		}
		return list;
	}

	@Override
	public List<RoseBuyM> roseSend_198() {
		// TODO Auto-generated method stub
		List<RoseBuyM> list = new ArrayList<RoseBuyM>();
		List<Object> objList = gsqCardDao.roseSend_198();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			RoseBuyM rbm = new RoseBuyM();
			rbm.setTime(obj[0].toString());
			rbm.setZh1(Integer.valueOf(obj[1].toString()));
			rbm.setZs1(Integer.valueOf(obj[3].toString()));
			rbm.setFs1(Integer.valueOf(obj[5].toString()));
			rbm.setGz1(Integer.valueOf(obj[7].toString()));
			rbm.setSz1(Integer.valueOf(obj[9].toString()));
			rbm.setHk1(Integer.valueOf(obj[11].toString()));
			rbm.setBj1(Integer.valueOf(obj[13].toString()));
			rbm.setTj1(Integer.valueOf(obj[15].toString()));
			rbm.setSh1(Integer.valueOf(obj[17].toString()));
			rbm.setXa1(Integer.valueOf(obj[19].toString()));
			rbm.setCd1(Integer.valueOf(obj[21].toString()));
			rbm.setCq1(Integer.valueOf(obj[23].toString()));
			rbm.setZh2(Integer.valueOf(obj[2].toString()));
			rbm.setZs2(Integer.valueOf(obj[4].toString()));
			rbm.setFs2(Integer.valueOf(obj[6].toString()));
			rbm.setGz2(Integer.valueOf(obj[8].toString()));
			rbm.setSz2(Integer.valueOf(obj[10].toString()));
			rbm.setHk2(Integer.valueOf(obj[12].toString()));
			rbm.setBj2(Integer.valueOf(obj[14].toString()));
			rbm.setTj2(Integer.valueOf(obj[16].toString()));
			rbm.setSh2(Integer.valueOf(obj[18].toString()));
			rbm.setXa2(Integer.valueOf(obj[20].toString()));
			rbm.setCd2(Integer.valueOf(obj[22].toString()));
			rbm.setCq2(Integer.valueOf(obj[24].toString()));
			list.add(rbm);
		}
		return list;
	}

	@Override
	public List<ChouJiangM> chouJiang() {
		// TODO Auto-generated method stub
		List<ChouJiangM> list = new ArrayList<ChouJiangM>();
		List<Object> objList = gsqCardDao.chouJiang();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			ChouJiangM cjm = new ChouJiangM();
			cjm.setTime(obj[0].toString());
			cjm.setZh(Integer.valueOf(obj[1].toString()));
			cjm.setZs(Integer.valueOf(obj[2].toString()));
			cjm.setFs(Integer.valueOf(obj[3].toString()));
			cjm.setGz(Integer.valueOf(obj[4].toString()));
			cjm.setSz(Integer.valueOf(obj[5].toString()));
			cjm.setHk(Integer.valueOf(obj[6].toString()));
			cjm.setBj(Integer.valueOf(obj[7].toString()));
			cjm.setTj(Integer.valueOf(obj[8].toString()));
			cjm.setSh(Integer.valueOf(obj[9].toString()));
			cjm.setXa(Integer.valueOf(obj[10].toString()));
			cjm.setCd(Integer.valueOf(obj[11].toString()));
			cjm.setCq(Integer.valueOf(obj[12].toString()));
			cjm.setOne(Integer.valueOf(obj[13].toString()));
			cjm.setTwo(Integer.valueOf(obj[14].toString()));
			cjm.setThree(Integer.valueOf(obj[15].toString()));
			cjm.setFour(Integer.valueOf(obj[16].toString()));
			cjm.setFive(Integer.valueOf(obj[17].toString()));
			list.add(cjm);
		}
		return list;
	}

	@Override
	public List<TwelveM> twelve() {
		// TODO Auto-generated method stub
		List<TwelveM> list = new ArrayList<TwelveM>();
		List<Object> objList = gsqCardDao.twelve();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			TwelveM tm = new TwelveM();
			tm.setTime(obj[0].toString());
			tm.setZh(Integer.valueOf(obj[1].toString()));
			tm.setZs(Integer.valueOf(obj[2].toString()));
			tm.setFs(Integer.valueOf(obj[3].toString()));
			tm.setGz(Integer.valueOf(obj[4].toString()));
			tm.setSz(Integer.valueOf(obj[5].toString()));
			tm.setHk(Integer.valueOf(obj[6].toString()));
			tm.setBj(Integer.valueOf(obj[7].toString()));
			tm.setTj(Integer.valueOf(obj[8].toString()));
			tm.setSh(Integer.valueOf(obj[9].toString()));
			tm.setXa(Integer.valueOf(obj[10].toString()));
			tm.setCd(Integer.valueOf(obj[11].toString()));
			tm.setCq(Integer.valueOf(obj[12].toString()));
			list.add(tm);
		}
		return list;
	}

	@Override
	public List<RoseBuyM> buy_98() {
		// TODO Auto-generated method stub
		List<RoseBuyM> list = new ArrayList<RoseBuyM>();
		List<Object> objList = gsqCardDao.buy_98();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			RoseBuyM rbm = new RoseBuyM();
			rbm.setTime(obj[0].toString());
			rbm.setZh1(Integer.valueOf(obj[1].toString()));
			rbm.setZs1(Integer.valueOf(obj[3].toString()));
			rbm.setFs1(Integer.valueOf(obj[5].toString()));
			rbm.setGz1(Integer.valueOf(obj[7].toString()));
			rbm.setSz1(Integer.valueOf(obj[9].toString()));
			rbm.setHk1(Integer.valueOf(obj[11].toString()));
			rbm.setBj1(Integer.valueOf(obj[13].toString()));
			rbm.setTj1(Integer.valueOf(obj[15].toString()));
			rbm.setSh1(Integer.valueOf(obj[17].toString()));
			rbm.setXa1(Integer.valueOf(obj[19].toString()));
			rbm.setCd1(Integer.valueOf(obj[21].toString()));
			rbm.setCq1(Integer.valueOf(obj[23].toString()));
			rbm.setZh2(Integer.valueOf(obj[2].toString()));
			rbm.setZs2(Integer.valueOf(obj[4].toString()));
			rbm.setFs2(Integer.valueOf(obj[6].toString()));
			rbm.setGz2(Integer.valueOf(obj[8].toString()));
			rbm.setSz2(Integer.valueOf(obj[10].toString()));
			rbm.setHk2(Integer.valueOf(obj[12].toString()));
			rbm.setBj2(Integer.valueOf(obj[14].toString()));
			rbm.setTj2(Integer.valueOf(obj[16].toString()));
			rbm.setSh2(Integer.valueOf(obj[18].toString()));
			rbm.setXa2(Integer.valueOf(obj[20].toString()));
			rbm.setCd2(Integer.valueOf(obj[22].toString()));
			rbm.setCq2(Integer.valueOf(obj[24].toString()));
			list.add(rbm);
		}
		return list;
	}

	@Override
	public List<RoseBuyM> send_98() {
		// TODO Auto-generated method stub
		List<RoseBuyM> list = new ArrayList<RoseBuyM>();
		List<Object> objList = gsqCardDao.send_98();
		for(Object object : objList) {
			Object[] obj = (Object[])object;
			RoseBuyM rbm = new RoseBuyM();
			rbm.setTime(obj[0].toString());
			rbm.setZh1(Integer.valueOf(obj[1].toString()));
			rbm.setZs1(Integer.valueOf(obj[3].toString()));
			rbm.setFs1(Integer.valueOf(obj[5].toString()));
			rbm.setGz1(Integer.valueOf(obj[7].toString()));
			rbm.setSz1(Integer.valueOf(obj[9].toString()));
			rbm.setHk1(Integer.valueOf(obj[11].toString()));
			rbm.setBj1(Integer.valueOf(obj[13].toString()));
			rbm.setTj1(Integer.valueOf(obj[15].toString()));
			rbm.setSh1(Integer.valueOf(obj[17].toString()));
			rbm.setXa1(Integer.valueOf(obj[19].toString()));
			rbm.setCd1(Integer.valueOf(obj[21].toString()));
			rbm.setCq1(Integer.valueOf(obj[23].toString()));
			rbm.setZh2(Integer.valueOf(obj[2].toString()));
			rbm.setZs2(Integer.valueOf(obj[4].toString()));
			rbm.setFs2(Integer.valueOf(obj[6].toString()));
			rbm.setGz2(Integer.valueOf(obj[8].toString()));
			rbm.setSz2(Integer.valueOf(obj[10].toString()));
			rbm.setHk2(Integer.valueOf(obj[12].toString()));
			rbm.setBj2(Integer.valueOf(obj[14].toString()));
			rbm.setTj2(Integer.valueOf(obj[16].toString()));
			rbm.setSh2(Integer.valueOf(obj[18].toString()));
			rbm.setXa2(Integer.valueOf(obj[20].toString()));
			rbm.setCd2(Integer.valueOf(obj[22].toString()));
			rbm.setCq2(Integer.valueOf(obj[24].toString()));
			list.add(rbm);
		}
		return list;
	}

}
