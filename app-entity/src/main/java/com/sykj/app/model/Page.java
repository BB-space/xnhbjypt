package com.sykj.app.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Page implements Serializable{
	private Integer nowPage;//当前页
	private Integer row=10;//每页的条数
	private Integer count;//总数
	
	public Integer getMaxPage(){
		if(count==0){
			return 1;
		}else{
			return count%row==0?count/row:count/row+1;
		}
	}

	public Integer getNowPage() {
		return nowPage;
	}

	public void setNowPage(Integer nowPage) {
		this.nowPage = nowPage;
	}

	public Integer getRow() {
		return row;
	}

	public void setRow(Integer row) {
		this.row = row;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
}
