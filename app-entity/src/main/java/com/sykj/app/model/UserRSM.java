package com.sykj.app.model;

import java.util.List;



/**
 * 用户排班预约对象模型
 * @author swh
 *
 */
public class UserRSM {

	private String userSchedulingStatus;//用户排班状态
	private Integer userReservationCount;//用户预约总和
	private Integer shopReservationCount;//门店预约总和
	private String dateTime;//时间
	
	private Long userSchedulingMorning;//用户本月上早班总天数
	private Long userSchedulingEvening;//用户本月上晚班总天数
	private Long userSchedulingHoliday;//用户本月休假总天数
	
	private String shopSchedulingStatus;//门店排班状态
	private Double userUsedHoliday;//用户本月已使用的休假
	private Double userAvaliableHoliday;//用户本月休假可用天数
	
	private int workingCount;//本月门店工作日总天数
	private int holidayCount;//本月门店休息日总天数
	
	//我的日程
	private String pbStatus;//该天排班状态
	private List listUser;//该天用户预约相关信息
	private List listShop;//该天门店预约相关信息
	private int dayWorkingCount;//该天门店上班人数
	private int dayHolidayCount;//该天门店休假人数
	
	
	public UserRSM(){
		
	}

	public UserRSM(String userSchedulingStatus, Integer userReservationCount,
			Integer shopReservationCount, String dateTime) {
		super();
		this.userSchedulingStatus = userSchedulingStatus;
		this.userReservationCount = userReservationCount;
		this.shopReservationCount = shopReservationCount;
		this.dateTime = dateTime;
	}

	public String getShopSchedulingStatus() {
		return shopSchedulingStatus;
	}

	public void setShopSchedulingStatus(String shopSchedulingStatus) {
		this.shopSchedulingStatus = shopSchedulingStatus;
	}

	public Long getUserSchedulingHoliday() {
		return userSchedulingHoliday;
	}

	public void setUserSchedulingHoliday(Long userSchedulingHoliday) {
		this.userSchedulingHoliday = userSchedulingHoliday;
	}

	public Double getUserUsedHoliday() {
		return userUsedHoliday;
	}

	public void setUserUsedHoliday(Double userUsedHoliday) {
		this.userUsedHoliday = userUsedHoliday;
	}

	public Double getUserAvaliableHoliday() {
		return userAvaliableHoliday;
	}

	public void setUserAvaliableHoliday(Double userAvaliableHoliday) {
		this.userAvaliableHoliday = userAvaliableHoliday;
	}

	public int getDayHolidayCount() {
		return dayHolidayCount;
	}

	public void setDayHolidayCount(int dayHolidayCount) {
		this.dayHolidayCount = dayHolidayCount;
	}

	public String getPbStatus() {
		return pbStatus;
	}

	public void setPbStatus(String pbStatus) {
		this.pbStatus = pbStatus;
	}

	public List getListUser() {
		return listUser;
	}

	public void setListUser(List listUser) {
		this.listUser = listUser;
	}

	public List getListShop() {
		return listShop;
	}

	public void setListShop(List listShop) {
		this.listShop = listShop;
	}

	public int getDayWorkingCount() {
		return dayWorkingCount;
	}

	public void setDayWorkingCount(int dayWorkingCount) {
		this.dayWorkingCount = dayWorkingCount;
	}

	public int getWorkingCount() {
		return workingCount;
	}

	public void setWorkingCount(int workingCount) {
		this.workingCount = workingCount;
	}

	public int getHolidayCount() {
		return holidayCount;
	}

	public void setHolidayCount(int holidayCount) {
		this.holidayCount = holidayCount;
	}

	public Long getUserSchedulingMorning() {
		return userSchedulingMorning;
	}

	public void setUserSchedulingMorning(Long userSchedulingMorning) {
		this.userSchedulingMorning = userSchedulingMorning;
	}

	public Long getUserSchedulingEvening() {
		return userSchedulingEvening;
	}

	public void setUserSchedulingEvening(Long userSchedulingEvening) {
		this.userSchedulingEvening = userSchedulingEvening;
	}

	public String getUserSchedulingStatus() {
		return userSchedulingStatus;
	}

	public void setUserSchedulingStatus(String userSchedulingStatus) {
		this.userSchedulingStatus = userSchedulingStatus;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	public Integer getUserReservationCount() {
		return userReservationCount;
	}

	public void setUserReservationCount(Integer userReservationCount) {
		this.userReservationCount = userReservationCount;
	}

	public Integer getShopReservationCount() {
		return shopReservationCount;
	}

	public void setShopReservationCount(Integer shopReservationCount) {
		this.shopReservationCount = shopReservationCount;
	}
	
	
}
