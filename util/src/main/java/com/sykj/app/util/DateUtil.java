package com.sykj.app.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 日期工具类
 * 
 * 
 * 
 */
public class DateUtil {

	/**
	 * 将Date类型转换为字符串
	 * 
	 * @param date
	 *            日期类型
	 * @return 日期字符串
	 */
	public static String format(Date date) {
		return format(date, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 将Date类型转换为字符串(保留日期)
	 * 
	 * @param date
	 *            日期类型
	 * @return 日期字符串
	 */
	public static String formatDay(Date date) {
		return format(date, "yyyy-MM-dd");
	}
	/**
	 * 将Date类型转换为字符串(保留月份)
	 * 
	 * @param date
	 *            日期类型
	 * @return 日期字符串
	 */
	public static String formatMonth(Date date) {
		return format(date, "yyyy-MM");
	}
	/**
	 * 将Date类型转换为字符串
	 * 
	 * @param date
	 *            日期类型
	 * @param pattern
	 *            字符串格式
	 * @return 日期字符串
	 */
	public static String format(Date date, String pattern) {
		if (date == null) {
			return "null";
		}
		if (pattern == null || pattern.equals("") || pattern.equals("null")) {
			pattern = "yyyy-MM-dd HH:mm:ss";
		}
		return new java.text.SimpleDateFormat(pattern).format(date);
	}
	/**
	 * 将Date类型转换为字符串(保留日期)
	 * 
	 * @param date
	 *            日期类型
	 * @param pattern
	 *            字符串格式
	 * @return 日期字符串
	 */
	public static String formatDay(Date date, String pattern) {
		if (date == null) {
			return "null";
		}
		if (pattern == null || pattern.equals("") || pattern.equals("null")) {
			pattern = "yyyy-MM-dd";
		}
		return new java.text.SimpleDateFormat(pattern).format(date);
	}

	/**
	 * 将字符串转换为Date类型
	 * 
	 * @param date
	 *            字符串类型
	 * @return 日期类型
	 */
	public static Date format(String date) {
		return format(date, null);
	}
	
	/**
	 * 将字符串转换为Date类型（以天为单位）
	 * 
	 * @param date
	 *            字符串类型
	 * @return 日期类型
	 */
	public static Date formatDay(String date) {
		return formatDay(date, null);
	}

	/**
	 * 将字符串转换为Date类型
	 * 
	 * @param date
	 *            字符串类型
	 * @param pattern
	 *            格式
	 * @return 日期类型
	 */
	public static Date format(String date, String pattern) {
		if (pattern == null || pattern.equals("") || pattern.equals("null")) {
			pattern = "yyyy-MM-dd HH:mm:ss";
		}
		if (date == null || date.equals("") || date.equals("null")) {
			return new Date();
		}
		Date d = null;
		try {
			d = new java.text.SimpleDateFormat(pattern).parse(date);
		} catch (ParseException pe) {
		}
		return d;
	}
	
	/**
	 * 将字符串转换为Date类型（以天为单位）
	 * 
	 * @param date
	 *            字符串类型
	 * @param pattern
	 *            格式
	 * @return 日期类型
	 */
	public static Date formatDay(String date, String pattern) {
		if (pattern == null || pattern.equals("") || pattern.equals("null")) {
			pattern = "yyyy-MM-dd";
		}
		if (date == null || date.equals("") || date.equals("null")) {
			return new Date();
		}
		Date d = null;
		try {
			d = new java.text.SimpleDateFormat(pattern).parse(date);
		} catch (ParseException pe) {
		}
		return d;
	}
	
	/**
	 * 返回当前时间
	 * @return
	 */
	public static Timestamp getCurrentTimestamp(){
		
		Date date =new Date();
		Timestamp ts = new Timestamp(date.getTime());
		
		return ts;
	}
	
	/**
	 * 字符串的日期格式的计算
	 */
	public static int daysBetween(String smdate, String bdate)
			throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(smdate));
		long time1 = cal.getTimeInMillis();
		cal.setTime(sdf.parse(bdate));
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);


