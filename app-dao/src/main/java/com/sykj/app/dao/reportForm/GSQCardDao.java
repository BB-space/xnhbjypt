/**
 * 
 */
package com.sykj.app.dao.reportForm;

import java.util.List;

import com.sykj.app.model.reportForm.GSQCardM;
import com.sykj.common.dao.IBaseDao;

/**
 * @author wjl 2016年1月9日 下午3:05:35
 */
public interface GSQCardDao extends IBaseDao<GSQCardM>{

	/**
	 * 广深琼一卡通数据报表
	 * @param endTime
	 * @param cityName
	 * @return
	 */
	public List<Object> findFormList(String endTime,String cityName);
	
	/**
	 * 珠中佛一卡通数据报表
	 * @param endTime
	 * @param cityName
	 * @return
	 */
	public List<Object> findzzfFormList(String endTime,String cityName);
	
	/**
	 * 12城69、198卡券数据报表
	 * @param beginTime
	 * @param endTime
	 * @param cityName
	 * @return
	 */
	public List<Object> findRoseFormList(String beginTime,String endTime,String cityName);
	
	/**
	 * 北天上西成渝一卡通数据报表
	 * @param endTime
	 * @param cityName
	 * @return
	 */
	public List<Object> findBtsxcyFormList(String endTime,String cityName);
	
	/**
	 * 69购买数据报表
	 * @return
	 */
	public List<Object> roseBuy();
	
	/**
	 * 69增券数据
	 * @return
	 */
	public List<Object> roseSend();
	
	/**
	 * 198购买数据
	 * @return
	 */
	public List<Object> roseBuy_198();
	
	/**
	 * 198赠券数据
	 * @return
	 */
	public List<Object> roseSend_198();
	
	/**
	 * 抽奖人数报表
	 * @return
	 */
	public List<Object> chouJiang();
	
	/**
	 * 绑定人数报表
	 * @return
	 */
	public List<Object> twelve();
	
	/**
	 * 98购买数据
	 * @return
	 */
	public List<Object> buy_98();
	
	/**
	 * 98赠券数据
	 * @return
	 */
	public List<Object> send_98();
}
