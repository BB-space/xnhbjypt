package com.sykj.app.util;

import java.util.Comparator;

import com.sykj.app.entity.system.Menu;

/**
 * 菜单排序
 * 
 * 
 * 
 */
public class MenuComparator implements Comparator<Menu> {



	public int compare(Menu o1, Menu o2) {
		int i1 = o1.getSeq() != null ? o1.getSeq().intValue() : -1;
		int i2 = o2.getSeq() != null ? o2.getSeq().intValue() : -1;
		return i1 - i2;
	}

}