		return Integer.parseInt(String.valueOf(between_days));
	}
	
	/**
	 * 字符串的日期格式的计算(小时差)
	 */
	public static int hourBetween(String smdate, String bdate) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(smdate));
		long time1 = cal.getTimeInMillis();
		cal.setTime(sdf.parse(bdate));
		long time2 = cal.getTimeInMillis();
		
		long between_hour = (time2 - time1) / (1000 * 3600 );
		return Integer.parseInt(String.valueOf(between_hour));
	}
	
	public static double hourCha(String smdate, String bdate){
		Date date = format(smdate, "yyyy-MM-dd HH:mm:ss");
		Date date2 = format(bdate, "yyyy-MM-dd HH:mm:ss");
		Calendar c1 = Calendar.getInstance();
		c1.setTime(date);
		double time1 = c1.getTimeInMillis();
		c1.setTime(date2);
		double time2 = c1.getTimeInMillis();
		double between_hour = (time2 - time1) / (1000 * 3600 );
		return between_hour;
	}
	
	/**
	 * 返回当天日期的后几天 
	 */
	public static String getDaysAdd(String dateStr,int day){
		String newDate=null;
		Date date = new Date();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(calendar.DATE, day);//把日期往后推一天，整数往后退，负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		newDate = DateUtil.format(date,"yyyy-MM-dd");
		return newDate;
	}
	
	/**
	 * 往后推一天的日期
	 */
	public static String getDaysAddOne(String dateStr,int day){
		String newDate=null;
		Date date = formatDay(dateStr);
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(calendar.DATE, day);//把日期往后推一天，整数往后退，负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		newDate = DateUtil.format(date,"yyyy-MM-dd");
		return newDate;
	}
	
	/**
	 * 延迟月数
	 */
	public static Date getTimeAddMonth(int month){
		Date d = new Date();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(d);
		calendar.add(calendar.MONTH, month);
		d = calendar.getTime();
		return d;
	}
	
	/**
	 * 获得下个月的天数
	 * @return
	 */
	public static int getnextMonthDays(){
		Calendar time=Calendar.getInstance(); 
		time.set(Calendar.MONTH,time.get(Calendar.MONTH) );//Calendar对象默认一月为0 
		
		int day=time.getActualMaximum(Calendar.DAY_OF_MONTH);//本月份的天数
		return day;
	}
	/**
	 * 获得下个月时间（yyyy-mm）
	 * @return
	 */
	public static String getnextMonth(){
		Calendar time=Calendar.getInstance(); 
		String m="";
//		int month = time.get(Calendar.MONTH) + 1;//本月
		int month = time.get(Calendar.MONTH) + 2;//下一月
		int year = time.get(Calendar.YEAR);
		if(month>12){
			year++;
			month=1;
		}
		if(month<10){
			m="0"+month;
		}else{
			m=""+month;
		}
		String date = year+"-"+m;
		return date;
	}
	
	public static void timeInMillis(){
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		long time1 = cal.getTimeInMillis();
		String str = String.format("%tF %<tT", time1);
	    System.out.println(time1+"*"+str);
	}
	
	public static void main(String[ ] arg) throws ParseException{ 
//		for(int i=0;i<=10;i++){
//			timeInMillis();
//		}
		
		System.out.println(formatDay("2015-05-04 19:20","yyyy-MM-dd HH:mm"));
		
		System.out.println(format(new Date(), "dd/MM/yyyy"));
	}
	
	public static boolean calDate(Date start, Date end) throws Exception { 
        long cha = end.getTime() - start.getTime(); 
        double result = cha * 1.0 / (1000 * 60 * 60); 
        if(result<=24){ 
             //System.out.println("可用");   
             return false; 
        }else{ 
             //System.out.println("已过期");  
             return true; 
        } 
    } 
	
	public static boolean calDate(Date start,Date end,int hour){
		long cha = end.getTime() - start.getTime();
		double result = cha * 1.0 / (1000 * 60 * 60);
		if (result <= hour) {//小时
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 *	若干天后的日期yyyy-mm-dd hh:mm:ss
	 */
	public static String calDateInSomeDays(Date start,int days){
		java.util.Calendar rightNow = java.util.Calendar.getInstance();
		java.text.SimpleDateFormat sim = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		rightNow.add(java.util.Calendar.DAY_OF_MONTH, days);   
		//rightNow.add(java.util.Calendar.DAY_OF_MONTH, -3);
		String date = sim.format(rightNow.getTime()); 
		return date;
	}
	
	/**
	 * 获取每月第一天
	 * @return
	 */
	public static String getFirstDay() {
		Calendar cale = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        // 获取前月的第一天  
        cale = Calendar.getInstance();  
        cale.add(Calendar.MONTH, 0);  
        cale.set(Calendar.DAY_OF_MONTH, 1);  
        String firstday = format.format(cale.getTime());
        return firstday;
	}
	
	/**
	 * 获取距离当前月度第i个月的第一天
	 * 如：当前是2016年9月，getFirstDay(2)获取到2016年11月1日；
	 * getFirstDay(-1)获取到2016年8月1日
	 * @return
	 */
	public static String getFirstDay(int i) {
		Calendar cale = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        // 获取前月的第一天  
        cale = Calendar.getInstance();  
        cale.add(Calendar.MONTH, i);  
        cale.set(Calendar.DAY_OF_MONTH, 1);  
        String firstday = format.format(cale.getTime());
        return firstday;
	}
	
	public static int getMonth(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int month = cal.get(Calendar.MONTH);
		return month+1;
	}
	/**
	 * 根据月份获取第一天
	 * @param i
	 * @return
	 */
	public static String getFirstDayByMonth(int year,int month) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        calendar.set(Calendar.MONTH, month-1);
        calendar.set(Calendar.YEAR, year);
        int minday =calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
        calendar.set(Calendar.DAY_OF_MONTH, minday);
        String firstday = format.format(calendar.getTime());
        return firstday;
	}
	/**
	 * 根据月份获取最后一天
	 * @param i
	 * @return
	 */
	public static String getLastDayByMonth(int year,int month) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        calendar.set(Calendar.MONTH, month-1);
        calendar.set(Calendar.YEAR, year);
        int maxday =calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        calendar.set(Calendar.DAY_OF_MONTH, maxday);
        String firstday = format.format(calendar.getTime());
        return firstday;
	}
}
