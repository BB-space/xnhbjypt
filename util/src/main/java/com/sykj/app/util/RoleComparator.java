package com.sykj.app.util;

import java.util.Comparator;

import com.sykj.app.entity.system.Role;

/**
 * 角色排序
 * 
 * 
 * 
 */
public class RoleComparator implements Comparator<Role> {



	public int compare(Role o1, Role o2) {
		int i1 = o1.getSeq() != null ? o1.getSeq().intValue() : -1;
		int i2 = o2.getSeq() != null ? o2.getSeq().intValue() : -1;

		return i1 - i2;
	}

}
