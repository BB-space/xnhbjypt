package com.sykj.app.service.reportForm.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sykj.app.dao.reportForm.ReportFormDao;
import com.sykj.app.model.reportForm.Friend;
import com.sykj.app.model.reportForm.ItemGood;
import com.sykj.app.model.reportForm.ShopFriend;
import com.sykj.app.model.reportForm.ShopItemGood;
import com.sykj.app.model.reportForm.ShopTen;
import com.sykj.app.model.reportForm.TenAndEighteen;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.reportForm.ReportFormService;
import com.sykj.app.util.DateUtil;

@Service("writeOffRecordService")
public class ReportFormServiceImpl extends BaseServiceImpl implements ReportFormService{

	@Resource
	private ReportFormDao reportFormDao;

	@Override
	public List<TenAndEighteen> exportTenAndEighteens(String type,int page,int rows) {
		String date = DateUtil.format(new Date(),"yyyy-MM-dd 00:00:00");
		List<Object> objList = reportFormDao.exportTenAndEighteen(date,type,(page-1)*rows,rows);
		List<TenAndEighteen> list = new ArrayList<TenAndEighteen>();
		if(objList.size() > 0 && objList != null) {
			for(Object object : objList) {
				TenAndEighteen ten = new TenAndEighteen();
				Object[] obj = (Object[])object;
				ten.setMemberopenid((String)obj[0]);
				ten.setMemberMobile((String)obj[1]);
				ten.setGetNum1(Integer.parseInt(String.valueOf(obj[2])));
				ten.setUseNum1(Integer.parseInt(String.valueOf(obj[3])));
				ten.setType((String)obj[4]);
				list.add(ten);
			}
		}
		return list;
	}

	@Override
	public List<ShopTen> exportShopTen(int page,int rows) {
		List<Object> objList = reportFormDao.exportShopTen((page-1)*rows,rows);
		List<ShopTen> list = new ArrayList<ShopTen>();
		if(objList.size() > 0 && objList != null) {
			for(Object object : objList) {
				ShopTen shopTen = new ShopTen();
				Object[] obj = (Object[])object;
				shopTen.setDate((String)obj[0]);
				shopTen.setShopName((String)obj[1]);
				shopTen.setStaffName((String)obj[2]);
				shopTen.setNum(Integer.parseInt(String.valueOf(obj[3])));
				list.add(shopTen);
			}
		}
		return list;
	}

	@Override
	public List<Friend> exportFriend(int page,int rows) {
		String date = DateUtil.format(new Date(),"yyyy-MM-dd 00:00:00");
		List<Object> objList = reportFormDao.exportFriend(date,(page-1)*rows,rows);
		List<Friend> list = new ArrayList<Friend>();
		if(objList.size() > 0 && objList != null) {
			for(Object object : objList) {
				Friend friend = new Friend();
				Object[] obj = (Object[])object;
				friend.setOpenId((String)obj[0]);
				friend.setMobile((String)obj[1]);
				friend.setGetNum(Integer.parseInt(String.valueOf(obj[2])));
				friend.setGiveNum(Integer.parseInt(String.valueOf(obj[3])));
				friend.setReceiveNum(Math.round(Float.valueOf(String.valueOf(obj[4]))));
				friend.setUseNum(Integer.parseInt(String.valueOf(obj[5])));
				list.add(friend);
			}
		}
		return list;
	}

	@Override
	public List<ShopFriend> exportShopFriend(int page,int rows) {
		List<Object> objList = reportFormDao.exportShopFriend((page-1)*rows,rows);
		List<ShopFriend> list = new ArrayList<ShopFriend>();
		if(objList.size() > 0 && objList != null) {
			for(Object object : objList) {
				ShopFriend shopFriend = new ShopFriend();
				Object[] obj = (Object[])object;
				shopFriend.setDate((String)obj[0]);
				shopFriend.setShopName((String)obj[1]);
				shopFriend.setStaffName((String)obj[2]);
				shopFriend.setNum(Integer.parseInt(String.valueOf(obj[3])));
				list.add(shopFriend);
			}
		}
		return list;
	}

	@Override
	public List<ItemGood> exportItemGood(int page,int rows) {
		String date = DateUtil.format(new Date(),"yyyy-MM-dd 00:00:00");
		List<Object> objList = reportFormDao.exportItemGood(date,(page-1)*rows,rows);
		List<ItemGood> list = new ArrayList<ItemGood>();
		if(objList.size() > 0 && objList != null) {
			for(Object object : objList) {
				ItemGood itemGood = new ItemGood();
				Object[] obj = (Object[])object;
				itemGood.setOpenId((String)obj[0]);
				itemGood.setMobile((String)obj[1]);
				itemGood.setItemNum1(Integer.parseInt(String.valueOf(obj[2])));
				itemGood.setItemNum2(Integer.parseInt(String.valueOf(obj[3])));
				itemGood.setItemNum3(Integer.parseInt(String.valueOf(obj[4])));
				itemGood.setItemNum4(Integer.parseInt(String.valueOf(obj[5])));
				itemGood.setGoodNum1(Integer.parseInt(String.valueOf(obj[6])));
				itemGood.setGoodNum2(Integer.parseInt(String.valueOf(obj[7])));
				itemGood.setGoodNum3(Integer.parseInt(String.valueOf(obj[8])));
				itemGood.setGoodNum4(Integer.parseInt(String.valueOf(obj[9])));
				itemGood.setGoodNum5(Integer.parseInt(String.valueOf(obj[10])));
				itemGood.setGoodNum6(Integer.parseInt(String.valueOf(obj[11])));
				itemGood.setGoodNum7(Integer.parseInt(String.valueOf(obj[12])));
				itemGood.setGoodNum8(Integer.parseInt(String.valueOf(obj[13])));
				list.add(itemGood);
			}
		}
		return list;
	}

	@Override
	public List<ShopItemGood> exportShopItemGood(String type,int page,int rows) {
		List<Object> objList = reportFormDao.exportShopItemGood(type,(page-1)*rows,rows);
		List<ShopItemGood> list = new ArrayList<ShopItemGood>();
		if(objList.size() > 0 && objList != null) {
			for(Object object : objList) {
				ShopItemGood shopItemGood = new ShopItemGood();
				Object[] obj = (Object[])object;
				shopItemGood.setDate((String)obj[0]);
				shopItemGood.setShopName((String)obj[1]);
				shopItemGood.setStaffName((String)obj[2]);
				shopItemGood.setNum(Integer.parseInt(String.valueOf(obj[3])));
				shopItemGood.setStatus((String)obj[4]);
				shopItemGood.setType((String)obj[5]);
				list.add(shopItemGood);
			}
		}
		return list;
	}
}
