package com.sykj.app.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class OrderUtil {
	private static long orderNum = 0L;
	private static String date;

	public static String getOrderNo() {
		String str = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
		if (date == null || !date.equals(str)) {
			date = str;
			orderNum = 0l;
		}
		orderNum=new Random().nextInt(10);
		long orderNo = Long.parseLong((date))*100; 
		orderNo += orderNum;
		return orderNo + "";
	}
	
	public static void main(String[] args) {
		String no = OrderUtil.getOrderNo();
		System.out.println(no);
	}
}
