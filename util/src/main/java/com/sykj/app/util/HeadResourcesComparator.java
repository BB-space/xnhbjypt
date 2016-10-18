package com.sykj.app.util;

import java.util.Comparator;

import com.sykj.app.entity.hqsystem.HeadResources;

/**
 * 资源排序
 * 
 * 
 * 
 */
public class HeadResourcesComparator implements Comparator<HeadResources> {



	public int compare(HeadResources o1, HeadResources o2) {
		int i1 = o1.getSeq() != null ? o1.getSeq().intValue() : -1;
		int i2 = o2.getSeq() != null ? o2.getSeq().intValue() : -1;

		return i1 - i2;
	}

}
