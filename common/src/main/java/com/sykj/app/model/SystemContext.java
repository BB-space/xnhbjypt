package com.sykj.app.model;

/**
 * 用来传递列表对象的ThreadLocal数据
 * @author Administrator
 *
 */
public class SystemContext {
	/**
	 * 分页大小
	 */
	private static ThreadLocal<Integer> numPerPage = new ThreadLocal<Integer>();
	/**
	 * 分页的显示页
	 */
	private static ThreadLocal<Integer> pageNum = new ThreadLocal<Integer>();
	/**
	 * 列表的排序字段
	 */
	private static ThreadLocal<String> sort = new ThreadLocal<String>();
	/**
	 * 列表的排序方式
	 */
	private static ThreadLocal<String> order = new ThreadLocal<String>();
	
	private static ThreadLocal<String> realPath = new ThreadLocal<String>();
	
	
	
	public static String getRealPath() {
		return realPath.get();
	}
	public static void setRealPath(String _realPath) {
		SystemContext.realPath.set(_realPath);
	}
	public static Integer getNumPerPage() {
		return numPerPage.get();
	}
	public static void setNumPerPage(Integer _numPerPage) {
		numPerPage.set(_numPerPage);
	}
	public static Integer getPageNum() {
		return pageNum.get();
	}
	public static void setPageNum(Integer _pageNum) {
		pageNum.set(_pageNum);
	}
	public static String getSort() {
		return sort.get();
	}
	public static void setSort(String _sort) {
		SystemContext.sort.set(_sort);
	}
	public static String getOrder() {
		return order.get();
	}
	public static void setOrder(String _order) {
		SystemContext.order.set(_order);
	}
	
	public static void removePageSize() {
		pageNum.remove();
	}
	
	public static void removePageOffset() {
		pageNum.remove();
	}
	
	public static void removeSort() {
		sort.remove();
	}
	
	public static void removeOrder() {
		order.remove();
	}
	
	public static void removeRealPath() {
		realPath.remove();
	}
	
}
