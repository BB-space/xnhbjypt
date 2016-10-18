package com.sykj.app.util;

import java.util.Random;

/**
 * 生成随机数字组合
 * 
 * @author hero
 *
 */
public class GenerateCheckCode {

	public static String getCharAndNum(int length) {
		String val = "";
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";// 输出字母还是数字
			if ("char".equalsIgnoreCase(charOrNum)) {
				int choice = random.nextInt(2) % 2 == 0 ? 65 : 97;// 取得大写字母还是小写字母
				val += (char) (choice + random.nextInt(26));
			} else if ("num".equalsIgnoreCase(charOrNum)) {// 数字
				val += String.valueOf(random.nextInt(10));
			}
		}
		return val;
	}
	
	public static void main(String[] args) {
		GenerateCheckCode g = new GenerateCheckCode();
		
		System.out.println(g.getCharAndNum(8));
	}
}
