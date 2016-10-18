package com.sykj.app.model;

import java.util.List;

/**
 * 分页对象
 * @author Administrator
 *
 * @param <T>
 */
public class Pager<T> {
	/**
	 * 分页的大小
	 */
	private Integer numPerPage;
	/**
	 * 分页的起始页
	 */
	private Integer currentPage;
	/**
	 * 总页数
	 */
	private Integer pageNumShown;
	/**
	 * 总记录数
	 */
	private long totalCount;
	/**
	 * 分页的数据
	 */
	private List<T> datas;
	
	public Integer getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(Integer numPerPage) {
		this.numPerPage = numPerPage;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public long getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
		  int temp = 0;
		  if(totalCount % this.numPerPage != 0){
		   temp++;
		  }
		  this.pageNumShown = (int) (totalCount / this.numPerPage + temp);
		
	}
	public List<T> getDatas() {
		return datas;
	}
	public void setDatas(List<T> datas) {
		this.datas = datas;
	}
	public Integer getPageNumShown() {
		return pageNumShown;
	}
	public void setPageNumShown(Integer pageNumShown) {
		this.pageNumShown = pageNumShown;
	}
	
	
}
